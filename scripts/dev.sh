#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"

active="$repo_root/AGENTS.md"
override="$repo_root/AGENTS.override.md"
guard_begin="<!-- AGENTS_GUARD_BEGIN -->"
guard_end="<!-- AGENTS_GUARD_END -->"
guard_template="$script_dir/GUARD_TEMPLATE.md"
override_template="$script_dir/OVERRIDE_TEMPLATE.md"

ensure_active() {
  if [[ ! -f "$active" ]]; then
    echo "Error: $active not found." >&2
    exit 1
  fi
}

ensure_templates() {
  if [[ ! -f "$guard_template" ]]; then
    echo "Error: $guard_template not found." >&2
    exit 1
  fi
  if [[ ! -f "$override_template" ]]; then
    echo "Error: $override_template not found." >&2
    exit 1
  fi
}

add_guard() {
  if grep -Fq "$guard_begin" "$active"; then
    return 0
  fi

  local tmp
  tmp="$(mktemp)"
  awk -v guard_file="$guard_template" '
    NR==1 {
      if ($0 ~ /^# /) {
        print $0
        while ((getline line < guard_file) > 0) { print line }
        close(guard_file)
        print ""
        next
      }
      while ((getline line < guard_file) > 0) { print line }
      close(guard_file)
      print ""
      print $0
      next
    }
    { print }
  ' "$active" > "$tmp"
  mv "$tmp" "$active"
}

remove_guard() {
  if ! grep -Fq "$guard_begin" "$active"; then
    return 0
  fi

  local tmp
  tmp="$(mktemp)"
  awk -v begin="$guard_begin" -v end="$guard_end" '
    $0 == begin { skip=1; next }
    $0 == end { skip=0; drop_blank=1; next }
    skip { next }
    drop_blank {
      if ($0 == "") {
        drop_blank=0
        next
      }
      drop_blank=0
    }
    { print }
  ' "$active" > "$tmp"
  mv "$tmp" "$active"
}

write_override() {
  cp "$override_template" "$override"
}

ensure_active
ensure_templates

if [[ -f "$override" ]]; then
  remove_guard
  rm -f "$override"
  echo "Dev mode disabled. Restored $active and removed $override."
  exit 0
fi

add_guard
write_override

echo "Dev mode enabled. Added guard to $active and created $override."
