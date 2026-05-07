#!/usr/bin/env bash
# test-vscode-desktop-framing.sh
#
# Asserts the editorial change documented in PR #22
# (https://github.com/stephschofield/isd-vscode-training/pull/22):
# the four learner-facing docs frame Codespaces as opening in VS Code Desktop,
# not "in your browser."
#
# This is a grep-based smoke test, not a behavioural test. It exists to catch
# editorial regressions where the old "in your browser" framing is
# reintroduced into the labs or top-level README. It does not (and cannot)
# verify the actual Codespace → Desktop hand-off behaviour.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

LAB_FILES=(
  "session-one/lab/01-cleanup.md"
  "session-two/lab/02-synthesis.md"
  "session-three/lab/03-briefing.md"
)
README="README.md"

fail=0

# Distinguish grep's three meaningful exit codes:
#   0 = match found
#   1 = no match found (clean miss)
#   2 = error (file missing, permission denied, binary, etc.)
# A missing or unreadable target must FAIL the test, not silently pass.
require_file() {
  local file="$1"
  local label="$2"
  if [ ! -f "$file" ]; then
    echo "FAIL [$label] file not found: $file"
    fail=1
    return 1
  fi
  if [ ! -r "$file" ]; then
    echo "FAIL [$label] file not readable: $file"
    fail=1
    return 1
  fi
  return 0
}

# Run grep in a way that captures the exit code reliably under `set -e`.
# `$?` set inside command substitution does not propagate, so use a
# temp-file pattern instead.
_grep_to() {
  # _grep_to <out_var> <flags> <pattern> <file>
  # Stores grep stdout in <out_var>, returns grep's exit code.
  local __out_var="$1"
  local __flags="$2"
  local __pattern="$3"
  local __file="$4"
  local __tmp
  __tmp="$(mktemp)"
  local __rc=0
  # shellcheck disable=SC2086
  grep $__flags -- "$__pattern" "$__file" >"$__tmp" 2>/dev/null || __rc=$?
  # shellcheck disable=SC2034
  printf -v "$__out_var" '%s' "$(cat "$__tmp")"
  rm -f "$__tmp"
  return $__rc
}

assert_no_match() {
  local pattern="$1"
  local file="$2"
  local label="$3"
  require_file "$file" "$label" || return 0
  local out=""
  local rc=0
  _grep_to out "-E -i -n" "$pattern" "$file" || rc=$?
  if [ "$rc" -eq 0 ]; then
    echo "FAIL [$label] forbidden pattern '$pattern' found in $file:"
    printf '%s\n' "$out" | sed 's/^/    /'
    fail=1
  elif [ "$rc" -eq 1 ]; then
    echo "ok   [$label] no '$pattern' in $file"
  else
    echo "FAIL [$label] grep error (rc=$rc) on $file for pattern '$pattern'"
    fail=1
  fi
}

assert_match() {
  local pattern="$1"
  local file="$2"
  local label="$3"
  require_file "$file" "$label" || return 0
  local out=""
  local rc=0
  _grep_to out "-E -i -n" "$pattern" "$file" || rc=$?
  if [ "$rc" -eq 0 ]; then
    echo "ok   [$label] '$pattern' present in $file"
  elif [ "$rc" -eq 1 ]; then
    echo "FAIL [$label] expected pattern '$pattern' missing from $file"
    fail=1
  else
    echo "FAIL [$label] grep error (rc=$rc) on $file for pattern '$pattern'"
    fail=1
  fi
}

# Same as assert_match but uses literal (fixed-string) matching so callers
# can pin punctuation like table delimiters that are easy to mis-anchor in
# regex form.
assert_match_fixed() {
  local pattern="$1"
  local file="$2"
  local label="$3"
  require_file "$file" "$label" || return 0
  local out=""
  local rc=0
  _grep_to out "-F -n" "$pattern" "$file" || rc=$?
  if [ "$rc" -eq 0 ]; then
    echo "ok   [$label] literal '$pattern' present in $file"
  elif [ "$rc" -eq 1 ]; then
    echo "FAIL [$label] expected literal '$pattern' missing from $file"
    fail=1
  else
    echo "FAIL [$label] grep error (rc=$rc) on $file for literal '$pattern'"
    fail=1
  fi
}

# 1. Forbidden browser-framing regression family.
#    A single regex catches the regression family rather than enumerating
#    exact past phrasings (which trivial paraphrases would slip past).
#    Matches: "in your browser", "in the browser", "from your browser",
#    "inside the browser", "runs in your browser", etc., and the explicit
#    "browser-based VS Code" phrasing.
FORBIDDEN_PATTERNS=(
  "(in|from|inside) (your |the )?(web )?browser"
  "browser-based VS Code"
  "in a browser tab"
)

# Lab 01 intentionally uses the phrase "web editor" once as a hedge in the
# "if it opens the web editor instead, that's fine" sentence. Allowlisting it
# keeps that hedge legal while still failing if "web editor" reappears in any
# other file.
ALLOWED_WEB_EDITOR_FILE="session-one/lab/01-cleanup.md"

for file in "${LAB_FILES[@]}" "$README"; do
  for pat in "${FORBIDDEN_PATTERNS[@]}"; do
    assert_no_match "$pat" "$file" "no-browser-framing"
  done
done

# Bare "web editor" is forbidden everywhere except the explicit hedge in lab 01.
for file in "${LAB_FILES[@]}" "$README"; do
  if [ "$file" = "$ALLOWED_WEB_EDITOR_FILE" ]; then
    continue
  fi
  assert_no_match "web editor" "$file" "no-web-editor-framing"
done

# 2. README must not advertise the table column as "Open in browser".
assert_no_match "Open in browser" "$README" "readme-table-header"

# 3. Each of the four files must mention VS Code Desktop somewhere.
for file in "${LAB_FILES[@]}" "$README"; do
  assert_match "VS Code Desktop" "$file" "mentions-vs-code-desktop"
done

# 4. README sessions table column header must be the exact literal cell
#    "| Open in Codespaces |" — pinning the leading pipe disambiguates it
#    from the link-cell text "Open in Codespaces ↗" elsewhere on the line,
#    so a regression that reverted just the header would actually fail.
assert_match_fixed "| Open in Codespaces |" "$README" "readme-codespace-column"

if [ "$fail" -ne 0 ]; then
  echo
  echo "Framing test FAILED."
  exit 1
fi

echo
echo "Framing test PASSED."
