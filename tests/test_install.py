import contextlib
import importlib.util
import io
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location("installer", ROOT / "scripts/install.py")
installer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(installer)


class InstallerTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.project = Path(self.temp.name) / "app with spaces"
        self.project.mkdir()

    def run_install(self, agents=None, **kwargs):
        with contextlib.redirect_stdout(io.StringIO()):
            return installer.install(self.project, agents or ["codex"], **kwargs)

    def test_each_agent_receives_complete_package(self):
        for agent, folder in installer.ROOTS.items():
            with self.subTest(agent=agent):
                self.run_install([agent])
                target = self.project / folder / "skills/mobile-paywall"
                self.assertEqual(installer.snapshot(target), installer.snapshot(installer.SOURCE))

    def test_all_deduplicates_shared_discovery_path(self):
        targets = self.run_install(list(installer.ROOTS))
        self.assertEqual(len(targets), 2)
        self.assertFalse((self.project / ".cursor").exists())

    def test_reinstall_is_noop(self):
        target = self.run_install()[0] / "SKILL.md"
        before = target.stat().st_mtime_ns
        self.run_install()
        self.assertEqual(before, target.stat().st_mtime_ns)

    def test_dry_run_does_not_create_directories(self):
        self.run_install(list(installer.ROOTS), dry_run=True)
        self.assertEqual(list(self.project.iterdir()), [])

    def test_modified_skill_is_preserved(self):
        target = self.run_install()[0] / "SKILL.md"
        target.write_text("my custom skill", encoding="utf-8")
        with self.assertRaises(ValueError):
            self.run_install()
        self.assertEqual(target.read_text(), "my custom skill")

    def test_extra_files_are_preserved(self):
        target = self.run_install()[0]
        (target / "custom.txt").write_text("keep")
        with self.assertRaises(ValueError):
            self.run_install()
        self.assertEqual((target / "custom.txt").read_text(), "keep")

    def test_preflight_prevents_partial_install_on_conflict(self):
        target = self.project / ".claude/skills/mobile-paywall"
        target.mkdir(parents=True)
        (target / "SKILL.md").write_text("custom")
        with self.assertRaises(ValueError):
            self.run_install(list(installer.ROOTS))
        self.assertFalse((self.project / ".agents").exists())

    def test_missing_project_is_not_created(self):
        self.project.rmdir()
        with self.assertRaises(ValueError):
            self.run_install()
        self.assertFalse(self.project.exists())

    def test_non_directory_destination_is_preserved(self):
        target = self.project / ".agents"
        target.write_text("keep")
        with self.assertRaises(ValueError):
            self.run_install()
        self.assertEqual(target.read_text(), "keep")

    @unittest.skipIf(sys.platform == "win32", "Creating links may require elevation on Windows")
    def test_symlink_destination_is_rejected(self):
        external = Path(self.temp.name) / "external"
        external.mkdir()
        (self.project / ".agents").symlink_to(external, target_is_directory=True)
        with self.assertRaises(ValueError):
            self.run_install()
        self.assertEqual(list(external.iterdir()), [])

    @unittest.skipIf(sys.platform == "win32", "Creating links may require elevation on Windows")
    def test_dangling_symlink_is_rejected(self):
        (self.project / ".agents").symlink_to(Path(self.temp.name) / "absent", target_is_directory=True)
        with self.assertRaises(ValueError):
            self.run_install()

    @unittest.skipIf(sys.platform == "win32", "Creating links may require elevation on Windows")
    def test_source_symlinks_are_rejected(self):
        source = Path(self.temp.name) / "source"
        source.mkdir()
        (source / "SKILL.md").symlink_to(installer.SOURCE / "SKILL.md")
        with self.assertRaises(ValueError):
            self.run_install(source=source)
        self.assertEqual(list(self.project.iterdir()), [])

    def test_copy_failure_cleans_new_skill(self):
        with patch.object(installer.shutil, "copytree", side_effect=OSError("disk full")):
            with self.assertRaises(OSError):
                self.run_install()
        self.assertFalse((self.project / ".agents/skills/mobile-paywall").exists())

    def test_cli_works_from_an_unrelated_directory(self):
        result = subprocess.run([sys.executable, str(ROOT / "scripts/install.py"), "--agent", "all", "--project", str(self.project)], cwd=self.temp.name, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue((self.project / ".claude/skills/mobile-paywall/SKILL.md").is_file())

    def test_cli_invalid_agent_fails_without_writes(self):
        result = subprocess.run([sys.executable, str(ROOT / "scripts/install.py"), "--agent", "invalid", "--project", str(self.project)], capture_output=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(list(self.project.iterdir()), [])


if __name__ == "__main__":
    unittest.main()
