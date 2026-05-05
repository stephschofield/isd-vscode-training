# From previous sessions — your fastest path to participating today

This folder contains the canonical outputs from **Lab 1** and **Lab 2** of
the ISD +1 Campaign series. If you joined cold, this is your 3-minute
orientation — read this page, glance at the four files below, and you're
ready for Part 0 of [`lab/03-briefing.md`](../lab/03-briefing.md).

## What Lab 1 did

Lab 1 took roughly 200 messy speaker submissions for the Meridian
Innovation Summit — inconsistent capitalization, duplicate entries,
free-text job titles, mixed date formats — and used VS Code + Copilot to
clean them into a single normalized dataset:
[`clean_submissions.csv`](clean_submissions.csv). That file is the source
of truth for every speaker name, session title, and topic referenced in
the rest of the series.

## What Lab 2 did

Lab 2 took the cleaned submissions, layered in stakeholder interviews
and survey signals, and synthesized them into program-shaping outputs:

- [`themes.md`](themes.md) — five recurring themes that emerged across
  the submissions (your evidence pool)
- [`theme-session-map.csv`](theme-session-map.csv) — every cleaned session
  tagged to one or more themes (your timeline source)
- [`options-memo.md`](options-memo.md) — three program-shape options with
  a recommended direction and the reasoning behind it (your spine)

Lab 2 made the call. Lab 3 makes the case for it.

## Your role in Lab 3

You are **advocating for Lab 2's recommended option** — not re-deciding
among the three. The Lab 2 options memo already named the recommendation;
your job today is to translate that into an executive briefing your COO
(Alex Chen) can read in 5 minutes and act on. You'll use the templates in
[`../templates/`](../templates/) to scaffold the briefing, and Copilot Chat
to sharpen your prose section by section.

## File quick reference

- `themes.md` → your evidence pool
- `options-memo.md` → your spine (the recommendation you're advocating for)
- `theme-session-map.csv` → your timeline source
- `clean_submissions.csv` → real speaker + session names you can cite
