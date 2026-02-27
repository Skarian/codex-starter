# Migration Logs

## `.agent` to `.agents` (strict markdown cutover)

Date: 2026-02-27

This migration aligns legacy repos with the current `.agents` naming used by Codex skills/docs.
Standardizing on one path reduces confusion and prevents instruction drift across projects.

Run this from the repository root of any project:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Skarian/codex-starter/main/scripts/migrate-agent-to-agents.sh)"
```

What the script updates:

- Renames `.agent/` to `.agents/` if present.
- Rewrites `.agent/` path references in markdown only:
  - `AGENTS.md`
  - `AGENTS.override.md` (if present)
  - all `*.md` under `.agents/`
