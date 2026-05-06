# Solutions — Lab 1

This folder holds the canonical "good answer" for Lab 1.

> **Attendees:** you don't need to read this file. Open
> [`../lab/01-cleanup.md`](../lab/01-cleanup.md) and follow the walkthrough.
> Part 5 will tell you when (and why) to look in here.

## Files

| File | Purpose |
|------|---------|
| `clean_submissions.csv` | The canonical cleaned dataset. ~162 rows. Used as the Part 5 sanity-check reference and as the byte-identical handoff into Session 2. |

## Why this is in `solutions/` and not `data/`

`data/` holds the **input** to Lab 1 — the messy `raw_submissions.csv`
attendees clean. `solutions/` holds the **reference answer**. Splitting
them across two folders keeps the answer key out of an attendee's
working surface so a curious Explorer-click doesn't spoil Part 5.

## Schema

The schema is shared with `raw_submissions.csv`. See
[`../data/README.md`](../data/README.md) for the canonical 12-column table
and the mess profile (which the clean file resolves).

## How this is generated and verified

Both CSVs come from the same deterministic generator with a fixed seed
(`SEED = 20260430`):

```bash
python3 scripts/generate_dataset.py
python3 scripts/verify_dataset.py
```

Per plan 001: **do not regenerate between dry-run and live session.** Both
files are committed to `main` so attendees and leads work from the same
known starting point.

`verify_dataset.py` (in the source repo's `scripts/` folder) is the
authoritative contract — it asserts row counts, dedup, ISO dates, the six
canonical topics, no blank required fields, and that every clean date
falls inside the 2026 program window.
