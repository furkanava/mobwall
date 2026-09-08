# Installation

## Local project installation

From the downloaded/cloned repository:

```sh
python3 scripts/install.py --agent all --project "/absolute/path/to/app" --dry-run
python3 scripts/install.py --agent all --project "/absolute/path/to/app"
```

The app directory must exist. Python 3.9+ is needed only for the installer. Windows users may need `python` instead of `python3`. Paths with spaces are supported when quoted.

| Agent option | Project destination |
| --- | --- |
| `claude` | `.claude/skills/mobile-paywall/` |
| `codex` | `.agents/skills/mobile-paywall/` |
| `cursor` | `.agents/skills/mobile-paywall/` |
| `antigravity` | `.agents/skills/mobile-paywall/` |
| `all` | The two distinct locations above; no duplicate copies for the shared path. |

The installer preflights conflicts before copying. An identical installation is a no-op. A different or customized installation is preserved and reported as a conflict. Filesystem failures can still leave earlier successful destinations installed; rerun after resolving the failure. Destination links are rejected to avoid accidentally writing outside the intended folders.

## Manual installation

Copy the entire [skill folder](../skills/mobile-paywall), including `references/`, to the desired project destination above. For all four agents copy it into both locations. Copy the contents as one `mobile-paywall` folder; avoid an extra nested folder level. The final path must end in `mobile-paywall/SKILL.md`.

Do not install an additional `.cursor/skills/mobile-paywall` copy when the shared `.agents` version is already available. If your tool has an older discovery convention, check its version-specific documentation before choosing an alternate location.

## Invoke

- **Claude Code:** `/mobile-paywall Improve the existing subscription screen.`
- **Codex:** `$mobile-paywall Improve the existing subscription screen.`
- **Cursor / Antigravity:** `Use the mobile-paywall skill to improve the existing subscription screen.` Select the skill in the client if its UI offers a picker.

Open or restart the agent in the target app project after first installation. If the skill is missing, verify the exact folder and `SKILL.md` name, project/workspace root, client support for skills, and any organization policy disabling local skills. As a fallback for troubleshooting, ask the agent to read the exact installed `SKILL.md` path; this does not prove automatic discovery works.

## Update or remove

Keep any custom changes. Move the existing `mobile-paywall` skill directory to a backup location **outside skill-discovery folders**, then run the installer again. Compare and reapply your customizations intentionally. There is no automatic update or overwrite switch.

To remove, delete only the installed `mobile-paywall` directory in the destinations above. Other skills and agent settings are unrelated. Removing the shared copy affects all tools that use it. Restart the client to clear already-loaded instructions.

## Official sources

Discovery conventions checked 2026-09-08; actual client smoke tests are recorded separately in [validation](validation.md).

- [Claude Code skills](https://code.claude.com/docs/en/skills)
- [OpenAI skill documentation](https://developers.openai.com/codex/skills/)
- [Cursor agent skills](https://cursor.com/docs/skills)
- [Antigravity skills](https://antigravity.google/docs/skills)

Only standard `name`, `description`, and `license` frontmatter is used. No agent-specific shell injection, hooks, tool grants, or mandatory dependencies are embedded in the skill.
