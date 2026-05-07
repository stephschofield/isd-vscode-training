#!/usr/bin/env bash
# test-vscode-desktop-framing.sh
#
# Asserts the editorial change from plan
# docs/plans/2026-05-07-001-fix-codespaces-open-in-vscode-desktop-plan.md:
# the four learner-facing docs frame Codespaces as opening in VS Code Desktop,
# not "in your browser."
#
# This is a grep-based smoke test, not a behavioural test. It exists to catch
# editorial regressions where someone re-introduces the old "in your browser"
# framing into the labs or top-level README.

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

assert_no_match() {
  local pattern="$1"
  local file="$2"
  local label="$3"
  if grep -E -i -n "$pattern" "$file" >/dev/null 2>&1; then
    echo "FAIL [$label] forbidden pattern '$pattern' found in $file:"
    grep -E -i -n "$pattern" "$file" | sed 's/^/    /'
    fail=1
  else
    echo "ok   [$label] no '$pattern' in $file"
  fi
}

assert_match() {
  local pattern="$1"
  local file="$2"
  local label="$3"
  if grep -E -i -n "$pattern" "$file" >/dev/null 2>&1; then
    echo "ok   [$label] '$pattern' present in $file"
  else
    echo "FAIL [$label] expected pattern '$pattern' missing from $file"
    fail=1
  fi
}

# 1. Forbidden framings in all four files.
#    These specific phrases imply learners work *inside* a web browser.
FORBIDDEN_PHRASES=(
  "Codespace open in your browser"
  "with a working browser"
  "runs in your browser"
  "right in your browser"
  "in a browser tab"
)

for file in "${LAB_FILES[@]}" "$README"; do
  for phrase in "${FORBIDDEN_PHRASES[@]}"; do
    assert_no_match "$phrase" "$file" "no-browser-framing"
  done
done

# 2. README must not advertise the table column as "Open in browser".
assert_no_match "Open in browser" "$README" "readme-table-header"

# 3. Each of the four files must mention VS Code Desktop somewhere.
for file in "${LAB_FILES[@]}" "$README"; do
  assert_match "VS Code Desktop" "$file" "mentions-vs-code-desktop"
done

# 4. README sessions table column header should be "Open in Codespace".
assert_match "Open in Codespace" "$README" "readme-codespace-column"

if [ "$fail" -ne 0 ]; then
  echo
  echo "Framing test FAILED."
  exit 1
fi

echo
echo "Framing test PASSED."
