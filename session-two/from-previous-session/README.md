# From the previous session (Lab 1)

This folder is your handoff from Lab 1. If you missed Lab 1, this 2-minute
read gets you fully equipped to participate in Lab 2.

## What happened in Lab 1

The Innovation Summit speaker submissions arrived as a mess: hundreds of
rows of duplicates, inconsistent topic tags ("AI", "A.I.", "Artificial
Intelligence"), mixed date formats, conflicting session lengths for the
same talks, and rogue out-of-window dates. Attendees used Copilot Chat as
a junior analyst — prompting it to surface duplicates, normalize the topic
taxonomy down to a small set of canonical categories, standardize dates
and session lengths, and surface the out-of-window submissions for human
review rather than silently dropping them. After review, the out-of-window
rows were excluded from the cleaned snapshot — they are not present in
`clean_submissions.csv`.

The lesson: AI is great at the *mechanical* work humans hate doing (dedup,
normalization, format wrangling) — *if* the human stays in the loop and
reviews each proposed change.

## What you're inheriting

[`clean_submissions.csv`](clean_submissions.csv) — the cleaned dataset for
today. Each row is one unique talk submission, with normalized topic
tags, ISO-formatted dates, integer session lengths, and a clean boolean
for the AV requirement. This is your **source of truth** for Lab 2.
Treat it as finished.

> **Note for Lab 1 returners:** the cleaned snapshot here is *not*
> byte-identical to the one you produced in Lab 1 — Lab 2 uses a richer,
> wider tag taxonomy (e.g. *AI in Workflows*, *Customer Stories*,
> *Developer Experience*) and a larger row count to give the synthesis
> exercise more material to work with. Same lab, same shape, more
> texture. Use this file as canonical for today.

## What you need to know today

The dataset is **sealed** in Lab 2. If you spot residual data issues, jot
them down in your own notes — but don't fix them in the file. Today's job
is synthesis, not cleanup. Keeping the dataset frozen keeps the room
synced and lets you focus on the harder, more interesting work:
extracting themes that hold up to a fight.
