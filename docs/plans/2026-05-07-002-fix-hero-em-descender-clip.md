---
title: Fix hero <em> descender clipping
status: active
created: 2026-05-07
---

# Fix hero `<em>` descender clipping

## Problem

The hero headline "Turn messy data into an *executive story*." renders the italic gradient `<em>` with `background-clip: text`. The italic Fraunces "y" descender at `font-size: 84.8px` extends below the inline-block's padding box. Since `background-clip: text` only paints the gradient inside the element's box, the bottom of the "y" glyph falls outside the gradient region and renders transparent — visually "cut off."

## Root cause

`.hero h1 em` has `padding: 0.1em 0.05em 0.55em`. The `0.55em` bottom padding is insufficient for the italic descender at the hero font size.

## Implementation Units

### U1: Increase em padding-bottom

- **Goal:** Make the full "y" descender visible by giving the gradient-painted box enough room below the baseline.
- **Files:** Modify `index.html` (only — single-page site with inline `<style>`)
- **Approach:** Change `.hero h1 em` `padding: 0.1em 0.05em 0.55em` → `padding: 0.1em 0.05em 0.95em`. Minimal, layout-safe (the line-height already reserves the line box; the extra padding only extends the gradient's painting region downward).
- **Verification:**
  - Visual: full-page screenshot of `https://stephschofield.github.io/isd-vscode-training/` (after deploy) shows complete "y" descender in "story".
  - Local: open `index.html` in browser; hero "y" is fully painted.

## Scope Boundaries

- Not refactoring the gradient effect.
- Not changing line-height, font, or layout.
- Not introducing pseudo-elements or new variables.

## Test scenarios

Pure CSS visual fix; no automated test added. Verified by re-screenshotting via agent-browser and inspecting the em region.
