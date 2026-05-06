---
title: "feat: Switch attendee on-ramp from vscode.dev to GitHub Codespaces"
type: feat
status: active
date: 2026-05-06
---

# feat: Switch attendee on-ramp from vscode.dev to GitHub Codespaces

## Summary

Replace every `vscode.dev/github/...` entry point in the training repo and on
the `gh-pages` landing page with a `codespaces.new/...` deep link, and add
per-session `.devcontainer/devcontainer.json` files that auto-install
`GitHub.copilot` + `GitHub.copilot-chat` so attendees can use **Copilot Agent
mode in the browser**. Lab content is unchanged; only entry points and the
container config are new.

---

## Problem Frame

`vscode.dev` is a client-only editor — no container, no extension host with
Agent-mode capability. The "Copilot as your +1" framing in this lab series
specifically wants attendees in **Agent mode** (Parts 2–5 of Lab 1 already
require it per `session-one/README.md`), and that only works against a real
VS Code environment. GitHub's published guidance is that
Codespaces + VS Code Web + the Copilot extension is the supported
browser-only path for Agent mode. The current pills and CTAs route attendees
to a tool that cannot deliver the lab outcome.

---

## Requirements

- R1. Every attendee-facing entry point ("Open in VS Code", session pills,
  README link tables, lab walkthrough mentions) opens a GitHub Codespace
  scoped to the correct session, in the VS Code Web client.
- R2. The Codespace boots with `GitHub.copilot` and `GitHub.copilot-chat`
  pre-installed so Agent mode is available without attendees touching the
  Extensions panel.
- R3. Each session's Codespace opens with that session's folder as the
  workspace root (so the existing "open the README inside the folder" flow
  still works).
- R4. Attendees on a personal GitHub free tier can complete all three labs
  without exhausting their Codespaces quota (rough budget: ≤ 6 core-hours
  total).
- R5. The `gh-pages` landing page (`index.html`) deploys with the new links
  via the existing direct-push workflow — no PR, no separate deploy step.
- R6. Late joiners who land on the repo via GitHub's "Code → Codespaces" UI
  (not the landing page) still get a usable container — the per-session
  devcontainers must each be independently selectable.

---

## Scope Boundaries

- Desktop VS Code instructions are not in scope. Browser-only.
- Org-level Copilot license provisioning is assumed already done.
- No fallback path for attendees without a Copilot subscription.
- No changes to lab pedagogy, prompts, datasets, or scenario content.
- The pre-existing CRLF→LF churn on `session-one/data/{clean,raw}_submissions.csv` is unrelated and stays out of this plan.
- No migration off the `gh-pages` deploy model; we keep direct-push.

### Deferred to Follow-Up Work

- **Codespaces prebuilds** to cut cold-start time below ~60s: defer until
  attendees actually report the wait is painful. Adding a prebuild config
  later is additive and doesn't invalidate this plan.
- **Org-paid Codespaces billing** for attendees who have burned their free
  quota: facilitator workaround documented in U5; org-level billing change
  is a separate ops decision.

---

## Context & Research

### Relevant Code and Patterns

- `README.md` — top-level link table (rows for Lab 1 / 2 / 3) currently
  points at `https://vscode.dev/github/stephschofield/isd-vscode-training/tree/main/session-N`.
- `session-one/README.md`, `session-two/README.md`, `session-three/README.md`
  — each has its own intro that references opening in VS Code; varies in
  wording, so each needs its own pass.
- `session-one/lab/01-cleanup.md`, `session-two/lab/02-synthesis.md`,
  `session-three/lab/03-*.md` — walkthroughs may say "in VS Code" or link
  back to vscode.dev; each needs to be grepped and updated.
- `gh-pages` branch, `index.html` — the three pills and three "Open in VS
  Code" CTAs currently point to `vscode.dev/github/...` URLs (lines ~407,
  414, 422, 429, 437, 444 in the version on `gh-pages`). The pills were
  just relabeled to "Session One/Two/Three" in commits `a2d5521` / `edb5a16`
  — this plan keeps that labeling and only swaps the `href` and the CTA
  copy.
- Existing in-repo plan `docs/plans/2026-05-06-001-test-verify-vscode-dev-links-plan.md` — verification approach there (open each link, confirm it loads the right folder) is the same shape we'll mirror in U5.

### Institutional Learnings

- From last session's handoff (`.remember/remember.md`): pushing to
  `gh-pages` IS the deploy. No PR. GitHub Pages auto-rebuilds.
- CSV files in `session-one/data/` flip to "modified" on every branch
  switch due to `.gitattributes` line-ending normalization — ignore them
  during this work.

### External References

- GitHub Docs — *Facilitating quick creation and resumption of codespaces*: documents the
  `codespaces.new/OWNER/REPO` URL with `?quickstart=1` for "Welcome" tour.
- GitHub Docs — *Using GitHub Copilot in GitHub Codespaces*: confirms
  Copilot works in any Codespace opened in the VS Code web client when the
  extension is installed, and that adding `GitHub.copilot` to
  `devcontainer.json` auto-installs it.
- GitHub Changelog (2025-04-11) — VS Code Copilot Agent mode is available
  in Codespaces; opening from an issue's Development section enables Agent
  mode automatically. Manual install of `GitHub.copilot-chat` covers the
  same ground for our entry path.
- The `devcontainer_path` query parameter on `codespaces.new` is the
  community-standard way to target a non-root devcontainer (used in
  GitHub's own "Open in Codespaces" badges across template repos). Verify
  behavior in U5.

---

## Key Technical Decisions

- **Per-session devcontainers** (3 files), not a single root container.
  Rationale: matches the existing self-contained-folder UX; each pill opens
  its session as the workspace root.
- **`codespaces.new` deep link with `devcontainer_path` + `quickstart=1`**
  per session. Rationale: shortest URL that targets a specific container
  config; `quickstart=1` shows the "Welcome" tour for first-time attendees.
- **No prebuilds in v1.** Rationale: cold-start is ~60–90s on a 2-core
  machine, acceptable for a 60-minute lab; prebuilds add billing/config
  surface area we don't need yet.
- **Default 2-core machine.** Rationale: labs are markdown + small CSVs;
  the cheapest tier keeps attendees inside the 60 core-hour free quota.
- **Keep pill labels as "Session One/Two/Three"** (unchanged from
  `a2d5521`/`edb5a16`). Rationale: the labels read naturally without
  leaking infrastructure ("Open in Codespaces" leaks the tool); change only
  the `href` and update the CTA button text.
- **`postCreateCommand` left empty in v1.** Rationale: nothing to install
  beyond the Copilot extensions; Python/Node aren't needed for the labs.

---

## Open Questions

### Resolved During Planning

- **Per-session vs single-root devcontainer?** Per-session, confirmed by user.
- **Pill copy?** Keep "Session One/Two/Three" (matches just-shipped change).
- **Machine size?** Default 2-core.

### Deferred to Implementation

- **Exact CTA button copy** ("Open in VS Code" → ?). Candidates:
  "Open in browser", "Launch session", "Start lab". Decide during U4 by
  reading the rendered page.
- **Whether to add a one-line note in each session README** about the
  ~60–90s codespace boot. Decide during U3 after seeing the actual delay.

---

## Output Structure

```
session-one/
├── .devcontainer/
│   └── devcontainer.json        ← new (U1)
session-two/
├── .devcontainer/
│   └── devcontainer.json        ← new (U1)
session-three/
├── .devcontainer/
│   └── devcontainer.json        ← new (U1)
README.md                         ← modified (U2)
session-one/README.md             ← modified (U3)
session-two/README.md             ← modified (U3)
session-three/README.md           ← modified (U3)
session-one/lab/01-cleanup.md     ← maybe modified (U3) — verify by grep
session-two/lab/02-synthesis.md   ← maybe modified (U3)
session-three/lab/*.md            ← maybe modified (U3)

gh-pages branch:
└── index.html                    ← modified, direct push (U4)
```

---

## Implementation Units

- U1. **Add per-session devcontainer files**

**Goal:** Each session folder has a `.devcontainer/devcontainer.json` that
boots a Codespace with Copilot + Copilot Chat pre-installed, opens the
session folder as the workspace, and asks for no other tooling.

**Requirements:** R2, R3, R6

**Dependencies:** None.

**Files:**
- Create: `session-one/.devcontainer/devcontainer.json`
- Create: `session-two/.devcontainer/devcontainer.json`
- Create: `session-three/.devcontainer/devcontainer.json`

**Approach:**
- Use the `mcr.microsoft.com/devcontainers/universal:2` base image (or the
  smaller `base:ubuntu` if the universal image is overkill — decide during
  implementation by checking spin-up time on a test Codespace).
- `name`: "Meridian Summit — Session N (Lab N · <Verb>)" so the Codespaces
  picker is readable.
- `customizations.vscode.extensions`: `["GitHub.copilot", "GitHub.copilot-chat"]`.
- No `postCreateCommand`, no `features`, no port forwards.
- Each file is identical except for `name`. Keep them as three files
  (don't try to symlink or share) — `devcontainer_path` needs them to
  exist independently.

**Patterns to follow:**
- GitHub's published `devcontainer.json` examples for "minimal Copilot-ready
  container" (small, two extensions, no extras).

**Test scenarios:**
- Happy path: With the file in place on a feature branch, opening
  `https://codespaces.new/stephschofield/isd-vscode-training/tree/<branch>?devcontainer_path=session-one/.devcontainer/devcontainer.json&quickstart=1`
  in a browser produces a Codespace where (a) the workspace root is
  `session-one/`, (b) Copilot icon appears in the activity bar without
  manual install, (c) Copilot Chat opens and Agent mode is selectable.
- Edge case: A second concurrent codespace for the same repo on the same
  account uses `session-two/`'s container — the two don't collide on
  workspace or extension state.
- Integration: After the Codespace is up, signing into Copilot via the
  extension prompt grants Agent mode without restarting the Codespace.

**Verification:**
- Three new files exist, each ≤ 25 lines, valid JSON, readable.
- Manual smoke test (one session is enough at this stage; the full
  three-link sweep is U5).

---

- U2. **Update top-level `README.md` link table**

**Goal:** The top-level repo README points attendees at Codespaces, not
vscode.dev, and the wording matches what they'll see in their browser.

**Requirements:** R1

**Dependencies:** U1 (the devcontainer paths referenced in the URLs must
exist on `main` for the links to work).

**Files:**
- Modify: `README.md`

**Approach:**
- Replace each of the three `https://vscode.dev/github/...` URLs in the
  link table with the matching `codespaces.new` deep link.
- Update the column header from "Open in VS Code" to "Open in browser"
  (final wording TBD per Open Questions).
- Update the "Before your first lab" and "During each lab" sections to
  reflect that attendees no longer need a local clone or local VS Code —
  the browser is enough. Keep the local-clone path mentioned as an
  optional fallback (it still works).
- Leave the alphabetical-sort-order note untouched.

**Patterns to follow:**
- Existing table structure and tone in `README.md`.

**Test scenarios:**
- Happy path: `grep -n vscode.dev README.md` returns no matches after the
  edit.
- Happy path: Each new URL, copy-pasted into a browser, lands in a
  Codespace whose workspace root matches the labeled session.
- Edge case: A reader who has no GitHub account reaches the README — the
  prose still tells them they need a free GitHub signup (currently in
  `session-one/README.md`'s "What you need" section; check the top-level
  doesn't contradict).

**Verification:**
- No `vscode.dev` substring remains in `README.md`.
- All three new links resolve to a Codespace pointing at the right folder.

---

- U3. **Update per-session READMEs and lab walkthroughs**

**Goal:** Attendees who land directly on a session folder (via GitHub UI,
late-joiner link, or the landing page) see consistent Codespace-based
instructions, with no stale references to vscode.dev or "open in VS
Code desktop".

**Requirements:** R1

**Dependencies:** U1.

**Files:**
- Modify: `session-one/README.md`
- Modify: `session-two/README.md`
- Modify: `session-three/README.md`
- Modify: `session-one/lab/01-cleanup.md` *(if grep finds entry-point references)*
- Modify: `session-two/lab/02-synthesis.md` *(if grep finds entry-point references)*
- Modify: `session-three/lab/*.md` *(if grep finds entry-point references)*

**Approach:**
- First, run `grep -rni "vscode.dev\|vscode-dev\|open in vs code\|vs code desktop" session-*/` to enumerate every spot that needs updating. Treat the grep output as the authoritative work list — don't trust this plan's enumeration.
- For each session README's "What you need" / "How to start" sections,
  replace the vscode.dev framing with a single sentence pointing at the
  Codespaces link from the landing page or top-level README.
- In `session-one/README.md`, the "Git installed locally" requirement
  becomes optional (Codespaces handles it). Keep the local-clone fallback
  paragraph but de-emphasize it.
- For lab walkthroughs, only change passages that describe **how to enter
  the editor**. Do not touch passages about how to use Copilot Chat /
  Agent mode inside the editor — those are unchanged.

**Patterns to follow:**
- Tone and structure of the existing per-session READMEs.

**Test scenarios:**
- Happy path: After edits, `grep -rni "vscode.dev" session-*/` returns
  zero matches.
- Happy path: After edits, `grep -rni "open in vs code" session-*/` either
  returns zero matches, or returns only matches that have been intentionally
  rephrased to reference the landing page.
- Edge case: A late joiner reading only `session-two/README.md` (no
  context from session one) can still get into a working Codespace.

**Verification:**
- Grep-clean for stale entry-point language across all three session
  trees.
- Each session README's first 30 lines tell an attendee how to get
  started without ambiguity.

---

- U4. **Update `gh-pages` landing page (`index.html`)**

**Goal:** The deployed landing page at
`https://stephschofield.github.io/isd-vscode-training/` opens Codespaces,
not vscode.dev.

**Requirements:** R1, R5

**Dependencies:** U1 must be merged to `main` first — otherwise the
landing page links 404 the `devcontainer_path`.

**Files:**
- Modify: `index.html` *(on the `gh-pages` branch only — this file does not exist on `main`)*

**Approach:**
- Check out `gh-pages`. **Do not open a PR.** This branch is the deploy.
- Update three pill `<a href>` attributes (currently `https://vscode.dev/github/stephschofield/isd-vscode-training/tree/main/session-N`)
  to `https://codespaces.new/stephschofield/isd-vscode-training/tree/main?devcontainer_path=session-N/.devcontainer/devcontainer.json&quickstart=1`.
- Update three CTA `<a class="cta">` `href` attributes to the same URLs.
- Update CTA button text from "Open in VS Code" to the agreed copy
  (decide in implementation).
- Update `aria-label` attributes to match the new tool name (replace
  "VS Code for the web" with "GitHub Codespaces").
- Update the `<meta name="description">` if it still mentions VS Code in a
  way that's now misleading.
- Update the three "How it works" steps in the page body — step 2 currently
  says "vscode.dev opens the folder live — no install, no clone." Rewrite
  to mention Codespaces and the ~60s boot.
- Commit with a clear message; push directly to `origin/gh-pages`.

**Patterns to follow:**
- The just-shipped `a2d5521` / `edb5a16` commits — same surgical-edit
  pattern (only `href`/text/aria, no structural changes).

**Test scenarios:**
- Happy path: After Pages rebuild, all three pills and all three CTAs on
  the live site open a Codespace whose workspace root matches the label.
- Happy path: `grep -n vscode.dev index.html` on `gh-pages` returns zero
  matches.
- Edge case: Page loads in a private/incognito window and the links still
  work for an attendee who isn't signed into GitHub yet (Codespaces will
  prompt for sign-in — confirm the prompt is reasonable).
- Edge case: Mobile viewport — the pill labels are unchanged length, so
  layout should be intact, but eyeball-verify.

**Verification:**
- `git log origin/gh-pages` shows the new commit on top.
- Live URL (after Pages rebuild, ~1–2 min) reflects the change.
- All six links open Codespaces, not vscode.dev.

---

- U5. **End-to-end verification sweep**

**Goal:** Walk every attendee entry point as if you were a fresh attendee
and confirm the full flow works.

**Requirements:** R1, R2, R3, R4, R6

**Dependencies:** U1, U2, U3, U4 all landed.

**Files:**
- *(no file changes; this is a verification unit. Findings get logged in
  the PR description for U1–U3 and the `gh-pages` commit for U4.)*

**Approach:**
- Open the live landing page in a fresh browser profile (no GitHub
  session). Click Session One pill. Sign into GitHub when prompted. Wait
  for Codespace boot. Confirm: workspace root is `session-one/`,
  Copilot icon is present, Agent mode is selectable in Copilot Chat,
  README opens in preview pane.
- Repeat for Session Two and Session Three.
- From the `stephschofield/isd-vscode-training` repo page, click
  "Code → Codespaces → Create codespace on main". Confirm the picker
  shows three named devcontainer configs and each one opens its own
  session as the workspace root.
- Open `session-one/lab/01-cleanup.md` inside a running Codespace.
  Confirm Agent mode can edit `data/raw_submissions.csv` (this is the
  one Lab 1 actually exercises and is the most likely real failure mode
  of the whole change).
- Time the cold-start of one fresh Codespace; if > 120s, file a follow-up
  task to add a prebuild.
- Tally rough core-hours used during verification and confirm against
  R4's budget.

**Patterns to follow:**
- The verification approach in `docs/plans/2026-05-06-001-test-verify-vscode-dev-links-plan.md`.

**Test scenarios:**
- Integration: Full attendee flow per session (landing page → Codespace
  → Copilot Agent mode → file edit). Three runs, one per session.
- Integration: GitHub UI flow (Code → Codespaces → pick config). Three
  configs visible, each opens correctly.
- Edge case: Concurrent Codespaces — open Session One and Session Two at
  the same time; confirm no state collision.
- Edge case: Attendee with zero remaining Codespaces free-tier quota —
  the link should produce a clear billing error rather than a silent
  failure. Document the facilitator workaround.

**Verification:**
- All three pills work end-to-end in a fresh browser.
- All three GitHub-UI codespace configs work end-to-end.
- Agent mode confirmed live in at least one session.
- Cold-start time recorded; under threshold or follow-up task filed.

---

## System-Wide Impact

- **Interaction graph:** The change couples the `gh-pages` branch's
  `index.html` to the existence of three specific paths on `main`
  (`session-{one,two,three}/.devcontainer/devcontainer.json`). If any of
  those files are renamed or moved, the live landing page's links 404
  silently — there's no test for cross-branch path consistency. Mitigation:
  call this out in the PR description for U1 so future contributors know
  the path is load-bearing.
- **Error propagation:** Codespaces failures (quota exhausted, region
  unavailable, image pull failure) surface as GitHub UI error pages, not
  as anything we control. Document the most common one (quota) for
  facilitators.
- **State lifecycle risks:** None on our side; Codespaces handles
  container lifecycle. Attendees who leave a Codespace running burn quota
  — facilitator note worth adding.
- **API surface parity:** The `gh-pages/index.html` and the top-level
  `README.md` link table both expose the same set of links and must stay
  in sync. Three places ×  three sessions = nine href values; treat them
  as one logical surface.
- **Integration coverage:** U5 is the only thing that proves the full
  attendee path actually works. Don't skip it.
- **Unchanged invariants:** Lab content, prompt library, datasets, and
  facilitator notes are unchanged. The `gh-pages` deploy model is
  unchanged (direct push). The `.gitattributes` line-ending normalization
  behavior is unchanged.

---

## Risks & Dependencies

| Risk | Mitigation |
|------|------------|
| `devcontainer_path` query parameter syntax differs from the form GitHub renders in its own templates and silently ignores our value, dumping attendees into a root-folder Codespace. | U5 verification is the only gate; if it fails, fall back to per-session deep links of the form `codespaces.new/.../tree/main/session-N` (relies on GitHub auto-detecting the nearest devcontainer). |
| Cold-start time exceeds attendee patience (~2 min). | Time it in U5; if > 120s, file follow-up to add a prebuild. Not a blocker for v1. |
| Attendee free-tier Codespaces quota is exhausted. | Document org-paid Codespaces or a personal-card workaround in facilitator notes; out of scope for this plan but flag at the door. |
| Copilot Agent mode rollout is account-flagged and not universally available. | The 2025-04 GA changelog says it's available for Codespaces broadly, but facilitator should test on a clean attendee-style account before each cohort. |
| Stale `vscode.dev` links survive in lab walkthroughs because the grep was incomplete. | U3 explicitly grounds the work list in `grep -rni`, not in this plan's enumeration. |
| `gh-pages` and `main` drift — devcontainer paths get renamed without updating `index.html`. | One-line CODEOWNERS or PR-template note out of scope; mention in U4's commit message so it's discoverable in `git log`. |

---

## Documentation / Operational Notes

- Facilitator notes (in `session-*/facilitator/`) may need a one-line
  update if they currently say "open in vscode.dev" — sweep during U3.
- After U4 ships, watch the GitHub Pages build once and confirm the live
  site rebuilt cleanly (per institutional learning: it auto-rebuilds, no
  intervention needed, but eyeball it).
- Add a one-liner to facilitator-side prep notes: "Ask attendees to test
  the Session One link 24h before the lab so codespace creation issues
  surface early."

---

## Sources & References

- Origin: this plan is the authoritative source (no upstream brainstorm doc).
- Related plan: `docs/plans/2026-05-06-001-test-verify-vscode-dev-links-plan.md` — its verification approach is reused in U5.
- Related commits on `gh-pages`: `a2d5521`, `edb5a16` (pill relabeling).
- GitHub Docs — "Facilitating quick creation and resumption of codespaces" — `https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/setting-up-your-repository/facilitating-quick-creation-and-resumption-of-codespaces`
- GitHub Docs — "Using GitHub Copilot in GitHub Codespaces" — `https://docs.github.com/en/codespaces/reference/using-github-copilot-in-github-codespaces`
- GitHub Changelog (2025-04-11) — "VS Code Copilot Agent mode in Codespaces" — `https://github.blog/changelog/2025-04-11-vscode-copilot-agent-mode-in-codespaces/`
