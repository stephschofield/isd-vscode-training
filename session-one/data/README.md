# Data — Lab 1

This folder contains the messy starting dataset for Lab 1. The cleaned
reference answer lives in [`../solutions/`](../solutions/) — a deliberate
split so the answer key isn't sitting next to attendees' working surface.

> **Attendees:** you don't need to read this file. Open
> [`../lab/01-cleanup.md`](../lab/01-cleanup.md) and follow the walkthrough.

## Files

| File | Purpose |
|------|---------|
| `raw_submissions.csv` | The intentionally messy starting dataset. ~177 rows. This is what attendees clean. |

The canonical cleaned dataset (`clean_submissions.csv`, ~162 rows) lives
in [`../solutions/`](../solutions/README.md) and is used as the Part 5
sanity-check reference and the handoff into Session 2.

## Schema

The raw CSV (and the cleaned CSV in `../solutions/`) share the same 12 columns:

| Column | Notes |
|--------|-------|
| `submission_id` | UUID per submission. |
| `speaker_name` | Full name. Raw has case drift, trailing whitespace, and `Dr.` / `Dr` prefix variants. |
| `speaker_email` | Primary contact email. Raw has ~6 speakers with two different emails (dup signal). |
| `company` | Speaker's company. Raw has inconsistent capitalization and abbreviations. |
| `talk_title` | Proposed talk title. Raw has ~5 duplicate talk submissions and ~5 talks with conflicting session lengths. |
| `topic_tag` | Free-text topic. Raw has ~26 surface forms across 6 canonical topics (`AI`, `Cloud`, `Data`, `Security`, `DevOps`, `Leadership`). |
| `track_preference` | `Technical Deep Dive` / `Strategy` / `Workshop`. Raw has typos and blank fields. |
| `session_length_min` | `30`, `45`, or `60`. Raw has `"30 min"`, `"thirty"`, `"1 hour"`, etc. |
| `submission_date` | Submission date. Raw mixes ISO (`2026-05-12`), US slash (`5/12/26`), long-form (`May 12, 2026`), and a few 2025 outliers (out-of-window). |
| `bio_short` | Free-text speaker bio. Mostly fine; a few are blank in raw. |
| `experience_level` | `Beginner` / `Intermediate` / `Advanced`. Raw has `novice`, `expert`, blanks. |
| `requires_av` | `Yes` / `No`. Raw has `TRUE` / `FALSE` / `1` / `0` / `Y` / `N` / blank. |

## Mess injected into raw

The raw dataset deliberately includes every mess category from the
Session 1 data-cleanup lab plan (Unit 2). The numbers below are the
actual counts in the current dataset; the plan's `~N` figures are
guidance, and the `verify_dataset.py` script in the upstream source
repo (`stephschofield/isd-vscode-session1`, private) is the
authoritative contract (it asserts "at least N" thresholds for each
category).

1. ~6 speakers submitting under two different emails (same person, different `speaker_email`).
2. ~5 duplicate talk submissions (same `talk_title`, same speaker, two `submission_id`s).
3. Mixed date formats — ISO, US slash, and long-form all coexist.
4. ~26 topic surface forms collapsing to 6 canonical topics.
5. ~24 rows (across the seeded duplicates) where `session_length_min` conflicts for the same `talk_title`.
6. ~12 blank cells across `track_preference` and `experience_level` (split evenly).
7. 3 rows with submission dates outside the 2026 program window.
8. ~10 surface forms for `requires_av` (`Yes` / `No` / `TRUE` / `FALSE` / `1` / `0` / `Y` / `N` / blank).

The first 30 rows are arranged so the topic chaos is visible on first
scroll — attendees see the problem space immediately when they open the file.

## How this was generated

Both CSVs (`data/raw_submissions.csv` and `solutions/clean_submissions.csv`)
are produced by a deterministic generator (`generate_dataset.py`, fixed
seed `SEED = 20260430`) that lives in the upstream source repo
(`stephschofield/isd-vscode-session1`, private). They are committed to
`main` here so attendees work from a known, stable starting point.

To regenerate, clone the source repo and run its `scripts/`:

```bash
python3 scripts/generate_dataset.py
python3 scripts/verify_dataset.py
```

Per plan 001: **do not regenerate between dry-run and live session.**
Attendees should see the same data as the dry-run validated against.

## How this is verified

The `verify_dataset.py` script in the upstream source repo is the
prep-time acceptance check for the leads. It reads `data/raw_submissions.csv`
and `solutions/clean_submissions.csv` and asserts:

- Raw row count is 150–250
- Every injected mess category is present at the expected magnitude
- Mess is visible in the first 30 rows
- Clean has fewer rows than raw (dedup happened)
- Clean uses a single ISO date format
- Clean topics are exactly the 6 canonical values
- Clean has zero blank required fields
- Clean has no duplicate speakers and no duplicate talks per speaker
- All clean dates are inside the 2026 program window

If you change the generator, run the verifier — both must stay green
before you commit.

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

Use this as a fallback if the script ever rots. The script is the source
of truth; this prompt documents the intent so it can be reproduced from
scratch.
