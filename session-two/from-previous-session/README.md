# From the previous session (Lab 1)

This folder is your handoff from Lab 1. If you missed Lab 1, this 2-minute
read gets you fully equipped to participate in Lab 2.

## What happened in Lab 1

The Innovation Summit speaker submissions arrived as a mess: ~200 rows of
duplicates, inconsistent topic tags ("AI", "A.I.", "Artificial
Intelligence"), mixed date formats, conflicting session lengths for the
same talks, and rogue out-of-window dates. Attendees used Copilot Chat as
a junior analyst — prompting it to surface duplicates, normalize the topic
taxonomy down to six canonical categories, standardize dates and session
lengths, and surface the two-or-three out-of-window submissions for human
review rather than silently dropping them. After review, the out-of-window
rows were excluded from the cleaned snapshot you see here — they are not
present in `clean_submissions.csv`.

The lesson: AI is great at the *mechanical* work humans hate doing (dedup,
normalization, format wrangling) — *if* the human stays in the loop and
reviews each proposed change.

## What you're inheriting

[`clean_submissions.csv`](clean_submissions.csv) — the result of Lab 1,
checked in here verbatim. It contains the deduplicated, normalized speaker
submissions: one row per unique talk submission, six canonical topic tags,
ISO-formatted dates, integer session lengths in minutes, and a clean
boolean for the AV requirement. This is your **source of truth** for
today. Treat it as finished.

## What you need to know today

The dataset is **sealed** in Lab 2. If you spot residual data issues, jot
them down in your own notes — but don't fix them in the file. Today's job
is synthesis, not cleanup. Keeping the dataset frozen keeps the room
synced and lets you focus on the harder, more interesting work:
extracting themes that hold up to a fight.
