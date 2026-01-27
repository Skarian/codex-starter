# codex-starter

This is my personal setup for using codex, I expect it to change over time.

I've found this approach to deliver significantly higher code quality than the default experience, and is frankly a pleasant development experience

### Quick start (sync the starter into your repo)

- Copies the latest starter files into the current directory
- Asks before overwriting any existing file
- Skips `README.md`, `.gitignore`, and `scripts/`
- Leaves your repo’s `.git` and history untouched
- Works on macOS and Linux (on Windows, use WSL or Git Bash)
- In `AGENTS.md`, fill in **Project-specific configuration** (build/lint/test/typecheck/docs commands)

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Skarian/codex-starter/main/scripts/sync-codex-starter.sh)"
```

### How to customize this setup

- If you want to tailor this setup, clone the repo locally first
- If you want to use Codex (or another coding agent) while editing this starter, run `bash scripts/dev-toggle.sh` (or `chmod +x scripts/dev-toggle.sh` and `./scripts/dev-toggle.sh`) to toggle dev mode. Dev mode creates `AGENTS.override.md` and adds a guard to `AGENTS.md`; running it again removes the guard and override. To change the guard or override text, edit `scripts/GUARD_TEMPLATE.md` and `scripts/OVERRIDE_TEMPLATE.md`.

### Starter Goals:

- Avoid vibe-coding by providing explicit guidance and structure
- Make working with coding agents less chaotic
- Deliver production-ready code by default
- Lower my switching costs between interactions

### What's in the repo:

- **[AGENTS.md](AGENTS.md)**  
  The operating contract: explore, review findings, follow guidance, pick dependencies, execute, update docs, verify

- **[.agent/PLANS.md](.agent/PLANS.md)**  
  The ExecPlan spec: how to write plans that are self-contained, how to track progress/decisions, and how to store/name/archive them

- **[.agent/CONTINUITY.md](.agent/CONTINUITY.md)**  
  The "single source of truth": one durable place to keep Goal/Now/Next/Decisions/Receipts so new sessions start contextualized

- **[.agent/execplans/INDEX.md](.agent/execplans/INDEX.md)**  
  The plan registry: tracks active vs archived ExecPlans over time so work doesn’t disappear into a pile of markdown files

- **[.agent/execplans/active/](.agent/execplans/active/) + [.agent/execplans/archive/](.agent/execplans/archive/)**  
  The filing cabinet: where plans live while they’re in progress or when they are archived

### Requirements:

- `codex` available in shell (`npm i -g @openai/codex`)
- Expects `web_search_request` to be enabled in codex's config (~/.codex/config.toml)

```
[features]
web_search_request = true
```

### Sources

- PLANS.md inspiration: https://developers.openai.com/cookbook/articles/codex_exec_plans
- AGENTS.md framework: https://www.reddit.com/r/codex/comments/1qli5m3/comment/o1fjzgf/
- .agent/CONTINUITY.md idea: https://www.reddit.com/r/codex/comments/1qli5m3/comment/o1fw2gr/
