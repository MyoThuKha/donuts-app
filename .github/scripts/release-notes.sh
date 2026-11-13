#!/usr/bin/env bash
# Prints Markdown release notes for a tag, built from the Conventional Commit
# subjects since the previous v* tag.
#
# Usage: release-notes.sh <tag> [<repo url>]
#
# feat goes under "New features", fix under "Bug fixes", and perf and refactor
# under "Improvements". Other types (chore, docs, test, ci, style, build) are
# left out. Each section lists at most MAX_PER_SECTION bullets.
set -euo pipefail

tag="$1"
repo_url="${2:-}"
max_per_section="${MAX_PER_SECTION:-8}"

previous_tag="$(git describe --tags --abbrev=0 --match 'v*' "${tag}^" 2>/dev/null || true)"
if [[ -n "$previous_tag" ]]; then
  range="${previous_tag}..${tag}"
else
  range="$tag"
fi

subjects="$(git log --no-merges --format=%s "$range")"

# Turns "feat(home): add the shops band" into "**home:** Add the shops band".
format_bullet() {
  sed -E \
    -e 's/^[a-z]+\(([^)]+)\)!?: */**\1:** /' \
    -e 's/^[a-z]+!?: *//' \
    | awk '{
        if (match($0, /^\*\*[^*]+\*\* /)) {
          head = substr($0, 1, RLENGTH); rest = substr($0, RLENGTH + 1)
        } else { head = ""; rest = $0 }
        print "- " head toupper(substr(rest, 1, 1)) substr(rest, 2)
      }'
}

print_section() {
  local title="$1" pattern="$2" lines count
  lines="$(grep -E "^(${pattern})(\([^)]*\))?!?: " <<<"$subjects" || true)"
  [[ -z "$lines" ]] && return 0
  count="$(wc -l <<<"$lines" | tr -d ' ')"
  printf '### %s\n\n' "$title"
  head -n "$max_per_section" <<<"$lines" | format_bullet
  if (( count > max_per_section )); then
    printf -- '- And %d more\n' "$((count - max_per_section))"
  fi
  printf '\n'
}

notes="$(
  print_section 'New features' 'feat'
  print_section 'Bug fixes' 'fix'
  print_section 'Improvements' 'perf|refactor'
)"

if [[ -z "$notes" ]]; then
  notes='No feature, fix or improvement commits since the last release.'
fi

printf '%s\n' "$notes"

if [[ -n "$repo_url" ]]; then
  if [[ -n "$previous_tag" ]]; then
    printf '\n**Full changelog:** %s/compare/%s...%s\n' "$repo_url" "${previous_tag//+/%2B}" "${tag//+/%2B}"
  else
    printf '\n**Full history:** %s/commits/%s\n' "$repo_url" "${tag//+/%2B}"
  fi
fi
