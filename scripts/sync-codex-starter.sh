#!/usr/bin/env bash
set -euo pipefail

repo_url="https://github.com/Skarian/codex-starter"
branch="main"
archive_url="${repo_url}/archive/refs/heads/${branch}.tar.gz"
exclude_paths=("README.md" ".gitignore" "scripts/")

tmp_dir="$(mktemp -d)"
cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

if ! command -v curl >/dev/null 2>&1; then
  echo "Error: curl is required." >&2
  exit 1
fi

if ! command -v tar >/dev/null 2>&1; then
  echo "Error: tar is required." >&2
  exit 1
fi

curl -fsSL "$archive_url" -o "$tmp_dir/archive.tar.gz"
tar -xzf "$tmp_dir/archive.tar.gz" -C "$tmp_dir"

src_root="$(find "$tmp_dir" -maxdepth 1 -type d -name "codex-starter-*" -print -quit)"
if [[ -z "$src_root" || ! -d "$src_root" ]]; then
  echo "Error: could not locate extracted repository." >&2
  exit 1
fi

mkdir -p .agent/execplans/active .agent/execplans/archive

should_skip() {
  local rel_path="$1"
  for excluded in "${exclude_paths[@]}"; do
    if [[ "$excluded" == */ ]]; then
      if [[ "$rel_path" == "$excluded"* ]]; then
        return 0
      fi
    elif [[ "$rel_path" == "$excluded" ]]; then
      return 0
    fi
  done
  return 1
}

confirm_overwrite() {
  local target="$1"
  printf "Overwrite %s? [y/N] " "$target"
  local reply=""
  if [[ -r /dev/tty ]]; then
    read -r reply </dev/tty
  else
    echo
    return 1
  fi
  [[ "$reply" == "y" || "$reply" == "Y" ]]
}

while IFS= read -r -d '' file; do
  rel_path="${file#"$src_root"/}"
  if should_skip "$rel_path"; then
    continue
  fi

  if [[ -e "$rel_path" ]]; then
    if ! confirm_overwrite "$rel_path"; then
      continue
    fi
  else
    mkdir -p "$(dirname "$rel_path")"
  fi

  cp -p "$file" "$rel_path"
done < <(find "$src_root" -type f -print0)

echo "Sync complete."
