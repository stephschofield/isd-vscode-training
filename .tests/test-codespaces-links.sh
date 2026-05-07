#!/usr/bin/env bash
# TDD assertions for U4 (Codespaces on-ramp on gh-pages landing page).
#
# Asserts that index.html on the gh-pages branch:
#   - has zero references to vscode.dev
#   - has exactly 6 codespaces.new links (3 pills + 3 CTAs)
#   - each devcontainer_path points to the correct session folder
#   - the "Open in VS Code" CTA copy and the step-2 "vscode.dev opens..." prose
#     have been replaced with Codespaces-correct copy
#   - aria-labels mention Codespaces, not "VS Code for the web"
set -euo pipefail

FILE="${1:-index.html}"
fail=0

assert_eq() {
  local label="$1" expected="$2" actual="$3"
  if [[ "$expected" != "$actual" ]]; then
    echo "FAIL: $label — expected $expected, got $actual"
    fail=1
  else
    echo "OK:   $label ($actual)"
  fi
}

assert_zero() {
  local label="$1" pattern="$2"
  local n
  n=$(grep -cE "$pattern" "$FILE" || true)
  assert_eq "$label" 0 "$n"
}

# 1. No vscode.dev references anywhere.
assert_zero "no vscode.dev references"        'vscode\.dev'
assert_zero "no 'Open in VS Code' CTA copy"   'Open in VS Code'
assert_zero "no 'VS Code for the web' aria"   'VS Code for the web'
assert_zero "no 'vscode.dev opens the folder'" 'vscode\.dev opens the folder'

# 2. Exactly 6 codespaces.new links (3 pills + 3 CTAs).
codespaces_count=$(grep -cE 'codespaces\.new/stephschofield/isd-vscode-training' "$FILE" || true)
assert_eq "exactly 6 codespaces.new links" 6 "$codespaces_count"

# 3. Each session's devcontainer_path appears at least twice (pill + CTA).
for s in one two three; do
  n=$(grep -cE "devcontainer_path=session-$s/\.devcontainer/devcontainer\.json" "$FILE" || true)
  assert_eq "session-$s has 2 codespaces links (pill + CTA)" 2 "$n"
done

# 4. quickstart=1 is present on every codespaces link.
qs=$(grep -cE 'codespaces\.new[^"]*quickstart=1' "$FILE" || true)
assert_eq "quickstart=1 on all 6 codespaces links" 6 "$qs"

# 4b. editor=web is present on every codespaces link (forces VS Code Web client,
#     overriding the user's account-level default-editor preference). See
#     docs/plans/2026-05-07-001-fix-codespaces-link-opens-desktop-empty-plan.md.
ew=$(grep -cE 'codespaces\.new[^"]*editor=web' "$FILE" || true)
assert_eq "editor=web on all 6 codespaces links" 6 "$ew"

# 5. aria-labels mention Codespaces.
aria=$(grep -cE 'aria-label="Open Session [^"]*Codespaces?"' "$FILE" || true)
if [[ "$aria" -lt 6 ]]; then
  echo "FAIL: expected ≥6 aria-labels mentioning Codespaces, got $aria"
  fail=1
else
  echo "OK:   $aria aria-labels mention Codespaces"
fi

if [[ "$fail" -ne 0 ]]; then
  echo
  echo "TESTS FAILED"
  exit 1
fi
echo
echo "ALL TESTS PASSED"
