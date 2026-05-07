# Lab 1 — Turn Messy Speaker Submissions into a Clean Foundation

> **Scenario:** The Meridian Solutions Innovation Summit is six weeks away.
> The submissions inbox is a mess. You're going to clean it up — with
> Copilot as your "+1."
>
> **What you'll walk away with:** a tidy version of the speaker submissions
> on your laptop, and a working mental model of what it feels like to do
> real strategy work alongside AI.
>
> **Time:** 60 minutes. Six short parts. Each ends with a visible win.

---

## Before we start

You should have:

- A **GitHub account** — sign up free at [github.com/signup](https://github.com/signup) if you don't have one yet. It's how Copilot signs you in and how VS Code's `Git: Clone` reaches this repo.
- VS Code open (you already did the intro session).
- GitHub Copilot signed in (your facilitator confirmed this at the door).
- This file open in **preview mode** on the right side of your screen.

**Open this file in preview:** click the small "Open Preview" icon in the top-right of the editor tab (it looks like a magnifying glass over a page). Or press `Ctrl+Shift+V` (Windows/Linux) / `⌘+Shift+V` (macOS). Preview makes the formatting nicer to read while you work.

If anything in this list isn't true, raise your hand — the facilitator will get you sorted.

---

## Part 0 — Set up your workspace

**Time:** ~8 minutes

### What you're doing
Getting this folder onto your laptop, opening it in VS Code, and getting Copilot Chat ready in a side panel.

### Why it matters
You're going to spend the rest of the session pointing Copilot at a real file and watching it propose changes. Your screen layout matters.

### Step 1 — Clone this repository

In VS Code:

1. Press `Ctrl+Shift+P` (Windows/Linux) / `⌘+Shift+P` (macOS) to open the **Command Palette**.
2. Type `Git: Clone` and pick it.
3. Paste this URL: `https://github.com/stephschofield/isd-vscode-training.git`
4. Pick a folder on your laptop to clone into (Documents is fine).
5. When VS Code asks "Open the cloned repository?", click **Open**.

> **No git, no terminal, no problem.** This is the only "git" thing you'll do today. Everything else is point-and-click.

### Step 2 — Open the right files side by side

You want three things visible:

1. **This walkthrough** (`lab/01-cleanup.md`) in **preview** on the right.
2. **The messy data** (`data/raw_submissions.csv`) in the editor on the left.
3. **Copilot Chat** open in a panel.

Click `data/raw_submissions.csv` in the **Explorer** (left sidebar). VS Code will open it as a table — that's the built-in CSV preview. Drag this walkthrough's tab to the right side of the screen if it isn't already there.

### Step 3 — Open Copilot Chat

Press `Ctrl+Alt+I` (Windows/Linux) / `⌘+Alt+I` (macOS).

A chat panel opens. Make sure the mode dropdown at the top of the chat says **Agent** (not Ask). Agent mode is what lets Copilot actually edit files when you ask it to. If you only see Ask mode, that's fine for now — the facilitator will switch you over when needed.

### What to look for
- Three things visible at once: walkthrough, data, chat.
- The CSV looks like a table, not a wall of commas.
- Copilot Chat has a blinking cursor in its input box.

### ✅ Win
You're set up. The hard part is over.

---

## Part 1 — Get oriented

**Time:** ~8 minutes

### What you're doing
Asking Copilot to look at the data file and tell you, in plain English, what's in it and what looks wrong.

### Why it matters
This is the strategist move. Before you change anything, you ask your "+1" what they see. You decide what to do next based on the answer.

### Try this prompt

In Copilot Chat, type `#` then `data/raw_submissions.csv` to attach the file. Then paste:

```text
Look at the attached CSV. In plain English, tell me:
1. How many rows and columns it has
2. What each column seems to mean
3. The top 3 things that look messy or inconsistent
4. Any rows that look suspicious (duplicates, missing data, dates outside 2026)

Don't change the file. Just describe what you see.
```

### What to look for
- Copilot should call out **topic_tag** chaos (e.g., `AI`, `A.I.`, `Artificial Intelligence` all coexist).
- It should mention **mixed date formats** in `submission_date`.
- It should flag at least one duplicate or out-of-window submission.
- The numbers should be roughly: ~177 rows, 12 columns.

If Copilot's summary feels generic or hand-wavy, push back. Try:

```text
Be more specific. Give me three concrete examples from the actual rows.
```

### Make it your own (optional stretch)
Ask Copilot which column you should clean up first, and why. There's no single right answer — see if its reasoning matches your gut.

### ✅ Win
You have a list of problems, in your own words, before you've changed a single character.

---

## Part 2 — Normalize the easy stuff

**Time:** ~13 minutes

### What you're doing
Tackling three forms of mess that have one obvious right answer: **topic tags**, **date formats**, and **trailing whitespace in names**.

### Why it matters
This is where you learn the loop:

> **prompt → review the proposed change → accept or refine → see it land**

Don't just paste a prompt and accept the output. **Look at the diff first.** Every time.

### Step 1 — Normalize topic tags

The `topic_tag` column has lots of surface forms (`AI`, `A.I.`, `Artificial Intelligence`, `Gen AI`, …) that all mean the same thing. Pick **6 canonical topics**: `AI`, `Cloud`, `Data`, `Security`, `DevOps`, `Leadership`.

Try this prompt:

```text
In the file data/raw_submissions.csv, normalize the topic_tag column so that every value maps to exactly one of these 6 canonical topics:
AI, Cloud, Data, Security, DevOps, Leadership.

Before changing anything:
1. List every distinct topic_tag value you see right now.
2. Show me which canonical topic you'd map each one to.
3. Flag anything you're not sure about.

Wait for me to confirm before editing the file.
```

Copilot will respond with a mapping table. **Read it.** If you spot a wrong mapping (e.g., it mapped `Mgmt` to `Leadership` and you disagree), say so. When the mapping looks right, reply:

```text
Looks good. Apply the changes.
```

When Copilot edits the file, VS Code shows you a **diff view** — old text on the left, new text on the right. Skim it. Click **Keep** if it looks right, **Discard** if not.

> 🟢 **Watch for:** the **Source Control** icon in the left sidebar (looks like a branch). It now shows a number — that's your changes. Click it to see everything you've touched.

### Step 2 — Normalize dates

```text
In data/raw_submissions.csv, normalize the submission_date column so every value uses ISO format (YYYY-MM-DD).

Before changing anything, show me 3 examples of what you'd convert and how. Then wait for me to say go.
```

Same drill: review, then approve.

### Step 3 — Tidy speaker_name

```text
In data/raw_submissions.csv, the speaker_name column has trailing whitespace, inconsistent capitalization, and "Dr." vs "Dr" prefix variants.

Standardize: trim whitespace, use proper "First Last" capitalization, and use "Dr. " (with period and space) for titles.

Show me 5 example changes before applying.
```

### What to look for
- After all three: your `topic_tag` column has only 6 distinct values, your `submission_date` column is all `YYYY-MM-DD`, and `speaker_name` looks consistent.
- The Source Control panel shows ~150+ line changes. That's expected.

### Make it your own (optional stretch)
Ask Copilot to do the same kind of normalization on the `track_preference` column (canonical values: `Technical Deep Dive`, `Strategy`, `Workshop`).

### ✅ Win
Three columns are clean. The pattern is: ask, review, approve.

---

## Part 3 — Find and resolve duplicates

**Time:** ~12 minutes

### What you're doing
Hunting down two flavors of duplicate: **speakers who submitted under two different emails**, and **the same talk submitted twice**.

### Why it matters
Duplicates corrupt every downstream decision (program balance, speaker invitations, headcount). They're also the kind of thing humans miss in a 200-row CSV unless you go looking.

### Step 1 — Speakers with two emails

```text
In data/raw_submissions.csv, find every case where the same speaker_name appears under two or more different speaker_email values.

For each one:
1. List the speaker name and the email variants.
2. Suggest which email to keep as canonical (and why).
3. Don't change anything yet — just show me the list.
```

Copilot should find ~6 speakers. Look at its proposal. Real call: usually you'd keep the email that appears most often, or the simpler one (no `.work` or `.consulting` suffix).

When you're happy with the picks:

```text
OK, apply those choices. Update every row for those speakers to use the canonical email, and remove rows that become exact duplicates after the email change.
```

### Step 2 — Duplicate talk submissions

```text
In data/raw_submissions.csv, find every case where the same speaker_name has the same talk_title submitted more than once (different submission_id).

For each duplicate set, suggest which row to keep — usually the most complete one (fewest blank fields). Show me the list before deleting anything.
```

Review. Approve.

### What to look for
- Row count should drop by ~10–15 rows.
- The Source Control panel now shows deleted lines (red) as well as edits.
- Every speaker_name should now match exactly one speaker_email.

### Make it your own (optional stretch)
Ask Copilot to spot speakers from the same company who might be the same person under a name variation (e.g., "Bob Smith" vs "Robert Smith"). It might find some — your call whether to merge.

### ✅ Win
The data is now smaller and more honest. No phantom speakers.

---

## Part 4 — Resolve conflicts and gaps

**Time:** ~12 minutes

### What you're doing
Three remaining pockets of mess: **conflicting session lengths**, **missing required fields**, and **out-of-window dates**.

### Why it matters
Easy mess (Part 2) and exact duplicates (Part 3) have obvious right answers. This part doesn't. You're going to have to make calls. The "+1" model means *Copilot proposes, you decide*.

### Step 1 — Conflicting session lengths

Some talks have multiple submissions with different `session_length_min` values (`30`, `45`, `60`). Pick a rule: **the most recent submission_date wins.**

```text
In data/raw_submissions.csv, find every talk_title that has more than one distinct session_length_min value across rows.

For each one, recommend which length to keep — use the most recent submission_date as the tiebreaker. Show me the list before changing anything.

Also: convert any non-numeric length values (like "30 min", "thirty", "1 hour") into pure numbers (30, 45, 60). All values should end up as 30, 45, or 60.
```

### Step 2 — Missing fields

```text
In data/raw_submissions.csv, find every row with a blank track_preference or experience_level.

For each one:
1. Show me the row.
2. Suggest a fill value based on the talk_title and bio_short — your best guess.
3. Mark anything you're truly not sure about as "Unknown" rather than guessing.

Show me the proposals before applying.
```

For the "Unknown" cases: short discussion with the room — do you keep them as `Unknown`, or do you delete those rows? **Sensible default: keep them and flag in a Slack note** so the program team can follow up with the speaker.

### Step 3 — Out-of-window dates

A few submissions have dates from 2025 — they snuck in early. Don't delete them silently.

```text
In data/raw_submissions.csv, find every row with a submission_date outside the year 2026.

Don't delete them. Instead, show me the list so I can decide row by row.
```

For each: in the room, decide. Usually you'd flag for the program team rather than auto-drop.

### Step 4 — Standardize requires_av

```text
In data/raw_submissions.csv, the requires_av column has values like Yes, No, TRUE, FALSE, 1, 0, Y, N, and blanks. Standardize every value to "Yes" or "No". Treat blanks as "No" (default to no AV).
```

### What to look for
- The Source Control panel shows steady, deliberate changes — not a giant blob.
- You feel like you're *making decisions*, not running a script.

### Make it your own (optional stretch)
Ask Copilot to write a one-paragraph "change log" describing what you did to the file. Paste it into a notes file. This is a real artifact you'd send to your team after a real cleanup.

### ✅ Win
The cleanup is essentially done. Time to sanity check.

---

## Part 5 — Sanity check + save

**Time:** ~7 minutes

### What you're doing
Comparing your cleaned file to the canonical "good answer" we shipped with this repo, and learning what *good* looks like — without expecting an exact match.

### Why it matters
The point isn't "did you produce the same file as the answer key." The point is: *is your data internally consistent?* Lab 2 will start from the canonical file no matter what — your job is to leave Lab 1 with confidence in the cleanup loop.

### Open the canonical file

In the Explorer, click `solutions/clean_submissions.csv`. Open it side-by-side with your `data/raw_submissions.csv` (which is now your *cleaned* version).

### Check four things

1. **Row count.** Yours should be within ~5% of the canonical's row count.
2. **Column names and order.** Identical to the canonical.
3. **Standardized formats.** All dates ISO. All topics in the canonical 6. All `requires_av` is `Yes` or `No`.
4. **No obvious duplicates.** No two rows share a `speaker_name` + `talk_title` pair.

### Try this prompt

```text
Compare data/raw_submissions.csv (which I just cleaned) against solutions/clean_submissions.csv (the reference answer).

Tell me:
1. How many rows each file has.
2. Any column where the value sets differ (e.g., my topic_tag values vs the reference's).
3. Speakers in one file that aren't in the other.
4. Anything that suggests I missed a cleanup step.

Be honest. Don't soften the answer.
```

Read Copilot's report. If it surfaces something real you missed, go fix it. If it's nitpicking ("your row order is different"), shrug it off — order doesn't matter.

### One last thing — save your work

Press `Ctrl+S` (Windows/Linux) / `⌘+S` (macOS) to save the file. That's it. Nothing to push, nothing to publish. You walk away with this folder on your laptop.

### Make it your own (optional stretch)
Ask Copilot to suggest 3 follow-up questions a program manager should ask about the cleaned dataset — questions about balance, gaps, or risks the data might be hiding. The exact prompt is in the **stretch** section of [`../prompts/01-prompts.md`](../prompts/01-prompts.md).

### ✅ Final Win
You did real cleanup work in VS Code, with Copilot, on a real-shaped dataset. You decided what to keep, what to change, what to flag. You can describe in your own words what "AI as my +1" actually feels like.

---

## What just happened

You did six things that matter beyond this lab:

1. You worked in **VS Code** for real, not just as a viewer.
2. You used **Copilot Chat** as a junior analyst — describe, propose, refine, approve.
3. You **read diffs** before accepting changes. (Most people don't. You will from now on.)
4. You **made judgment calls** Copilot couldn't make — what to merge, what to flag, what to keep.
5. You **left a clean artifact** that someone else could pick up and use.
6. You learned the **loop** that scales to any text-shaped work: prompt → review → refine → commit.

See you in Lab 2. Same scenario, harder problem.
