#!/usr/bin/env bash
set -euo pipefail

active="AGENTS.md"
draft="AGENTS-draft.md"

if [[ -e "$active" && -e "$draft" ]]; then
  echo "Error: both $active and $draft exist. Remove one and retry." >&2
  exit 1
fi

if [[ -e "$active" ]]; then
  mv "$active" "$draft"
  echo "Renamed $active -> $draft"
  exit 0
fi

if [[ -e "$draft" ]]; then
  mv "$draft" "$active"
  echo "Renamed $draft -> $active"
  exit 0
fi

echo "Error: neither $active nor $draft exists." >&2
exit 1
