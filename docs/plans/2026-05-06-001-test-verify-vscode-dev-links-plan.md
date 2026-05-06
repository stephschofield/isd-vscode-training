---
title: "test: Verify deployed GitHub Pages vscode.dev buttons via agent-browser"
type: test
status: active
date: 2026-05-06
---

# test: Verify deployed GitHub Pages vscode.dev buttons via agent-browser

## Summary

Use `agent-browser` to load the deployed GitHub Pages site
(https://stephschofield.github.io/isd-vscode-training/), click each of the
three "Open in VS Code" buttons (Session 01 / 02 / 03), and verify each
opens `vscode.dev` and successfully loads the matching `session-one`,
`session-two`, `session-three` directory of the repo. Capture screenshots
as evidence. Report pass/fail per session.

---

## Problem Frame

The GitHub Pages hub at `index.html` (gh-pages branch) is the user's
front door. Each session card has a CTA pointing at
`https://vscode.dev/github/stephschofield/isd-vscode-training/tree/main/session-{one,two,three}`.
If any link 404s, redirects to the wrong folder, or fails to render the
expected files, learners get stuck before lab starts. This is a
deployment-verification task, not a code-change task.

---

## Requirements

- R1. Load the deployed Pages URL and find all three vscode.dev CTA anchors.
- R2. For each CTA, the `href` must point at the correct
  `tree/main/session-{one|two|three}` path on this repo.
- R3. Following each CTA must reach `vscode.dev` (host check) and render
  the matching session folder (sidebar shows the session's files).
- R4. Produce a pass/fail summary plus screenshots for each session.

---

## Scope Boundaries

- Not modifying `index.html` or any session content — verification only.
- Not testing GitHub Copilot / extension activation inside vscode.dev.
- Not running the labs themselves.

### Deferred to Follow-Up Work

- If a link is broken, fix is deferred to a follow-up PR against
  `gh-pages`.

---

## Context & Research

### Relevant Code and Patterns

- `gh-pages:index.html` — three `<a class="cta" href="https://vscode.dev/github/stephschofield/isd-vscode-training/tree/main/session-{one,two,three}">` anchors confirmed via `git show gh-pages:index.html`.
- Sessions exist on `main`: `session-one/`, `session-two/`, `session-three/` (verified via `ls`).
- Pages config (`gh api repos/.../pages`): `status: built`, source `gh-pages` branch, URL `https://stephschofield.github.io/isd-vscode-training/`.

### Tooling

- `agent-browser` CLI is installed at `/home/sschofield/.nvm/versions/node/v24.14.0/bin/agent-browser`.
- Use `open`, `find role link`, `get attr href`, `click`, `wait`, `get url`, `snapshot`, `screenshot` subcommands.

---

## Key Technical Decisions

- **Two-phase verification per session:** (a) static `href` check on the
  hub page, (b) live navigation + DOM probe in vscode.dev. Static check
  catches URL-template regressions cheaply; live check catches
  vscode.dev-side breakage (404, wrong folder, auth wall).
- **vscode.dev success signal:** sidebar/explorer renders an entry whose
  text matches the session's signature file (e.g., `README.md` plus
  session-specific folder name in the title bar / explorer root). Use
  `agent-browser snapshot` + text grep rather than brittle CSS
  selectors — vscode.dev's DOM is not a stable contract.
- **Screenshots as evidence:** save under
  `.context/agent-browser/vscode-dev-verify/<timestamp>/session-{1,2,3}-{hub,vscode}.png`.
- **Soft-fail on slow loads:** vscode.dev cold-start can take 10–20s.
  Use a generous wait (up to 30s) for the explorer root to appear.

---

## Implementation Units

- U1. **Static href audit on the deployed hub**

**Goal:** Confirm the three CTAs on the live Pages site point at the
correct vscode.dev URLs for session-one / -two / -three.

**Requirements:** R1, R2

**Dependencies:** None

**Files:**
- Create: `.context/agent-browser/vscode-dev-verify/<ts>/hub.png` (screenshot artifact)
- Create: `.context/agent-browser/vscode-dev-verify/<ts>/report.md` (run log)

**Approach:**
- `agent-browser open https://stephschofield.github.io/isd-vscode-training/`
- `agent-browser screenshot .../hub.png`
- For each session, locate the CTA via accessible label
  (`aria-label="Open Session 0X in VS Code for the web"`) and read its
  `href` attribute.
- Assert each href equals the expected
  `https://vscode.dev/github/stephschofield/isd-vscode-training/tree/main/session-{one,two,three}` exactly.

**Verification:** Three href assertions pass; hub screenshot saved.

---

- U2. **Live navigation check for each session in vscode.dev**

**Goal:** Click each CTA in turn, confirm navigation to `vscode.dev`,
and confirm the explorer renders the matching session folder.

**Requirements:** R3

**Dependencies:** U1

**Files:**
- Create: `.context/agent-browser/vscode-dev-verify/<ts>/session-{1,2,3}-vscode.png`

**Approach:**
- For each of session-one / -two / -three:
  1. From the hub, click the CTA (or `agent-browser open <expected href>` directly to avoid new-tab/popup quirks — vscode.dev opens fine on direct nav).
  2. Wait for `vscode.dev` URL (check `agent-browser get url` contains `vscode.dev` and the session folder path).
  3. Wait up to 30s for the workbench to render (poll `agent-browser snapshot` for text matching the session folder name or for an explorer file entry like `README.md`).
  4. Screenshot.
  5. Record pass/fail with the URL actually reached and whether the explorer text contained the session folder name.

**Verification:** All three sessions reach a `vscode.dev` URL containing
`tree/main/session-{one|two|three}` and the workbench shows session
content (folder name visible in the workbench / explorer text).

---

- U3. **Aggregate report**

**Goal:** Produce a single pass/fail summary the user can read at a glance.

**Requirements:** R4

**Dependencies:** U1, U2

**Files:**
- Create/append: `.context/agent-browser/vscode-dev-verify/<ts>/report.md`

**Approach:** Markdown table — Session | Expected URL | Reached URL |
Workbench loaded | Result. Plus a top-line "All 3 passed" / "N failed".
Print the report path at the end of the run for easy `cat`.

**Verification:** Report file exists, contains 3 rows, has an overall verdict line.

---

## Risks & Dependencies

| Risk | Mitigation |
|------|------------|
| vscode.dev cold-start exceeds wait window | 30s wait + retry once before declaring fail |
| Workbench DOM differs from expectations | Use snapshot text grep, not CSS selectors |
| Pages CDN cache stale vs. gh-pages branch HEAD | Compare hrefs to gh-pages:index.html; report drift |
| Headless agent-browser blocked by vscode.dev | Fall back to direct `open <href>` rather than `click` |

---

## Sources & References

- Deployed hub: https://stephschofield.github.io/isd-vscode-training/
- Pages config: `gh api repos/stephschofield/isd-vscode-training/pages`
- Source of CTAs: `gh-pages:index.html`
