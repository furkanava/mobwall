#!/usr/bin/env python3
"""Install the local skill without downloads, overwrites, or global configuration."""

import argparse
from pathlib import Path
import shutil
import sys

NAME = "mobwall"
SOURCE = Path(__file__).resolve().parents[1] / "skills" / NAME
# The shared location avoids duplicate discovery in Cursor and Antigravity.
ROOTS = {"claude": ".claude", "codex": ".agents", "cursor": ".agents", "antigravity": ".agents"}


def snapshot(folder):
    """Reject links/special files and compare every installed byte, including extras."""
    if folder.is_symlink() or not folder.is_dir():
        raise ValueError("Expected a regular directory: {}".format(folder))
    result = {}
    for item in sorted(folder.rglob("*")):
        if item.is_symlink():
            raise ValueError("Refusing symbolic link: {}".format(item))
        relative = item.relative_to(folder).as_posix()
        if item.is_file():
            result[relative] = item.read_bytes()
        elif item.is_dir():
            result[relative + "/"] = None
        else:
            raise ValueError("Refusing special file: {}".format(item))
    return result


def inspect_target(project, target):
    current = project
    for part in target.relative_to(project).parts:
        current = current / part
        if current.is_symlink():
            raise ValueError("Refusing symbolic link in destination: {}".format(current))
        if current.exists() and not current.is_dir():
            raise ValueError("Destination component is not a directory: {}".format(current))


def install(project, agents, dry_run=False, source=SOURCE):
    project = Path(project).expanduser().resolve()
    if not project.is_dir():
        raise ValueError("Project directory must already exist: {}".format(project))
    expected = snapshot(source)
    if "SKILL.md" not in expected:
        raise ValueError("Source is missing SKILL.md")
    targets = sorted({project / ROOTS[agent] / "skills" / NAME for agent in agents})
    pending = []
    # Preflight every destination before writing any of them.
    for target in targets:
        inspect_target(project, target)
        if target.exists():
            if snapshot(target) != expected:
                raise ValueError("Existing skill differs; nothing overwritten: {}. Back it up and move it aside before reinstalling.".format(target))
        else:
            pending.append(target)
    for target in targets:
        if target not in pending:
            print("Already installed: {}".format(target))
        elif dry_run:
            print("Would install: {}".format(target))
        else:
            target.parent.mkdir(parents=True, exist_ok=True)
            inspect_target(project, target)
            # Exclusive creation avoids replacing a destination created since preflight.
            target.mkdir()
            try:
                shutil.copytree(source, target, dirs_exist_ok=True)
            except BaseException:
                shutil.rmtree(target)
                raise
            print("Installed: {}".format(target))
    return targets


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--agent", required=True, choices=[*ROOTS, "all"])
    parser.add_argument("--project", required=True, type=Path, help="Existing app project directory")
    parser.add_argument("--dry-run", action="store_true", help="Check and print destinations without writing")
    args = parser.parse_args(argv)
    try:
        install(args.project, list(ROOTS) if args.agent == "all" else [args.agent], args.dry_run)
    except (OSError, ValueError) as error:
        print("Install failed: {}".format(error), file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
