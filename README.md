# codex-starter

This is my personal setup for using codex, I expect it to change over time.

I've found this approach to deliver significantly higher code quality than the default experience, and is frankly a pleasant development experience

### Starter Goals:

- Avoid vibe-coding by providing explicit guidance and structure
- Make working with coding agents less chaotic
- Deliver production-ready code by default
- Lower my switching costs between interactions

### What's in the repo:

- **[AGENTS.md](AGENTS.md)**  
  The operating contract: explore, review findings, follow guidance, pick dependencies, execute, update docs, verify.

- **[.agent/PLANS.md](.agent/PLANS.md)**  
  The ExecPlan spec: how to write plans that are self-contained, how to track progress/decisions, and how to store/name/archive them

- **[CONTINUITY.md](CONTINUITY.md)**  
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

### How to use the starter to bootstrap a new project

1. Copy `AGENTS.md`, `CONTINUITY.md`, and the `.agent/` directory into the repo (including `.agent/execplans/INDEX.md`).
2. In `AGENTS.md`, fill in **Project-specific configuration** (build/lint/test/typecheck/docs commands).

### TODOs:

- Explore adding skills (ex: git worktrees)
- Explore MCPs (ex: Context7)
- Explore increasing token efficiency across instructions
- Add guidance for the following:
  - tests
  - naming schemes
  - source code modularity and repo structure

### Sources
- https://developers.openai.com/cookbook/articles/codex_exec_plans
