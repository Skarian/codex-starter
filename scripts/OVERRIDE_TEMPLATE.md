# AGENTS.override.md

These are the only active instructions for this repo. This file overrides any
conflicting rules in AGENTS.md.

Use AGENTS.md as guidance for behavior, structure, and process, but do NOT apply
its requirements that create or update repo files.

Hard constraints (must override AGENTS.md if it conflicts):
- You may read `.agent/CONTINUITY.md` when helpful, but do not follow AGENTS.md’s requirement to read it every turn.
- Do not update or create `.agent/CONTINUITY.md` unless the user explicitly asks.
- Do not create or update ExecPlan files or `.agent/execplans/INDEX.md` unless the user explicitly asks.
- Do not modify any files under `.agent/` unless the user explicitly asks.
- In-chat planning is allowed; do not persist plans to files unless explicitly asked.

Working rules:
- Keep changes minimal and safe.
- Keep scripts portable (macOS + Linux) and dependency-light.
- Update README when behavior or usage changes.
