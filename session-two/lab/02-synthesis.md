# Lab 2 — Find the Signal: Theme Synthesis & Strategic Pressure-Testing

> **Time:** 60 minutes &nbsp;|&nbsp; **Tool:** GitHub Copilot Chat in
> VS Code &nbsp;|&nbsp; **Output:** `solutions/themes.md`,
> `solutions/theme-session-map.csv`, and `solutions/options-memo.md`

In Lab 1, you used Copilot for the work humans hate doing — cleanup,
dedup, normalization. Today is different. Today you'll use Copilot for
the work humans usually claim only humans can do: pulling themes out of
qualitative input, deciding which sessions belong to which theme, and
arguing with yourself out loud until your conclusions hold up.

The hardest skill in this lab is not "writing a good prompt." It's
**refusing to accept Copilot's first answer**. We're going to practice
that on purpose.

---

## Part 0 — Set up your workspace (3 min)

**What you're doing:** Get the repo open, the inputs in front of you,
and Copilot Chat in Agent mode so it can read the workspace and write
files.

**Why:** Today's work is grounded synthesis. The Summit themes have to
come from what stakeholders actually said, not from Copilot's training
data. In Agent mode, Copilot has workspace-wide visibility — it can
pull in files by name or by folder when you reference them. The setup
matters because if Copilot can't see the inputs, it will invent themes
that sound plausible and aren't supported by anything.

**Try this:**

1. **Open `session-two/` as your workspace folder.** You should be in **VS Code Desktop** (the Codespace launch handed off to the desktop app). Codespaces opens the whole repo by default — use **File → Open Folder…** and pick `session-two/`. Every path in this walkthrough is relative to that folder, so the Explorer should show `data/`, `from-previous-session/`, `inputs/`, `lab/`, `prompts/`, and `solutions/` at its root. (Want to run fully locally instead, with no Codespace? Clone `https://github.com/stephschofield/isd-vscode-training.git` and open the `session-two/` folder in VS Code Desktop.)
2. Skim the inputs so you know what's in the room:
   - [`from-previous-session/clean_submissions.csv`](../from-previous-session/clean_submissions.csv)
   - [`inputs/transcripts/exec-sponsor-jane.md`](../inputs/transcripts/exec-sponsor-jane.md)
   - [`inputs/transcripts/program-lead-marcus.md`](../inputs/transcripts/program-lead-marcus.md)
   - [`inputs/transcripts/eng-director-priya.md`](../inputs/transcripts/eng-director-priya.md)
   - [`inputs/notes/kickoff-meeting-notes.md`](../inputs/notes/kickoff-meeting-notes.md)
   - [`inputs/notes/sponsor-1on1-notes.md`](../inputs/notes/sponsor-1on1-notes.md)
   - [`inputs/whiteboard/strategy-offsite-whiteboard.md`](../inputs/whiteboard/strategy-offsite-whiteboard.md)
3. Open Copilot Chat. **macOS:** `⌃⌘I`. **Windows / Linux:**
   `Ctrl+Alt+I`. Set the chat mode to **Agent** and leave it there for
   the whole lab. Agent mode gives Copilot workspace-wide visibility
   (it can read any file in `session-two/` you reference by name or
   folder) and lets it write outputs back to disk when we get to Part
   3. You don't need to attach files one by one — referencing them in
   the prompt (e.g., "the transcripts in `inputs/`") is enough.

**What to look for:** You should see the files in your sidebar and
Copilot Chat open in a side panel with the mode dropdown showing
**Agent**.

**Make it your own:** Skim the inputs folder for two minutes. Don't
read carefully — just get a sense of who said what.

---

## Part 1 — Get oriented: what did stakeholders actually say? (8 min)

**What you're doing:** Ask Copilot to summarize each transcript and
surface the *implicit* asks — the things stakeholders didn't say
directly but clearly want.

**Why:** Before you can synthesize themes, you need to know what's in
the room. The risk if you skip this: you bring your own assumptions
into the next step and call them "themes."

**Try this prompt** (Agent mode will pull the files in from the
workspace — just point it at the folders):

> Read every file under `inputs/transcripts/` and `inputs/notes/`. For
> each transcript and each notes file, give me a 4-bullet summary in
> this exact shape:
>
> - Who is speaking and what role they're playing
> - The 2–3 things they explicitly want from the Summit
> - The 1–2 things they implicitly want (read between the lines — what
>   would success look like *for them personally*?)
> - One thing they're worried about or pushing back against
>
> Use direct quotes where you can. Don't infer; cite.

**What to look for:**

- Different stakeholders should sound *different*. If Jane and Marcus
  read the same in Copilot's summary, push back: "make it more obvious
  what's distinctive about each speaker's voice."
- Each summary should include at least one direct quote. If Copilot
  paraphrases everything, ask for quotes specifically.
- The "implicit" bullet is the interesting one. If it reads obvious or
  generic, ask: "what would [Jane / Marcus / Priya] consider a personal
  win from this Summit that they wouldn't say out loud?"

**Make it your own:** Pick one stakeholder. Argue back at Copilot's
summary of them: "I think you missed [X]." See how the model responds.
Notice whether it folds immediately ("you're right!") or pushes back
with evidence. Both are useful signals.

---

## Part 2 — Extract themes — *grounded*, not invented (12 min)

**What you're doing:** Generate a draft list of 5–8 program themes for
the Summit, with evidence quotes and submission counts attached.

**Why:** This is the moment most people fumble. They ask "what are the
themes?" and accept whatever Copilot says. We're going to do it twice —
once badly, once well — so the contrast is undeniable.

**First, the bad version. Try this in a new chat (no workspace
context — type the prompt cold, with no folder or file references):**

> What are some good themes for a 2026 corporate innovation summit?

Read what comes back. You'll get something like *AI, Cloud,
Sustainability, Future of Work, Digital Transformation*. Generic mush.
This is what happens when you ask Copilot to think without inputs.

**Now the good version. Open a fresh chat and try this:**

> Read every file under `inputs/transcripts/`, `inputs/notes/`,
> `inputs/whiteboard/`, and the file
> `from-previous-session/clean_submissions.csv`. Using only what's in
> those files, identify 5–8 themes for the Meridian Innovation Summit.
> For each theme, give me:
>
> 1. A short, specific name (5 words or fewer — no "AI", no "Cloud",
>    something that means something)
> 2. Why it matters, in one sentence, grounded in a stakeholder need
> 3. 1–2 direct quotes from the transcripts or notes that support it
> 4. The number of speaker submissions in `clean_submissions.csv`
>    that fit this theme (count them; don't guess)
> 5. Which stakeholder(s) most want this theme
>
> Format as Markdown headings (`## Theme N: ...`). If a candidate theme
> doesn't have at least one supporting quote *and* at least one
> supporting submission, leave it out — but tell me what you cut and
> why.

**What to look for:**

- Theme *names* should be specific. "AI in workflows" is okay; "AI" is
  not. "Real customer stories from inside the company" is great;
  "Customer Stories" is generic.
- Each theme should have a real quote. If Copilot paraphrases, ask for
  the verbatim line and the source file.
- Submission counts should be plausible (the dataset has 192 rows).
  If a theme claims "120 submissions support this," you're being lied
  to — push back.
- The "what I cut and why" list is gold. That's where you find out
  what Copilot considered and rejected.

**Make it your own:** Pick the theme you find most surprising. Ask
Copilot: "convince me this theme isn't real." See if its own evidence
holds up under attack.

---

## Part 3 — Map themes to sessions (10 min)

**What you're doing:** For every speaker submission, decide which
theme it belongs to (or flag it as `unassigned`). Output is a CSV.

**Why:** Themes without sessions behind them are stakeholder wishful
thinking. Sessions without themes are orphans we may need to cut. The
map makes both visible.

You should already be in Agent mode from Part 0 — confirm the mode
dropdown still says **Agent** so Copilot can write the CSV. Then try:

> Using the themes we just produced and `clean_submissions.csv`, create
> `solutions/theme-session-map.csv` with these columns:
>
> `submission_id, talk_title, assigned_theme, confidence, notes`
>
> - `assigned_theme` is one of our theme names, or `unassigned` if none
>   fit.
> - `confidence` is `high` / `medium` / `low`. Default to `medium` if
>   you're unsure; reserve `high` for cases where the talk title or
>   topic tag is unmistakable.
> - `notes` is short — one phrase. Use it to flag low-confidence
>   matches, orphan talks worth keeping anyway, or talks that *almost*
>   fit a theme but don't quite.
>
> Be honest about `unassigned`. If a talk doesn't fit, say so. Do not
> force-fit.

**What to look for:**

- Open `solutions/theme-session-map.csv` in VS Code's CSV preview (right-
  click → Open With → CSV Preview, or use the editor's default
  rendering).
- Sort by `assigned_theme`. Does each theme have *enough* sessions to
  fill a track? (Rule of thumb: 6+ to be a real direction.)
- Look at the `unassigned` rows. Are there 5+ in any single topic that
  Copilot didn't surface as a theme? That might be a theme you missed.
- Watch out for themes that look strong on quotes but weak on
  submissions. Those are the ones to interrogate in Part 4.

**Make it your own:** Find the most surprising `unassigned` talk and
ask: "what would it take to include this? Should we add a theme for
it, or cut it?"

---

## Part 4 — Pressure-test your themes (10 min)

**What you're doing:** Ask Copilot to argue *against* the themes you
just produced. Then refine.

**Why:** This is the whole point of the lab. AI defaults to agreeing
with you. Left unprompted, it will tell you your themes are
"compelling" and "well-supported" even when they aren't. You have to
*explicitly* invite the disagreement, or you won't get it.

**Try this prompt** (same chat, themes and the map should still be in
context):

> Argue against these themes. Take the position of someone who hates
> the current shape and would rather we picked a completely different
> framing. Specifically:
>
> 1. Name the theme that is weakest. What's the strongest case for
>    cutting it?
> 2. What's a plausible *alternative* framing for the Summit that none
>    of these themes captures?
> 3. Which themes are *politically* convenient (a stakeholder wants
>    them) but *evidentially* weak (the data doesn't support them)?
> 4. Which themes are evidentially strong but *politically* contested?
>    Who would push back, and what's their best argument?
>
> Be specific. No hedging. If you can't find a real counter-argument,
> tell me — but I expect you can.

**What to look for:**

- A real counter-argument changes your mind about something. If
  Copilot's "argument against" reads as cosmetic ("you could maybe say
  it slightly differently"), the prompt didn't bite. Try the rescue:
  *"Take the role of an exec who hates this idea. Argue against it for
  200 words."*
- The *politically convenient / evidentially weak* answer is the most
  valuable. That's a theme you may need to cut or reframe.
- The *evidentially strong / politically contested* answer is the one
  to defend in your options memo with extra rigor.

**Now refine.** Edit your themes file (or ask Copilot to update it
based on the pressure-test). At least one theme should change in name,
framing, or evidence. If nothing changes, you didn't push hard enough.

**Make it your own:** Pick the counter-argument that stung the most.
Write it down — it's going to show up as the "Strongest counter-
argument" line in `solutions/themes.md`.

---

## Part 5 — Draft 2–3 program directions (options memo) (10 min)

**What you're doing:** Turn the themes into 2–3 *programs* — actual
shapes you could pitch to leadership tomorrow. One page total.

**Why:** Themes are not decisions. Leadership doesn't pick themes;
they pick programs. The options memo is the bridge.

**Try this prompt:**

> Using the refined themes and the theme-session map, draft
> `solutions/options-memo.md` as a one-page strategic options memo,
> roughly 400 words. Use this exact shape:
>
> ```markdown
> # Innovation Summit — Program Directions
>
> ## Context (3 sentences)
>
> ## Option A: [Name]
> **Shape:** [Number of tracks, sessions, balance across themes]
> **Why:** [Strategic logic in 1–2 sentences]
> **Tradeoff:** [What we give up if we pick this]
>
> ## Option B: [Name]
>
> ## Option C: [Name]
>
> ## Recommendation (1 paragraph)
> ```
>
> Each option should make a *real* tradeoff against the others — they
> shouldn't all be safe. One option should lean into what the
> stakeholders converge on. One should lean into the contested
> theme. One should be deliberately narrower than feels comfortable.
>
> End with a recommendation. Do not hedge. If you don't recommend, the
> memo has failed.

**What to look for:**

- Each option should have a *real* tradeoff. "Option C is more
  ambitious" isn't a tradeoff. "Option C cuts cloud spending coverage
  to make room for two extra DX sessions" is.
- The recommendation paragraph should pick one option and say why. If
  Copilot writes "any of these would work," ask it to pick.
- Word count: aim for 400 words. If it's 800, ask for it tighter. If
  it's 200, ask for more substance on tradeoffs.

**Make it your own:** Argue with the recommendation. Whichever option
Copilot picks, ask: *"make the case for the option you didn't pick."*
You may be more convinced by the second pitch than the first.

---

## Part 6 — Pressure-test your options + finalize (7 min)

**What you're doing:** One more adversarial pass. Then commit.

**Why:** The options memo is what you'd hand to leadership. If a
skeptical exec could pull it apart in 30 seconds, leadership will too.
Better to find the holes here.

**Try this prompt:**

> For each of the three options in `solutions/options-memo.md`, write the
> strongest case *against* it that a skeptical exec would make. Be
> specific and a little hostile — the way a CFO might be when they
> think the program team has under-thought the budget implications.
> Then, for each counter-argument, write the counter to the counter.
> If you can't write a credible counter to the counter, the option is
> in trouble — flag it.

**What to look for:**

- Hostile-exec voice is the magic. *"This sounds like AI for AI's
  sake — what's the actual ROI?"* is useful. *"This option has some
  trade-offs to consider"* is not.
- If any option's counter has no credible response, *change the
  option* — don't paper over it.
- Update `solutions/themes.md` to add a `Strongest counter-argument`
  line under each theme based on what you learned. (At least 2 themes
  should have a non-empty counter-argument by the end.)

**Finalize:**

1. Save `solutions/themes.md`, `solutions/theme-session-map.csv`, and
   `solutions/options-memo.md`.
2. Compare your outputs to the canonical files in `solutions/` (which
   were committed before this session). Where do you agree? Where do
   you differ? *Different is allowed.* The canonical answer isn't the
   only good answer; it's *an* answer that survived its own pressure-
   test.
3. Read `solutions/options-memo.md` aloud. Does it make a recommendation
   you'd actually defend in a leadership meeting? If yes, you're done.

---

## You're done. What just happened?

You used Copilot to do three things that, until very recently, were
unambiguously human work:

1. **Synthesized themes from messy qualitative input** — and you did it
   *grounded*, with evidence, instead of generating plausible-sounding
   mush.
2. **Mapped themes back to data** to test whether your synthesis held
   up against the actual submissions.
3. **Pressure-tested your conclusions** by deliberately asking the
   model to disagree with you — twice.

The third skill is the one most people don't practice. AI tools default
to helpfulness, which feels great and produces weak thinking. Today
you practiced the muscle of asking for the disagreement on purpose.

Take that home with you. Next time someone shows you "what Copilot
said," ask: *"did you ask it to argue back?"*

Lab 3 picks up from your `solutions/` folder. Don't worry about
polishing — your themes, map, and memo go to the next session as-is.
