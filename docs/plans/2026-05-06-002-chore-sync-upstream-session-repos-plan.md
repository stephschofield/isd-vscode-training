---
title: "chore: Sync session-one/two/three with upstream isd-vscode-session{1,2,3} main branches"
type: chore
status: active
date: 2026-05-06
---

# chore: Sync session-one/two/three with upstream isd-vscode-session{1,2,3} main branches

## Summary

The `isd-vscode-training` mono-repo mirrors three internal source-of-truth
repos (`stephschofield/isd-vscode-session{1,2,3}`). Several PRs have
landed upstream that have not yet been republished here. Bring
`session-one/`, `session-two/`, and `session-three/` to byte-equivalent
parity with upstream `main`, except for files intentionally excluded from
the public training repo (LICENSE/.git/.github/.vscode/backlog/docs/
facilitator/scripts/tests, plus `.gitignore`/`.atv`/`.gitattributes`).

---

## Problem Frame

Lab content lives in private upstream repos, then gets manually
republished into this public training repo. Drift exists:

- **session-one**: upstream did the `clean_submissions.csv → solutions/`
  refactor (PR #13) — local still has it under `data/`.
- **session-two**: upstream renamed `outputs/ → solutions/` (PR #10) —
  most files exist locally but transcripts, theme-session-map,
  options-memo, themes, lab, prompts, README differ.
- **session-three**: upstream landed the 60-min `.pptx`/`.docx` pivot
  (PR #8) — local has older briefing/deck/templates/scripts/README.

Until republished, attendees see stale content vs the canonical labs.

---

## Requirements

- R1. `session-one/` matches upstream `isd-vscode-session1` main, except
  excluded folders/files (see Scope).
- R2. `session-two/` matches upstream `isd-vscode-session2` main, except
  excluded folders/files.
- R3. `session-three/` matches upstream `isd-vscode-session3` main,
  except excluded folders/files.
- R4. `clean_submissions.csv` and `regenerate_clean.py` move out of
  `session-one/data/` and into a new `session-one/solutions/` folder, so
  the answer key is no longer next to the attendee working surface.
- R5. The top-level repo `README.md` is left untouched (it is
  training-repo-specific, not mirrored from any upstream).
- R6. After sync, `git diff` between each local session folder and the
  corresponding upstream working tree shows nothing except the
  intentional exclusions.

---

## Scope Boundaries

**Excluded** (never copied from upstream, even if present):

- `.git/`, `.github/`, `.vscode/`, `.gitignore`, `.gitattributes`, `.atv/`
- `LICENSE` (the public training repo has its own root LICENSE)
- `backlog/`, `docs/`, `facilitator/`, `scripts/`, `tests/` — internal
  planning/automation; not attendee-facing

**Out of scope:**

- Modifying upstream repos
- Changing `gh-pages` branch / `index.html`
- Touching root `README.md`, `CODEOWNERS`, root `LICENSE`, root `docs/`
- The pre-existing unstaged CRLF diff in
  `session-one/data/clean_submissions.csv` and
  `session-one/data/raw_submissions.csv` (those files are about to move
  or be replaced anyway)

### Deferred to Follow-Up Work

- None.

---

## Context & Research

### Relevant Code and Patterns

- `/tmp/upstream/isd-vscode-session1` — depth-1 clone, head
  `a39ac2b Merge PR #13 refactor/move-clean-csv-to-solutions`.
- `/tmp/upstream/isd-vscode-session2` — depth-1 clone, head
  `fe30d5a Merge PR #10 refactor/rename-outputs-to-solutions`.
- `/tmp/upstream/isd-vscode-session3` — depth-1 clone, head
  `d1c7a3e Merge PR #8 feat/lab3-60min-pptx-docx-pivot`.

### Diff Summary (computed by `diff -rq`)

**session-one**

- `README.md`, `data/README.md`, `lab/01-cleanup.md`,
  `prompts/01-prompts.md` — content drift.
- `data/clean_submissions.csv`, `data/regenerate_clean.py` — must move
  to `solutions/`.
- New `solutions/README.md`, `solutions/clean_submissions.csv` from
  upstream.

**session-two**

- `README.md`, `lab/02-synthesis.md`, `prompts/02-prompts.md`,
  `from-previous-session/README.md`,
  `from-previous-session/clean_submissions.csv` — content drift.
- `inputs/transcripts/{eng-director-priya,exec-sponsor-jane,program-lead-marcus}.md`
  — content drift.
- `solutions/theme-session-map.csv` — content drift; local has extra
  `solutions/README.md` (not in upstream — drop).
- Empty `data/` upstream — nothing to copy.

**session-three**

- `README.md`, `final/briefing.md`, `final/deck-outline.md`,
  `from-previous-session/options-memo.md`, `lab/03-briefing.md`,
  `scripts/build-deliverables.{sh,ps1}`,
  `templates/briefing-template.md` — content drift.

---

## Key Technical Decisions

- **Bulk overwrite via `cp -a`, not per-file diffs.** Each upstream file
  is the source of truth; 3-way merging would invent drift. Copy the
  upstream tree on top of the local tree, then `git add -A` only the
  affected session subdirectory.
- **Preserve `.gitkeep` files from upstream** so empty published folders
  (`session-two/data/`, `session-two/lab/`, etc.) survive `git add`.
  They're harmless and match upstream exactly.
- **Drop local-only `session-two/solutions/README.md`** to match
  upstream, which has only `.gitkeep` + the three deliverable files.

---

## Open Questions

### Resolved During Planning

- *Do we want to keep `session-two/solutions/README.md` (local-only
  attendee-facing "don't peek" note)?* Resolved: drop to match upstream
  parity (R6). The lab text already gates when to open solutions.

### Deferred to Implementation

- Whether the line-ending diff in `raw_submissions.csv` reappears after
  copy. If the upstream version normalizes it, great; if not, leave the
  pre-existing working-tree noise alone.

---

## Implementation Units

- U1. **Sync session-one (with solutions/ refactor)**

**Goal:** Make `session-one/` match upstream, including moving
`clean_submissions.csv` + `regenerate_clean.py` out of `data/` into a
new `solutions/` folder.

**Requirements:** R1, R4, R6.

**Dependencies:** None.

**Files:**
- Modify: `session-one/README.md`
- Modify: `session-one/data/README.md`
- Modify: `session-one/lab/01-cleanup.md`
- Modify: `session-one/prompts/01-prompts.md`
- Delete: `session-one/data/clean_submissions.csv`
- Delete: `session-one/data/regenerate_clean.py`
- Create: `session-one/solutions/README.md`
- Create: `session-one/solutions/clean_submissions.csv`

**Approach:**
1. `rsync -a --delete` (or `cp -a` per-file + targeted `rm`) the
   non-excluded parts of upstream session1 over `session-one/`.
2. `git rm` the moved files; `git add` the new `solutions/` folder.
3. Verify final diff is clean.

**Verification:**
- `diff -rq session-one /tmp/upstream/isd-vscode-session1` shows only
  excluded paths (`.git`, `.github`, `.atv`, `.vscode`, `.gitignore`,
  `LICENSE`, `backlog`, `docs`, `facilitator`, `scripts`).

---

- U2. **Sync session-two**

**Goal:** Make `session-two/` match upstream.

**Requirements:** R2, R6.

**Dependencies:** None (parallel-safe with U1, U3).

**Files:**
- Modify: `session-two/README.md`
- Modify: `session-two/lab/02-synthesis.md`
- Modify: `session-two/prompts/02-prompts.md`
- Modify: `session-two/from-previous-session/README.md`
- Modify: `session-two/from-previous-session/clean_submissions.csv`
- Modify: `session-two/inputs/transcripts/eng-director-priya.md`
- Modify: `session-two/inputs/transcripts/exec-sponsor-jane.md`
- Modify: `session-two/inputs/transcripts/program-lead-marcus.md`
- Modify: `session-two/solutions/theme-session-map.csv`
- Modify: `session-two/solutions/options-memo.md` (if drifted)
- Modify: `session-two/solutions/themes.md` (if drifted)
- Delete: `session-two/solutions/README.md`
- Create: `session-two/data/.gitkeep`,
  `session-two/inputs/.gitkeep`,
  `session-two/lab/.gitkeep`,
  `session-two/prompts/.gitkeep`,
  `session-two/solutions/.gitkeep`

**Approach:** Same rsync-overlay pattern as U1.

**Verification:**
- `diff -rq session-two /tmp/upstream/isd-vscode-session2` shows only
  excluded paths.

---

- U3. **Sync session-three**

**Goal:** Make `session-three/` match upstream.

**Requirements:** R3, R6.

**Dependencies:** None.

**Files:**
- Modify: `session-three/README.md`
- Modify: `session-three/final/briefing.md`
- Modify: `session-three/final/deck-outline.md`
- Modify: `session-three/from-previous-session/options-memo.md`
- Modify: `session-three/lab/03-briefing.md`
- Modify: `session-three/scripts/build-deliverables.sh`
- Modify: `session-three/scripts/build-deliverables.ps1`
- Modify: `session-three/templates/briefing-template.md`
- Create: `session-three/final/.gitkeep`,
  `session-three/lab/.gitkeep`,
  `session-three/prompts/.gitkeep`,
  `session-three/templates/.gitkeep`

**Approach:**
- session-three has its own internal `scripts/` for build-deliverables
  that ARE attendee-facing (different from sessions 1/2). Include them
  in sync — the exclusion list applies to upstream-level
  internal-only `scripts/` for s1/s2 only. Verify by reading upstream
  s3's `lab/03-briefing.md` to confirm `scripts/build-deliverables.*`
  is referenced from the attendee walkthrough.

**Verification:**
- `diff -rq session-three /tmp/upstream/isd-vscode-session3` shows only
  excluded paths (`.git`, `.github`, `.gitattributes`, `.gitignore`,
  `.vscode`, `LICENSE`, `backlog`, `docs`, `facilitator`, `tests`).

---

- U4. **Final parity verification + commit + push**

**Goal:** Confirm all three session folders are byte-equivalent to
upstream (modulo exclusions), then commit and push.

**Requirements:** R6.

**Dependencies:** U1, U2, U3.

**Files:**
- All staged via `git add session-one session-two session-three`.

**Approach:**
- Run final `diff -rq` for all three.
- `git status` review; `git commit -m "chore: sync session-{one,two,three} with upstream main"`.
- `git push origin fix/markdown-lint`.

**Verification:**
- `git status` clean (or only the pre-existing working-tree noise).
- `git push` succeeds.

---

## System-Wide Impact

- **Interaction graph:** Lab READMEs cross-link
  `data/clean_submissions.csv` → moves to
  `solutions/clean_submissions.csv` for session-one. The upstream
  README/lab updates already point at the new path.
- **Unchanged invariants:** Top-level `README.md`, `CODEOWNERS`, root
  `LICENSE`, root `docs/`, `gh-pages` branch (vscode.dev hub) — none
  altered.

---

## Risks & Dependencies

| Risk | Mitigation |
|------|------------|
| Overwriting an intentional training-repo-only customization. | Diff each file pre-overwrite; only `session-two/solutions/README.md` is local-only and is intentionally dropped per Key Decisions. |
| `session-three/scripts/` confusion (attendee-facing vs internal). | Verified upstream s3 ships these scripts in main and they're referenced from attendee lab text — include in sync. |
| Line-ending churn in CSVs creates noisy diff. | Rely on git's autocrlf settings; ignore pre-existing `raw_submissions.csv` LF/CRLF noise. |

---

## Sources & References

- Upstream: `stephschofield/isd-vscode-session1` (PR #13)
- Upstream: `stephschofield/isd-vscode-session2` (PR #10)
- Upstream: `stephschofield/isd-vscode-session3` (PR #8)
- Local depth-1 clones: `/tmp/upstream/isd-vscode-session{1,2,3}`
- Branch: `fix/markdown-lint` (current working branch)
