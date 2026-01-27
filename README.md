# codex-starter

This is my personal setup for using codex, I expect it to change over time.

I've found this approach to deliver significantly higher code quality than the default experience, and is frankly a pleasant development experience

### Key Features:

- Continuity across chats: maintain conversational state somewhere durable so new sessions don't start from scratch
- Rigorous planning: a repeatable way to write, run, and later archive execution plans
- Resuable scaffolding: templates the agent can copy from instead of improvising structure each time
- Minimal context switching costs: instructions ensures conversation stays highly contextualized at each turn

### What's in the repo:

- **[AGENTS.md](AGENTS.md)**  
  The operating contract: how the agent should research (web search), propose (numbered findings), decide, execute, verify (build/lint), update docs, and be smart about dependencies.

- **[.agent/PLANS.md](.agent/PLANS.md)**  
  The ExecPlan spec: how to write plans that are self-contained, how to track progress/decisions, and how to store/name/archive them.

- **[CONTINUITY.md](CONTINUITY.md) + [.agent/CONTINUITY_INIT.md](.agent/CONTINUITY_INIT.md)**  
  The “state of the world”: one durable place to keep Goal/Now/Next/Decisions/Receipts so new sessions start oriented instead of blind.

- **[.agent/execplans/INDEX.md](.agent/execplans/INDEX.md) + [.agent/INDEX_INIT.md](.agent/INDEX_INIT.md)**  
  The plan registry: tracks active vs archived ExecPlans over time so work doesn’t disappear into a pile of markdown files.

- **[.agent/execplans/active/](.agent/execplans/active/) + [.agent/execplans/archive/](.agent/execplans/archive/)**  
  The filing cabinet: where plans live while they’re in progress vs after they’re done (directories are kept in git via `.gitkeep`).

### Requirements:

- `codex` available in shell (`npm i -g @openai/codex`)
- Expects `web_search_request` to be enabled in codex's config (~/.codex/config.toml)

```
[features]
web_search_request = true
```

### How to use the starter to bootstrap a new project

1. Copy `AGENTS.md` and the `.agent/` directory into the repo
2. Copy over runtime files:

```
cp .agent/CONTINUITY_INIT.md CONTINUITY.md
mkdir -p .agent/execplans/active .agent/execplans/archive
cp .agent/INDEX_INIT.md .agent/execplans/INDEX.md
```

3. In `AGENTS.md`, fill in **Project-specific configuration** (build/lint/test/typecheck/docs commands).

### TODOs:

- Explore adding skills (ex: git worktrees)
- Explore MCPs (ex: Context7)
- Explore increasing token efficiency across instructions
- Add guidance for the followig:
  - tests
  - naming schemes
  - source code modularity and repo structure
