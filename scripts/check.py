#!/usr/bin/env python3
"""Validate package structure and local Markdown links; no third-party packages."""

import json
from pathlib import Path
import re
import sys
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parents[1]


def check(root=ROOT):
    errors = []
    skill = root / "skills/mobwall/SKILL.md"
    content = skill.read_text(encoding="utf-8")
    match = re.match(r"\A---\n(.*?)\n---\n", content, re.S)
    if not match:
        errors.append("SKILL.md must start with YAML frontmatter")
    else:
        # This package deliberately uses a portable subset: one scalar per line.
        fields = {}
        for line in match[1].splitlines():
            key, separator, value = line.partition(":")
            if not separator or not value.strip() or key in fields:
                errors.append("Invalid or duplicate frontmatter field: " + line)
            fields[key] = value.strip()
        if fields.get("name") != "mobwall":
            errors.append("Skill name must match its folder")
        if not 1 <= len(fields.get("description", "")) <= 1024:
            errors.append("Description must be 1–1024 characters")
        if fields.get("license") != "MIT":
            errors.append("Skill license must be MIT")
    for document in root.rglob("*.md"):
        if ".git" in document.parts:
            continue
        body = document.read_text(encoding="utf-8")
        # Ignore code examples and inspect ordinary inline Markdown links/images.
        body = re.sub(r"```.*?```", "", body, flags=re.S)
        for link in re.findall(r"!?\[[^\]]*\]\(([^\s)]+)(?:\s+\"[^\"]*\")?\)", body):
            parsed = urlsplit(link)
            if parsed.scheme or parsed.netloc or not parsed.path:
                continue
            target = (document.parent / unquote(parsed.path)).resolve()
            try:
                target.relative_to(root.resolve())
            except ValueError:
                errors.append("Link escapes repository: {} → {}".format(document.relative_to(root), link))
                continue
            if not target.exists():
                errors.append("Broken link: {} → {}".format(document.relative_to(root), link))
    cases = json.loads((root / "evals/cases.json").read_text(encoding="utf-8"))
    ids = set()
    for case in cases:
        if case["id"] in ids:
            errors.append("Duplicate eval ID: " + case["id"])
        ids.add(case["id"])
        for field in ("prompt", "must", "must_not"):
            if not case.get(field):
                errors.append("Empty eval field: {}/{}".format(case["id"], field))
        for fixture in case.get("fixtures", []):
            if not (root / fixture).is_file():
                errors.append("Missing fixture: " + fixture)
    for error in errors:
        print("FAIL: " + error, file=sys.stderr)
    if not errors:
        print("Package checks passed: frontmatter, local links, {} evaluation cases.".format(len(cases)))
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(check())
