#!/usr/bin/env bash
# Build the Lab 3 deliverables: briefing.docx and deck.pptx
#
# Reads from templates/ (where attendees fill in their own content).
# Writes to the project root by default. Late joiners can copy
# final/briefing.md and final/deck-outline.md over the templates first.
#
# Requires: pandoc (https://pandoc.org/installing.html)
set -eu

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

if ! command -v pandoc >/dev/null 2>&1; then
    echo "error: pandoc is not on PATH." >&2
    echo "install it from https://pandoc.org/installing.html and re-run." >&2
    exit 1
fi

BRIEFING_SRC="templates/briefing-template.md"
DECK_SRC="templates/deck-outline-template.md"
BRIEFING_OUT="briefing.docx"
DECK_OUT="deck.pptx"

if [[ ! -f "$BRIEFING_SRC" ]]; then
    echo "error: $BRIEFING_SRC not found. run from the repo root." >&2
    exit 1
fi

if [[ ! -f "$DECK_SRC" ]]; then
    echo "error: $DECK_SRC not found. run from the repo root." >&2
    exit 1
fi

pandoc "$BRIEFING_SRC" -o "$BRIEFING_OUT"
echo "wrote $BRIEFING_OUT"

pandoc "$DECK_SRC" -o "$DECK_OUT" -t pptx --slide-level=1
echo "wrote $DECK_OUT"
