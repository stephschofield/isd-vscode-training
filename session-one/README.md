# Meridian Solutions Innovation Summit — Session 1

> The fictional **Meridian Solutions Innovation Summit** is coming up, and the
> speaker submissions are a mess. You're going to clean them up — with
> GitHub Copilot as your "+1."

## What you'll do today

- Open a real-feeling, intentionally messy CSV of speaker submissions in VS Code.
- Use **Copilot Chat** to spot the problems, propose fixes, and clean the data with you in the driver's seat.
- Walk away with a tidy dataset on your laptop and a working mental model: *I'm the strategist. Copilot is my junior analyst.*

You won't write any code. You won't run any scripts. You'll mostly point, click, read, and prompt.

The whole lab takes **60 minutes**, in six short parts.

## What you need

- A **GitHub account** — sign up free at [github.com/signup](https://github.com/signup) if you don't have one yet. Everything in this lab is gated on it (it's how you sign in to Copilot and how VS Code's `Git: Clone` reaches this repo).
- **VS Code** installed.
- **GitHub Copilot** extension installed and signed in. Parts 2–5 use **Agent mode**; Ask mode alone won't let Copilot edit files. If you only see Ask mode, flag your facilitator at the door.
- **Git** installed locally (VS Code's `Git: Clone` shells out to it). If you don't have it, install from [git-scm.com/downloads](https://git-scm.com/downloads), or ask your facilitator for the pre-cloned folder fallback.
- About **60 minutes** of focus and a willingness to argue with Copilot.

## Start here

Open the lab walkthrough and follow it step-by-step:

**[`lab/01-cleanup.md`](lab/01-cleanup.md)**

Keep that file open in VS Code's preview pane on one side, and the data file (`data/raw_submissions.csv`) open on the other. The walkthrough tells you when to switch between them.

## What's in this folder

| Folder | What's in it |
|--------|--------------|
| [`lab/`](lab/) | Your step-by-step walkthrough for today |
| [`data/`](data/) | The messy submissions file you'll clean, plus a "good answer" reference |
| [`prompts/`](prompts/) | A copy/paste bank of every Copilot prompt used in the session |
| [`facilitator/`](facilitator/) | Notes for whoever is leading the session — you can ignore this |

## I missed Lab 1 — I'm here for Lab 2

Welcome. You don't need to do this lab to keep up. The cleaned dataset for Lab 2 is already prepared for you in the Session 2 repo. If you'd like a quick look at where Lab 2 picks up, open [`solutions/clean_submissions.csv`](solutions/clean_submissions.csv) — that's the same file you'll start Lab 2 with.

## A note on the scenario

Meridian Solutions, the Innovation Summit, the speakers, the talks, and the companies are all made up. Any resemblance to real people or events is coincidental. The mess in the data, however, is depressingly realistic.
