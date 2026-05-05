# Lab 1 — Copilot Prompt Library

> Every prompt the walkthrough asks you to use is also here. If you fall
> behind during the lab, grab the right one from this page and paste it
> into Copilot Chat. Every prompt below appears verbatim in
> [`../lab/01-cleanup.md`](../lab/01-cleanup.md) — grab it from whichever
> file is most convenient.

How to use a prompt: click the small **copy** button in the top-right of
the code block, then paste it into Copilot Chat. If the prompt mentions a
file, attach it with `#` (e.g., `#data/raw_submissions.csv`) before sending.

---

## Get oriented

### "Tell me what's in this file"

> Use this when you've just opened the CSV and want a plain-English
> summary before changing anything. Attach `data/raw_submissions.csv`
> with `#` first.

```text
Look at the attached CSV. In plain English, tell me:
1. How many rows and columns it has
2. What each column seems to mean
3. The top 3 things that look messy or inconsistent
4. Any rows that look suspicious (duplicates, missing data, dates outside 2026)

Don't change the file. Just describe what you see.
```

### "Be more specific"

> Use this when Copilot's first answer feels generic and you want concrete
> examples from the actual rows.

```text
Be more specific. Give me three concrete examples from the actual rows.
```

---

## Normalize the easy stuff

### "Normalize topic_tag"

> Use this in Part 2. Maps every messy topic value to one of the 6
> canonical topics. Note the "wait for me to confirm" — that's the loop.

```text
In the file data/raw_submissions.csv, normalize the topic_tag column so that every value maps to exactly one of these 6 canonical topics:
AI, Cloud, Data, Security, DevOps, Leadership.

Before changing anything:
1. List every distinct topic_tag value you see right now.
2. Show me which canonical topic you'd map each one to.
3. Flag anything you're not sure about.

Wait for me to confirm before editing the file.
```

### "Looks good, apply the changes"

> Use this after Copilot proposes a mapping or change you've reviewed and
> agree with.

```text
Looks good. Apply the changes.
```

### "Normalize submission_date to ISO"

> Use this to convert all date formats to YYYY-MM-DD.

```text
In data/raw_submissions.csv, normalize the submission_date column so every value uses ISO format (YYYY-MM-DD).

Before changing anything, show me 3 examples of what you'd convert and how. Then wait for me to say go.
```

### "Tidy speaker_name"

> Use this to fix whitespace, casing, and "Dr." prefix variants.

```text
In data/raw_submissions.csv, the speaker_name column has trailing whitespace, inconsistent capitalization, and "Dr." vs "Dr" prefix variants.

Standardize: trim whitespace, use proper "First Last" capitalization, and use "Dr. " (with period and space) for titles.

Show me 5 example changes before applying.
```

---

## Find and resolve duplicates

### "Find speakers with two emails"

> Use this in Part 3 to catch people who submitted under multiple emails.

```text
In data/raw_submissions.csv, find every case where the same speaker_name appears under two or more different speaker_email values.

For each one:
1. List the speaker name and the email variants.
2. Suggest which email to keep as canonical (and why).
3. Don't change anything yet — just show me the list.
```

### "Apply the canonical email choices"

> Use this **after** you've reviewed Copilot's email picks and agree.
> Run as the first of two prompts — never bundle the email rewrite and
> the dedup pass into one. Autonomous deletion needs a review gate.

```text
OK, apply those choices. Update every row for those speakers to use the canonical email. Show me the changes first; don't apply yet.
```

### "Remove the rows that became exact duplicates after the email change"

> Use this **after** the email rewrite is reviewed and applied. This is
> the second half of the lab Part 3 Step 1 workflow — the review gate
> between rewrite and delete is load-bearing.

```text
Now remove rows that became exact duplicates after the email change. "Exact duplicate" means all 12 columns are identical, case-sensitive. Show me which rows you'd delete before removing them.
```

### "Find duplicate talk submissions"

> Use this to catch the same talk submitted twice by the same speaker.

```text
In data/raw_submissions.csv, find every case where the same speaker_name has the same talk_title submitted more than once (different submission_id).

For each duplicate set, suggest which row to keep — usually the most complete one (fewest blank fields). Show me the list before deleting anything.
```

---

## Resolve conflicts and gaps

### "Reconcile conflicting session lengths"

> Use this in Part 4 to pick one session length per talk and convert
> non-numeric values to numbers. Scope is the same speaker submitting
> the same talk twice with different lengths — different speakers who
> happened to propose the same talk title are independent submissions.

```text
In data/raw_submissions.csv, find every case where the SAME speaker_name has more than one distinct session_length_min for the SAME talk_title across rows.

For each one, recommend which length to keep — use the most recent submission_date as the tiebreaker. Show me the list before changing anything.

If a talk_title appears under different speakers with different session_length_min values, that's a valid distinct submission — leave those alone.

Also: convert any non-numeric length values (like "30 min", "thirty", "1 hour") into pure numbers (30, 45, 60). All values should end up as 30, 45, or 60.
```

### "Fill missing track_preference and experience_level"

> Use this for missing required fields. Note the explicit "Unknown"
> escape hatch — better than guessing.

```text
In data/raw_submissions.csv, find every row with a blank track_preference or experience_level.

For each one:
1. Show me the row.
2. Suggest a fill value based on the talk_title and bio_short — your best guess.
3. Mark anything you're truly not sure about as "Unknown" rather than guessing.

Show me the proposals before applying.
```

### "Flag out-of-window dates"

> Use this in Part 4. Don't let Copilot delete these silently — surface
> them so you can decide row by row.

```text
In data/raw_submissions.csv, find every row with a submission_date outside the year 2026.

Don't delete them. Instead, show me the list so I can decide row by row.
```

### "Standardize requires_av"

> Use this to collapse all the Yes/No surface forms into two values.

```text
In data/raw_submissions.csv, the requires_av column has values like Yes, No, TRUE, FALSE, 1, 0, Y, N, and blanks. Standardize every value to "Yes" or "No". Treat blanks as "No" (default to no AV).
```

---

## Validate the result

### "Compare my work to the canonical answer"

> Use this in Part 5. Honest comparison, no soft-pedalling.

```text
Compare data/raw_submissions.csv (which I just cleaned) against data/clean_submissions.csv (the reference answer).

Tell me:
1. How many rows each file has.
2. Any column where the value sets differ (e.g., my topic_tag values vs the reference's).
3. Speakers in one file that aren't in the other.
4. Anything that suggests I missed a cleanup step.

Be honest. Don't soften the answer.
```

---

## Stretch prompts (for early finishers)

### "Which column should I clean first?"

> Use this in Part 1 if you finish the orient prompt early. There's no
> single right answer — see if Copilot's reasoning matches your gut.

```text
Looking at data/raw_submissions.csv, which column would you clean first, and why? Walk me through your reasoning before recommending.
```

### "Normalize track_preference"

> Use this as a Part 2 stretch — same loop you used for topic_tag, applied
> to a different column.

```text
In data/raw_submissions.csv, normalize the track_preference column so that every value maps to exactly one of these 3 canonical tracks:
Technical Deep Dive, Strategy, Workshop.

List every distinct value you see now, show me which canonical track you'd map each one to, and wait for me to confirm before editing.
```

### "Write a change log of what we did"

> Use this as a Part 4 stretch — produces a real artifact you'd send to
> your team after a real cleanup.

```text
Write a one-paragraph change log describing what I just did to data/raw_submissions.csv — what I normalized, what I deduped, what I flagged for follow-up. Write it as if I were updating a teammate who didn't watch the cleanup happen.
```

### "Suggest follow-up questions a program manager should ask"

> Use this when you've finished early and want to think strategically
> about what comes next.

```text
Now that the dataset is clean, suggest 5 questions a program manager at the Meridian Innovation Summit should ask before this dataset is finalized — questions about balance, gaps, or risks the data might be hiding.
```

### "Write a one-paragraph cleanup summary for Slack"

> Use this to produce a real artifact you'd send your team after a real
> cleanup session.

```text
Write a one-paragraph summary of the cleanup we just did on the speaker submissions, in the voice of a program coordinator updating their team in Slack. Mention what changed, what got flagged for follow-up, and what's now ready for review.
```

### "Spot near-duplicate speakers across name variations"

> Use this if the obvious dedup didn't catch everything.

```text
In data/raw_submissions.csv, look for cases where two different speaker_name values might actually be the same person — for example, "Bob Smith" and "Robert Smith" at the same company. Don't merge them. Just give me a list to review.
```

### "Suggest a topic-balance fix"

> Use this to think about program design, not just data quality.

```text
Look at the topic_tag distribution in the cleaned data/raw_submissions.csv. Tell me which canonical topic is over-represented and which is under-represented. Suggest two ways the program team could rebalance — for example, by inviting specific kinds of talks.
```

---

## How to write good Copilot prompts

A few principles that show up in every prompt above:

1. **Be specific.** Tell Copilot the file, the column, and the rule. Vague prompts get vague answers.
2. **Ask for proposals before changes.** "Show me before changing anything" is a magic phrase. It puts you back in the driver's seat.
3. **If the result feels off, say so and explain why.** Don't just re-prompt — push back with context. *"This mapping is wrong because X"* gets you a much better second answer than *"try again."*
4. **Use the `#` attachment.** Attach the file you're talking about. Copilot answers are dramatically better when it can see the actual data, not just a description of it.
5. **Read the diff every time.** Copilot's output is a proposal, not a fact. The diff view is your last line of defense.
