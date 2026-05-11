# Lab 2 — Reusable Prompt Library

> Copy-paste prompts for the Lab 2 walkthrough. Same shape as Lab 1's
> prompt library so attendees know exactly where to find things.
>
> **Tip:** Run the whole lab in **Agent mode**. In Agent mode Copilot
> has workspace-wide visibility — reference files or folders by name
> (e.g., "the transcripts in `inputs/`") and Copilot will read them.
> No need to attach anything one by one. Synthesis without sources is
> hallucination, so always point Copilot at the inputs before asking
> for themes.

---

## Get oriented — summarize each input

Use after Part 0, before Part 2. Agent mode will read the files
straight from the workspace.

```
Read every file under `inputs/transcripts/` and `inputs/notes/`. For
each transcript and each notes file, give me a 4-bullet summary in
this exact shape:

- Who is speaking and what role they're playing
- The 2–3 things they explicitly want from the Summit
- The 1–2 things they implicitly want (read between the lines — what
  would success look like *for them personally*?)
- One thing they're worried about or pushing back against

Use direct quotes where you can. Don't infer; cite.
```

### Follow-up — push back on a flat summary

```
Make Jane / Marcus / Priya sound more like themselves. Right now they
all read the same in your summary. What's distinctive about how each
one talks about the Summit?
```

---

## Extract themes — ungrounded (the "bad" version, for contrast)

Run this in a *new chat with no workspace context referenced* during
Part 2. The output is the demo of how *not* to do it.

```
What are some good themes for a 2026 corporate innovation summit?
```

---

## Extract themes — grounded

Run in a fresh chat. Agent mode will pull the inputs from the
workspace — just point it at the folders and CSV.

```
Read every file under `inputs/transcripts/`, `inputs/notes/`,
`inputs/whiteboard/`, and the file
`from-previous-session/clean_submissions.csv`. Using only what's in
those files, identify 5–8 themes for the Meridian Innovation Summit.
For each theme, give me:

1. A short, specific name (5 words or fewer — no "AI", no "Cloud",
   something that means something)
2. Why it matters, in one sentence, grounded in a stakeholder need
3. 1–2 direct quotes from the transcripts or notes that support it
4. The number of speaker submissions in `clean_submissions.csv` that
   fit this theme (count them; don't guess)
5. Which stakeholder(s) most want this theme

Format as Markdown headings (`## Theme N: ...`). If a candidate theme
doesn't have at least one supporting quote *and* at least one
supporting submission, leave it out — but tell me what you cut and
why.
```

### Follow-up — challenge a single theme

```
Convince me [Theme N] isn't real. Use only the evidence in the
workspace inputs. If the evidence holds up, say so and explain why.
If it doesn't, tell me what's missing.
```

---

## Map themes to sessions

Stay in **Agent mode** (you've been in it since Part 0) so Copilot can
write the CSV. Same context as the themes prompt above.

```
Using the themes we just produced and `clean_submissions.csv`, create
`solutions/theme-session-map.csv` with these columns:

submission_id, talk_title, assigned_theme, confidence, notes

- `assigned_theme` is one of our theme names, or `unassigned` if none
  fit.
- `confidence` is `high` / `medium` / `low`. Default to `medium` if
  you're unsure; reserve `high` for cases where the talk title or
  topic tag is unmistakable.
- `notes` is short — one phrase. Use it to flag low-confidence
  matches, orphan talks worth keeping anyway, or talks that *almost*
  fit a theme but don't quite.

Be honest about `unassigned`. If a talk doesn't fit, say so. Do not
force-fit.
```

### Follow-up — surface gaps and orphans

```
Now group `solutions/theme-session-map.csv` by `assigned_theme` and tell
me:

- Which themes have fewer than 6 sessions (too thin for a track)?
- Which themes have more than 30 sessions (need internal subdivision)?
- Are there any clusters of `unassigned` rows that suggest a theme we
  missed?
```

---

## Pressure-test the themes

Run after Part 3, before Part 4 closes. Same context.

```
Argue against these themes. Take the position of someone who hates
the current shape and would rather we picked a completely different
framing. Specifically:

1. Name the theme that is weakest. What's the strongest case for
   cutting it?
2. What's a plausible alternative framing for the Summit that none
   of these themes captures?
3. Which themes are politically convenient (a stakeholder wants
   them) but evidentially weak (the data doesn't support them)?
4. Which themes are evidentially strong but politically contested?
   Who would push back, and what's their best argument?

Be specific. No hedging. If you can't find a real counter-argument,
tell me — but I expect you can.
```

### Rescue prompt — when Copilot caves to sycophancy

```
Take the role of a senior exec who hates this idea and was overruled
when the program team picked it. Argue against it for 200 words. Be
specific. No hedging. No "however." If you can't argue against it
credibly, say so — but I expect you can.
```

---

## Draft the options memo

Run in Part 5. Themes and map should still be in the chat context.

```
Using the refined themes and the theme-session map, draft
`solutions/options-memo.md` as a one-page strategic options memo,
roughly 400 words. Use this exact shape:

# Innovation Summit — Program Directions

## Context (3 sentences)

## Option A: [Name]
**Shape:** [Number of tracks, sessions, balance across themes]
**Why:** [Strategic logic in 1–2 sentences]
**Tradeoff:** [What we give up if we pick this]

## Option B: [Name]

## Option C: [Name]

## Recommendation (1 paragraph)

Each option should make a real tradeoff against the others — they
shouldn't all be safe. One option should lean into what the
stakeholders converge on. One should lean into the contested theme.
One should be deliberately narrower than feels comfortable.

End with a recommendation. Do not hedge. If you don't recommend, the
memo has failed.
```

### Follow-up — make the case for the option you didn't pick

```
You recommended Option [X]. Now make the strongest case you can for
Option [Y]. If, after writing it, you've changed your recommendation,
say so and tell me what changed your mind.
```

---

## Pressure-test the options

Run in Part 6.

```
For each of the three options in `solutions/options-memo.md`, write the
strongest case against it that a skeptical exec would make. Be
specific and a little hostile — the way a CFO might be when they
think the program team has under-thought the budget implications.
Then, for each counter-argument, write the counter to the counter.
If you can't write a credible counter to the counter, the option is
in trouble — flag it.
```

---

## Stretch — competitor critique

Optional. Run only if Part 6 finishes early.

```
You're a program director at one of our peer companies. You've been
shown our draft options memo by a recruiter who's trying to poach our
people. Critique our program shape from the perspective of someone
who'd be embarrassed to ship something this safe. What would you do
differently?
```

---

## Prompt-writing principles for synthesis work

These are different from Lab 1's principles (which were about scoping
and reviewing AI-suggested edits). Synthesis work has its own
discipline:

- **Always point Copilot at the source files.** In Agent mode, name
  the folder or file in the prompt (e.g., "read every file under
  `inputs/transcripts/`"). Synthesis without sources is hallucination
  — if you don't reference the inputs, the model will invent themes
  that sound plausible and aren't supported by anything.
- **Ask for evidence per claim — quotes, file names, row counts.**
  "Why" without citation is decoration.
- **When the answer feels too good, ask Copilot to argue against
  itself.** Default model behavior is helpfulness. Adversarial review
  has to be invited explicitly.
- **"Pretend you're [persona] who hates this" beats "what could go
  wrong?" every time.** Roles produce specificity; abstract questions
  produce hedging.
- **Cap output length on purpose.** A 400-word memo forces real
  tradeoffs. An 800-word memo lets you hedge.
- **Always ask for the cut list.** *"What did you consider and
  reject, and why?"* — surfaces hidden disagreement and tells you
  where the model thought twice.
