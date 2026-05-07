---
title: "fix: Codespaces links open desktop VS Code with empty workspace"
type: fix
status: active
date: 2026-05-07
origin: docs/plans/2026-05-06-003-feat-switch-to-github-codespaces-plan.md
---

# fix: Codespaces links open desktop VS Code with empty workspace

## Summary

Force the session pills and CTAs on `gh-pages/index.html` to open Codespaces in **VS Code for the Web** instead of the desktop client, and confirm each Codespace lands the user inside the correct `session-N/` folder. The browser-vs-desktop split is the root cause; the "empty workspace" report is a downstream symptom that the desktop client surfaces because it ignores the devcontainer's `workspaceFolder` until the remote attaches.

---

## Problem Frame

The on-ramp shipped in `0918ed5` (feat/codespaces-on-ramp) uses
`https://codespaces.new/stephschofield/isd-vscode-training/tree/main?devcontainer_path=session-one/.devcontainer/devcontainer.json&quickstart=1`.

When the user clicks this link, two things go wrong:

1. **Wrong editor.** The link launches GitHub's "create Codespace" page, which respects the user's account-level **default editor** preference (`https://github.com/settings/codespaces` → "Editor preference"). If that preference is set to "Visual Studio Code" (desktop), the desktop client is launched via the `vscode://` URL handler regardless of intent.
2. **Empty workspace.** When the desktop client opens, it can present its previous local folder *before* the Codespaces remote has attached. The devcontainer's `workspaceFolder: /workspaces/${localWorkspaceFolderBasename}/session-one` is honored only after attach, so the user sees an empty/non-session window. In the browser client, `workspaceFolder` is honored on first paint and the session folder loads as expected.

Both issues hit the same audience (attendees on personal GitHub accounts) at the same moment (lab kickoff), so they read as a single failure.

---

## Requirements

- R1. Clicking any session pill or "Open in Codespaces" CTA on the landing page opens that session in **VS Code for the Web**, not the desktop client, regardless of the user's GitHub default-editor preference (best-effort — see Open Questions on the editor= override).
- R2. Once the Codespace has attached, the editor opens with `session-N/` as the workspace root and the session README visible/openable from the explorer.
- R3. Existing devcontainer behavior (Copilot + Copilot Chat extensions, `workspaceFolder` per session) is preserved.
- R4. Fix ships through the existing `gh-pages` direct-push workflow — no PR gate, no rebuild step beyond editing `index.html`.
- R5. If the URL-level override proves unreliable across browsers/accounts, attendees have a clearly documented one-time fallback (set default editor to "Visual Studio Code for the Web") visible from the landing page.

**Origin actors:** attendees on personal GitHub accounts (free tier), workshop facilitator.
**Origin flows:** "Pick your session → click pill/CTA → Codespace boots in browser → README open."

---

## Scope Boundaries

- Not changing devcontainer images or extension lists.
- Not adding authentication, org policy, or Codespaces prebuild configuration.
- Not editing session content (`session-*/README.md`, labs, prompts).
- Not changing the landing page visual design.

### Deferred to Follow-Up Work

- Org-level Codespaces policy that forces web editor for all members: out of scope (requires org admin and isn't reachable for personal-account attendees).
- Pre-built Codespaces to reduce 60s boot: separate plan.

---

## Context & Research

### Relevant Code and Patterns

- `index.html` lines 407, 414, 422, 429, 437, 444 — six occurrences of the `codespaces.new/...` URL template (one pill + one CTA per session). All six need the same edit; keep them consistent.
- `session-one/.devcontainer/devcontainer.json`, `session-two/.devcontainer/devcontainer.json`, `session-three/.devcontainer/devcontainer.json` — already set `workspaceFolder` correctly. No change required here unless verification reveals a path issue.
- `.tests/test-codespaces-links.sh` — existing link-shape test. Update assertions when URL parameters change.

### Institutional Learnings

- The previous on-ramp plan (`docs/plans/2026-05-06-003-...`) chose `codespaces.new` specifically because `?devcontainer_path=` and `&quickstart=1` were the documented hint parameters. It did **not** address the editor channel, which is what this fix targets.

### External References

- GitHub Codespaces: "Setting your default editor for Codespaces" — `https://docs.github.com/en/codespaces/customizing-your-codespace/setting-your-default-editor-for-github-codespaces`. The default-editor preference is *user-scoped*, not URL-scoped, which is why URL hints alone can't guarantee the browser editor.
- The `editor=web` query parameter has been observed working on `https://github.com/codespaces/new?...` flows but is **not officially documented** for `codespaces.new` short-links — verify behavior in Phase 1 of implementation.

---

## Key Technical Decisions

- **Try URL-level override first, document fallback as a safety net.** Add `editor=web` to the URL and observe behavior across two browsers/accounts. If reliable, ship just the URL change. If unreliable, keep the URL change *and* surface a one-line "If VS Code desktop opens, set your editor to 'Visual Studio Code for the Web' at github.com/settings/codespaces" hint near the CTAs.
- **Do not switch the URL host away from `codespaces.new`.** It's the documented short-link and it survives org redirects. Switching to `https://github.com/codespaces/new?...` would change behavior for users who already bookmarked or shared the current URL.
- **Don't touch devcontainer JSON unless verification proves the workspace-folder bug exists in the web client.** Current expectation is that the empty-workspace symptom is desktop-only.

---

## Open Questions

### Resolved During Planning

- *Is the empty-workspace bug a devcontainer issue?* No — the `workspaceFolder` field is correct. The empty workspace is a desktop-client paint-before-attach artifact. Fix the editor channel and the symptom resolves.

### Deferred to Implementation

- Does `editor=web` on `codespaces.new/...?devcontainer_path=...&quickstart=1&editor=web` actually force the browser client across (a) a fresh GitHub account with default editor = desktop, and (b) a returning user with an existing desktop install? Verify in U1 before deciding whether U3 (fallback hint) is required.
- Does the web client honor `workspaceFolder` correctly for all three sessions? Verify in U2.

---

## Implementation Units

- U1. **Add `editor=web` to all six Codespaces URLs in `index.html`**

**Goal:** Make the URL itself request the web editor, overriding (best-effort) the user's default-editor preference.

**Requirements:** R1, R4

**Dependencies:** None

**Files:**
- Modify: `index.html` (6 occurrences of the `codespaces.new` URL — lines ~407, 414, 422, 429, 437, 444)
- Modify: `.tests/test-codespaces-links.sh` (assert `editor=web` is present on every link)

**Approach:**
- Append `&editor=web` to each of the six URLs. Keep `devcontainer_path=...&quickstart=1` intact and ordered consistently.
- Update the link-shape test to require `editor=web` so future edits don't drop it.

**Test scenarios:**
- Happy path: Click each session pill in Chrome on a personal GitHub account whose default editor is set to "Visual Studio Code" (desktop) → Codespace opens in browser tab, not desktop.
- Happy path: Click each "Open in Codespaces" CTA on the same account → same behavior.
- Edge case: User with default editor already set to "Visual Studio Code for the Web" → no regression; browser still opens.
- Edge case: User clicks the link from a mobile browser → graceful behavior (browser editor or GitHub's mobile-appropriate fallback; do not regress vs. current state).

**Verification:**
- All six links carry `editor=web`.
- `.tests/test-codespaces-links.sh` passes locally.
- Manual: in two browsers (Chrome + Firefox) on accounts with default editor = desktop, every session opens in the browser tab.

---

- U2. **Verify each session's Codespace lands in the correct `session-N/` folder in the web client**

**Goal:** Confirm the empty-workspace symptom is gone once U1 routes users to the web editor, and that the existing devcontainer `workspaceFolder` is honored.

**Requirements:** R2, R3

**Dependencies:** U1

**Files:**
- Read-only verification across `session-one/.devcontainer/devcontainer.json`, `session-two/.devcontainer/devcontainer.json`, `session-three/.devcontainer/devcontainer.json`. Modify only if a defect is found.

**Approach:**
- Open a Codespace per session via the updated URL.
- Confirm the explorer root is `session-N/` and the session README is reachable in one click.
- If the web client opens at the repo root instead of `session-N/`, investigate `workspaceFolder` resolution (likely the `${localWorkspaceFolderBasename}` token under the codespaces.new flow) and fix in this unit.

**Test scenarios:**
- Happy path (×3 sessions): Codespace boots → explorer is rooted at `session-N/` → `README.md` visible without expanding any tree.
- Edge case: Codespace boots at repo root → file an issue and remediate in this unit (likely a `workspaceFolder` token fix).

**Verification:**
- All three sessions open with `session-N/` as the workspace root in VS Code for the Web.
- No changes to extensions list or post-create commands.

---

- U3. **(Conditional) Add a one-line "if desktop opens" fallback hint near the CTAs**

**Goal:** Give attendees a 10-second self-service fix when `editor=web` is ignored.

**Requirements:** R5

**Dependencies:** U1 (only ship this unit if U1 verification shows `editor=web` is unreliable on at least one tested browser/account)

**Files:**
- Modify: `index.html` (small note in the "How it works" section or directly under the CTAs)

**Approach:**
- One short sentence + link: "Opens in VS Code desktop instead? Set your editor to 'Visual Studio Code for the Web' at github.com/settings/codespaces."
- Style consistent with existing `lede` / footnote styling. No new component.

**Test expectation:** none — copy-only change. Visual sanity check on the rendered page.

**Verification:**
- Hint is visible without scrolling past the CTAs on desktop and mobile widths.
- Link target opens GitHub's editor-preference settings page.

---

## System-Wide Impact

- **Interaction graph:** Only `index.html` and a single shell test. No JS, no devcontainer changes (unless U2 finds a bug).
- **Error propagation:** None — static HTML.
- **State lifecycle risks:** Stale browser cache on `gh-pages` could serve old URLs for a short window after push; mitigated by the existing direct-push workflow + standard CDN TTL.
- **API surface parity:** All six links must carry the same parameter set. The link-shape test enforces this.
- **Unchanged invariants:** Devcontainer images, extension lists, session content, and visual design are not modified.

---

## Risks & Dependencies

| Risk | Mitigation |
|------|------------|
| `editor=web` is undocumented on `codespaces.new` and may be ignored or change behavior. | U1 verification step in two browsers; U3 fallback hint as safety net. |
| Users with desktop VS Code already running may still have `vscode://` handler intercept the launch. | U3 fallback hint addresses this directly. |
| `${localWorkspaceFolderBasename}` token resolves differently in codespaces.new than in local devcontainers. | U2 verification step; if broken, hardcode `/workspaces/isd-vscode-training/session-N` in the affected devcontainer. |

---

## Sources & References

- Origin plan: [docs/plans/2026-05-06-003-feat-switch-to-github-codespaces-plan.md](../plans/2026-05-06-003-feat-switch-to-github-codespaces-plan.md)
- Landing page: `index.html`
- Link-shape test: `.tests/test-codespaces-links.sh`
- GitHub docs: Setting your default editor for Codespaces — https://docs.github.com/en/codespaces/customizing-your-codespace/setting-your-default-editor-for-github-codespaces
