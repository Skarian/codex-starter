# Migration Logs

## `.agent` to `.agents`

Date: 2026-02-27

OpenAI Codex documentation has shifted path conventions over the past few releases:

- 2025-10-28: OpenAI Codex issue `#5881` proposes standardizing `.agents` alongside existing `~/.codex` conventions.  
  Source: https://github.com/openai/codex/issues/5881
- 2025-12-19: Codex changelog documents skills under `.codex/skills` and `~/.codex/skills` (`v0.84.0`).  
  Source: https://developers.openai.com/codex/changelog/
- 2026-02-01: OpenAI Codex PR `#10317` merges support for loading team/repo skills from `.agents/skills`.  
  Source: https://github.com/openai/codex/pull/10317
- 2026-02-02: Codex changelog publishes `.agents/skills` and `~/.agents/skills` support (`v0.94.0`).  
  Source: https://developers.openai.com/codex/changelog/
- 2026-02-03: OpenAI Codex PR `#10437` merges personal `~/.agents/skills` loading and notes compatibility with `~/.codex/skills` until deprecation.  
  Source: https://github.com/openai/codex/pull/10437
- 2026-02-04: Codex changelog adds `AGENTS.md` control for loading `~/.agents/skills` (`v0.95.0`).  
  Source: https://developers.openai.com/codex/changelog/
- 2026-02-27 (current docs): Codex Skills docs instruct project skills in `.agents/skills/`.  
  Source: https://developers.openai.com/codex/skills/

Note: in currently accessible OpenAI primary sources, the documented path transition is `.codex` -> `.agents`. A literal `.agent/` path reference is UNCONFIRMED.

This script keeps repos on the current OpenAI-aligned `.agents` pathing and updates markdown references in a controlled cutover.

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
