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
| `claude` | `.claude/skills/mobwall/` |
| `codex` | `.agents/skills/mobwall/` |
| `cursor` | `.agents/skills/mobwall/` |
| `antigravity` | `.agents/skills/mobwall/` |
| `all` | The two distinct locations above; no duplicate copies for the shared path. |

The installer preflights conflicts before copying. An identical installation is a no-op. A different or customized installation is preserved and reported as a conflict. Filesystem failures can still leave earlier successful destinations installed; rerun after resolving the failure. Destination links are rejected to avoid accidentally writing outside the intended folders.

## Manual installation

Copy the entire [skill folder](../skills/mobwall), including `references/`, to the desired project destination above. For all four agents copy it into both locations. Copy the contents as one `mobwall` folder; avoid an extra nested folder level. The final path must end in `mobwall/SKILL.md`.

Do not install an additional `.cursor/skills/mobwall` copy when the shared `.agents` version is already available. If your tool has an older discovery convention, check its version-specific documentation before choosing an alternate location.

## Invoke

- **Claude Code:** `/mobwall Improve the existing subscription screen.`
- **Codex:** `$mobwall Improve the existing subscription screen.`
- **Cursor / Antigravity:** `Use the mobwall skill to improve the existing subscription screen.` Select the skill in the client if its UI offers a picker.

Open or restart the agent in the target app project after first installation. If the skill is missing, verify the exact folder and `SKILL.md` name, project/workspace root, client support for skills, and any organization policy disabling local skills. As a fallback for troubleshooting, ask the agent to read the exact installed `SKILL.md` path; this does not prove automatic discovery works.

## Update or remove

Keep any custom changes. Move the existing `mobwall` skill directory to a backup location **outside skill-discovery folders**, then run the installer again. Compare and reapply your customizations intentionally. There is no automatic update or overwrite switch.

To remove, delete only the installed `mobwall` directory in the destinations above. Other skills and agent settings are unrelated. Removing the shared copy affects all tools that use it. Restart the client to clear already-loaded instructions.

## Rename migration

Mobwall was previously named `mobile-paywall`. Before installing Mobwall in an app that has the previous release, move the old `mobile-paywall` folder out of `.claude/skills/`, `.agents/skills/` and any custom `.cursor/skills/` location you used. Keep it as a backup outside all discovery directories, especially if customized. Then install `mobwall`, compare/reapply your customizations and restart your agent. The installer does not delete or migrate old copies automatically.

Use `/mobwall` in Claude Code and `$mobwall` in Codex after migration. Demo package identifiers have also changed; these are sample apps, not a migration of an existing production app or store listing.

## Official sources

Discovery conventions checked 2026-09-08; actual client smoke tests are recorded separately in [validation](validation.md).

- [Claude Code skills](https://code.claude.com/docs/en/skills)
- [OpenAI skill documentation](https://developers.openai.com/codex/skills/)
- [Cursor agent skills](https://cursor.com/docs/skills)
- [Antigravity skills](https://antigravity.google/docs/skills)

Only standard `name`, `description`, and `license` frontmatter is used. No agent-specific shell injection, hooks, tool grants, or mandatory dependencies are embedded in the skill.
