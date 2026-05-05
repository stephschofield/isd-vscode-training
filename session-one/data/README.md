# Data — Lab 1

This folder contains the synthetic speaker submissions dataset used in Lab 1.

> **Attendees:** you don't need to read this file. Open
> [`../lab/01-cleanup.md`](../lab/01-cleanup.md) and follow the walkthrough.

## Files

| File | Purpose |
|------|---------|
| `raw_submissions.csv` | The intentionally messy starting dataset. ~177 rows. This is what attendees clean. |
| `clean_submissions.csv` | The canonical "good answer" — what the dataset looks like after cleanup. ~162 rows. Used as the Part 5 sanity-check reference and as the handoff into Session 2. |

## Schema

Both CSVs share the same 12 columns:

| Column | Notes |
|--------|-------|
| `submission_id` | UUID per submission. |
| `speaker_name` | Full name. Raw has case drift, trailing whitespace, and `Dr.` / `Dr` prefix variants. |
| `speaker_email` | Primary contact email. Raw has ~6 speakers with two different emails (dup signal). |
| `company` | Speaker's company. Raw has inconsistent capitalization and abbreviations. |
| `talk_title` | Proposed talk title. Raw has 13–15 duplicate submission rows across ~5 distinct talks, some appearing under 3 different `submission_id`s. There are also 6 `(revised)` re-submissions paired with `.work` email variants. |
| `topic_tag` | Free-text topic. Raw has ~26 surface forms across 6 canonical topics (`AI`, `Cloud`, `Data`, `Security`, `DevOps`, `Leadership`). |
| `track_preference` | `Technical Deep Dive` / `Strategy` / `Workshop`. Raw has typos and blank fields. |
| `session_length_min` | `30`, `45`, or `60`. Raw has `"30 min"`, `"thirty"`, `"1 hour"`, etc. |
| `submission_date` | Submission date. Raw mixes ISO (`2026-05-12`), US slash (`5/12/26`), long-form (`May 12, 2026`), and a few 2025 outliers (out-of-window). |
| `bio_short` | Free-text speaker bio. Mostly fine; a few are blank in raw. |
| `experience_level` | `Beginner` / `Intermediate` / `Advanced`. Raw has `novice`, `expert`, blanks. |
| `requires_av` | `Yes` / `No`. Raw has `TRUE` / `FALSE` / `1` / `0` / `Y` / `N` / blank. |

## What's messy in the raw file

The raw dataset deliberately includes every kind of mess you'd realistically
find in a submissions inbox:

1. ~6 speakers submitting under two different emails (same person, different `speaker_email`). One of each pair uses a `.work` suffix variant.
2. 13–15 duplicate talk submission rows across ~5 distinct talks (e.g., Aarav Patel has 4 talks each appearing under 3 submission_ids; Bianca Rossi's "What Our Last Incident Taught Us" has 3 submissions). 6 of those duplicates are `(revised)` re-submissions tied to the `.work` email variants in #1 — Part 3 dedup will catch them once the email-canonicalization step collapses the `.work` variant onto the canonical address and the row becomes an exact duplicate. The lab does not teach a separate `(revised)` merge pass.
3. Mixed date formats — ISO, US slash, and long-form all coexist.
4. ~26 topic surface forms collapsing down to 6 canonical topics.
5. ~24 rows (across the seeded duplicates) where `session_length_min` conflicts for the same `talk_title`.
6. ~12 blank cells across `track_preference` and `experience_level` (split evenly).
7. 3 rows with submission dates outside the 2026 program window.
8. ~10 surface forms for `requires_av` (`Yes` / `No` / `TRUE` / `FALSE` / `1` / `0` / `Y` / `N` / blank).

The first 30 rows are arranged so the topic chaos is visible on first
scroll — you'll see the problem space immediately when you open the file.

## How this was generated

This dataset was generated once during prep using GitHub Copilot in agent
mode against a deterministic prompt (see the appendix below). It is
committed to the repo as a frozen, stable starting point for the lab.

During the session, you **will** modify `raw_submissions.csv` in place —
that's the whole point of the lab. Don't modify `clean_submissions.csv`;
it's the reference answer used in Part 5. Everything is git-tracked, so
you can revert any change you don't like via the Source Control panel.

## Generation prompt (the one we'd use with Copilot)

If a future lead wants to regenerate this conversationally with Copilot
instead of via the script, this is the prompt that captures the contract:

```text
Generate a CSV of fictional speaker submissions for the Meridian Solutions
Innovation Summit. ~200 rows, 12 columns:
submission_id, speaker_name, speaker_email, company, talk_title, topic_tag,
track_preference, session_length_min, submission_date, bio_short,
experience_level, requires_av.

The dataset should be intentionally messy. Inject:
- ~6 speakers using two different emails for the same name
- ~5 duplicate talk submissions (same title + speaker, different IDs)
- Mixed date formats: ISO, US slash, long-form, plus 2-3 dates in 2025
  (out of program window)
- ~25 surface forms across 6 canonical topics: AI, Cloud, Data, Security,
  DevOps, Leadership
- ~5 talks with conflicting session_length_min values
- ~10 missing track_preference / experience_level cells
- ~10 surface forms for requires_av (Yes/No/TRUE/FALSE/1/0/Y/N/blank)
- Case drift, trailing whitespace, "Dr." prefix variants in names

Then produce a second CSV (clean_submissions.csv) that is the same dataset
deduplicated and normalized: ISO dates only, exactly 6 topic tags,
canonical track/experience/AV values, numeric session lengths only, no
blank required fields.

Companies, speakers, talks, and bios should all be fictional.
```

This prompt is here as a reference — both for the curious, and for any
future lead who wants to understand what shape of data the lab assumes.
