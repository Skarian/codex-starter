#!/usr/bin/env bash
set -euo pipefail

if ! command -v perl >/dev/null 2>&1; then
  echo "Error: perl is required." >&2
  exit 1
fi

if [[ -d ".agent" ]]; then
  if [[ -e ".agents" ]]; then
    echo "Error: both .agent and .agents exist. Resolve manually first." >&2
    exit 1
  fi
  mv .agent .agents
  echo "Renamed .agent -> .agents"
else
  echo "No .agent directory found; skipping rename."
fi

targets=()

if [[ -f "AGENTS.md" ]]; then
  targets+=("AGENTS.md")
fi

if [[ -f "AGENTS.override.md" ]]; then
  targets+=("AGENTS.override.md")
fi

if [[ -d ".agents" ]]; then
  while IFS= read -r -d '' file; do
    targets+=("$file")
  done < <(find ".agents" -type f -name '*.md' -print0)
fi

if [[ ${#targets[@]} -eq 0 ]]; then
  echo "No markdown targets found. Nothing to update."
  exit 0
fi

for file in "${targets[@]}"; do
  perl -0pi -e 's/\.agent\//.agents\//g' "$file"
done

leftover=0
for file in "${targets[@]}"; do
  if grep -n '\.agent/' "$file" >/dev/null 2>&1; then
    echo "Remaining .agent/ reference in $file:" >&2
    grep -n '\.agent/' "$file" >&2
    leftover=1
  fi
done

if [[ "$leftover" -ne 0 ]]; then
  echo "Migration incomplete. Resolve the references above and re-run." >&2
  exit 1
fi

echo "Migration complete: strict markdown targets updated."
