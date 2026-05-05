# Lab 3 — From Strategy to Executive Story

> **Goal:** In ~88 minutes, turn the Lab 2 themes and recommendation into
> a polished, executive-ready briefing your COO could read in 5 minutes
> and act on. Copilot is your editor today, not your author.

## Before you begin

This lab is about **editing, not generating**. The default reflex with AI
is "have it write the thing for me." Today you'll do the opposite — you'll
write the first ugly draft yourself, then use Copilot Chat to tighten,
sharpen, and pressure-test it. You'll feel the difference by the end.

You are **advocating for** the recommendation in
`from-previous-session/options-memo.md` — not re-deciding among the three
options. Lab 2 made the call; today you make the case.

---

## Part 0 — Set up your workspace (5 min)

1. You already cloned this repo. In VS Code, open these files in
   side-by-side tabs:
   - `templates/exec-persona.md`
   - `templates/briefing-template.md`
   - `from-previous-session/options-memo.md`
   - `from-previous-session/themes.md`
2. Read `templates/exec-persona.md` aloud once — or just listen if a lead
   reads it to the room. It sets the voice you'll write in for the next
   ~80 minutes.
3. Open the **Copilot Chat** panel (the chat bubble icon in the left
   sidebar of VS Code).
4. Open the Markdown preview for `templates/briefing-template.md`
   side-by-side: press **Ctrl/Cmd + K**, then release, then press **V**.
   (This is *not* the same as Ctrl/Cmd + Shift + V — that opens preview
   in the same pane and hides your draft.) If the keyboard shortcut
   doesn't work, right-click the file in the file explorer and pick
   **Open Preview to the Side**.

You should now have the briefing template open, the persona in your head,
and Copilot Chat ready. Don't write anything yet.

---

## Part 1 — Draft the TL;DR (12 min)

The TL;DR is the only thing Alex will read if they only have 20 seconds.
You'll write it in **three sentences**, total **60 words or less**: what
the recommendation is, why now, what the ask is.

**Your turn first — write something ugly.** In the TL;DR section of
`templates/briefing-template.md`, replace the blockquote placeholder with
**three rough sentences** of your own. Don't make it good. Just get it
on the page. You can read `from-previous-session/options-memo.md` for the
recommendation language, but the sentences should be yours.

Now hand it to Copilot. Open Copilot Chat and paste:

```
Tighten this TL;DR to 3 sentences, total 60 words or less, and don't
change what I meant. Show me what you cut and why.

[paste your three sentences here]
```

The "show me what you cut and why" forces Copilot to surface its
decisions. Read what it cut. **You decide whether each cut is right.**
If it removed something you actually meant, push back: *"Put back the
phrase about the lightning block — that matters."*

Iterate until the TL;DR feels like something you'd send. Replace the
placeholder in your template with the final version.

---

## Part 2 — Draft the Recommendation (12 min)

Now the Recommendation paragraph. This is where Alex finds out what
decision you're asking for. Hedging here destroys the briefing.

**Critical:** You are advocating for **the recommended option** in
`from-previous-session/options-memo.md`. Don't re-litigate the three
options. Don't introduce alternatives. The Lab 2 memo already made the
call — your job is to make the case for it, in one paragraph, in
Alex's voice.

**Your turn first.** Write a 75–100 word paragraph in the Recommendation
section of the template. State the decision plainly. Open with "We
recommend…" — not "We could consider…"

Now run the **hedge-detection prompt** in Copilot Chat:

```
List every word or phrase in this paragraph that hedges, softens, or
qualifies the recommendation. For each one, suggest a sharper
replacement that keeps the meaning.

[paste your paragraph]
```

Copilot will catch words you didn't notice you wrote — *"could,"
"might," "potentially," "in some cases," "I think," "appears to."*
Look at every one. Some hedges are honest (you really don't know).
Most aren't (you know, you're just being polite). Sharpen the ones
that aren't.

Replace the placeholder in your template with the sharpened version.

---

## Part 3 — Build the Why-this-program-shape narrative (18 min)

This is the most important section of the briefing — and the most
common one to get wrong. The instinct is to make it a bullet list.
**Don't.** Executives skip bulleted "why" sections because they don't
tell a story. Yours will be three short paragraphs of prose, written
one at a time.

**Per-loop budget: ~6 min each** (2–3 min drafting bullets, 1–2 min for
the Copilot round-trip, 2 min reading aloud and assessing fidelity).
If you fall behind, compress bullet drafting (fewer bullets, rougher
phrasing) — but do **not** skip the read-aloud step. That step is where
you learn to edit AI output instead of accepting it; the rest of Part 3
is arrangement around it.

**Set up a scratch area first.** At the bottom of
`templates/briefing-template.md`, add a line break and a heading
`## Scratch (delete before sending)`. You'll write your bullets there,
convert them to prose, then paste the prose up into the **Why this
program shape** section.

Do this loop **three times** — once per paragraph. Each loop is the same
shape: bullets in your scratch area → Copilot prompt → paragraph in the
Why section.

**Loop 1 — Paragraph 1: What did the data say?** Write 4–6 bullets in
your scratch area answering that question only (signals from the
submissions, stakeholder interviews, audience survey — see
`from-previous-session/themes.md` and `options-memo.md`). Then paste
them into Copilot Chat with this **bullets-to-paragraph prompt** — the
most powerful prompt in the whole series:

```
Take these bullet points and write them as a single short paragraph
(~100 words) that an exec would actually read. Keep the logic; lose
the bullets. Use plain language and short sentences. Don't add
anything I didn't say.

[paste your bullets]
```

Read the output aloud. **Does it actually say more than the bullets, or
does it just sound fancier?** If it's the second, push back: *"That's
flowery. Tighten to 60 words and use the same words my bullets used."*
The canonical Why section in `final/briefing.md` lands at ~60-70 words
for paragraphs 1 and 2; paragraph 3 (the forward-looking "what would
we learn" beat) is intentionally shorter at ~30-40 words. Paste the
final version into the Why section as paragraph 1.

**Loop 2 — Paragraph 2: Why does this shape serve those signals?**
New set of bullets in your scratch area. Same prompt. Same review.
Paste in as paragraph 2.

**Loop 3 — Paragraph 3: What would we learn from running it?**
Same loop, third time. Paste in as paragraph 3.

Your Why section is now three paragraphs, ~150-180 words total
(~60-70 each for P1 and P2, ~30-40 for P3). Delete the scratch area
when you're done.

---

## Part 4 — Themes section + the Timeline (15 min)

You now need to fill the Themes section of the briefing and the
Timeline table. Both pull from
`from-previous-session/theme-session-map.csv` and `themes.md`.

**Themes section.** There are 5 themes in `themes.md` but you'll write
**4 paragraphs**: one each for the 3 highest-signal themes (which become
your Track A / B / C headers) and **one combined paragraph** for themes
4 and 5 (which become the lightning block). See `final/briefing.md` for
the shape if you get stuck.

For each paragraph, use the one-paragraph definition in `themes.md` as
your starting point — but **rewrite it for Alex**, not for the
synthesis audience that created the original. Run this Copilot prompt
for each:

```
Rewrite this theme paragraph for a skeptical COO. 3 sentences max.
Name the audience the track serves. No jargon, no marketing voice.

[paste theme paragraph from themes.md]
```

**Timeline.** Open `from-previous-session/theme-session-map.csv` in
VS Code (click it in the file explorer — it opens as a plain text view
with comma-separated columns; that's fine). Use VS Code's **Find**
(Ctrl/Cmd + F) to **search** for your three track themes — Find will
highlight matching rows but won't hide the others. Note the session IDs
as you scan through the highlighted hits, or open the CSV in a
spreadsheet tool if you'd rather have a true filtered view.

Then open `templates/timeline-template.md` and:

1. Label Track A, Track B, and Track C with the three highest-signal
   themes from the recommendation.
2. Fill each empty cell with a session ID, speaker name, and short
   title from the CSV (e.g., `S003 Yuki Tanaka — IDP without a year of
   runway`). **Constraint:** all regular session slots are 45 minutes,
   so when picking from the CSV, filter to `duration_minutes=45`. The
   six 30-minute sessions (S011, S012, S017, S022, S026, S028) are
   designed for the lightning block, not the main tracks. **Style note:**
   the CSV ships with full conference-program titles; the canonical
   `final/timeline.md` and `final/briefing.md` use **abbreviated** titles
   for table readability. You should do the same — keep the session ID
   and speaker name verbatim, but trim the title to the shortest form
   that still says what the session is about.
3. **Add a lightning block row** before the closing recap, e.g.,
   `| 16:00–16:30 | Lightning block (all-hands) — DX & Eng Leadership: 3 × 10 min | (all-hands) | (all-hands) |`.
   (GFM tables don't support colspan — write the full label in Track A
   and `(all-hands)` in Tracks B and C, matching the keynote and
   closing rows already in the template.) The lightning block is in
   the recommendation but not in the template — you're adding it.
4. **Shift the existing closing recap row** from `16:00–17:00` to
   `16:30–17:00`. The template ships with the closing row at
   `16:00–17:00`; if you only do step 3 and skip this step, you'll
   end up with two overlapping rows and Markdown will silently render
   both.
5. Pull 3 lightning-block speakers from `theme-session-map.csv` whose
   primary theme is Developer experience or Engineering leadership
   **AND** whose `duration_minutes` is 45 (so they fit a 10-minute
   lightning slot without re-pacing). Among the remaining candidates,
   prioritize speakers whose titles best represent the breadth of those
   themes — onboarding, APIs, team structure, productivity. The
   canonical picks Karras (S007), Adebayo (S016), and Lin (S013); other
   defensible picks exist, and you should be able to defend yours when
   you compare to canonical in Part 6.

When the timeline is filled, copy the table into the **Event timeline**
section of the briefing. (Don't link to it — paste it inline. Alex won't
click links.)

---

## Part 5 — Risks and "What we need from you" (12 min)

Two short sections. Both are bullets — these are the only sections in
the briefing that should be bullets.

**Risks and tradeoffs.** 3–5 bullets. What you considered and rejected,
what could still go wrong, what you'd accept losing if you had to. Be
honest. Hand-wavy risks make Alex distrust the whole briefing.

Run this prompt to pressure-test:

```
Critique these risks like Alex Chen (see exec-persona.md) would. Which
ones are real? Which ones are CYA filler? Which obvious risks am I
dodging?

[paste your risks]
```

**What we need from you.** 2–3 bullets. Each starts with a verb —
*Approve,* *Assign,* *Confirm,* *Greenlight.* These are decisions, not
"support." Pull from the "What we need to decide" list at the bottom of
`from-previous-session/options-memo.md`.

---

## Part 6 — Final sharpen + read aloud + reflection (17 min)

You now have a complete draft. Time to land it.

**Step 1 — Final sharpen pass (5 min).** Run this on the whole briefing:

```
Read this whole briefing as Alex Chen would. Where does it lose me?
Where does it sound like marketing? What's the weakest paragraph?
Don't rewrite it — just point.

[paste full briefing]
```

Fix the weakest paragraph. Don't try to fix everything.

**Step 2 — Read aloud and time it (5 min).** Read the briefing out loud
at a normal pace. Time yourself. **Target: under 5 minutes.** If you
went over, run:

```
Cut this briefing by 30%. Tell me what you cut and why.
```

Then put back anything you actually needed.

**Step 3 — Compare to canonical (2 min).** Open `final/briefing.md`
side-by-side with yours. **Don't copy from it.** Just notice three
differences — one yours does better, two it does better. That's your
list of moves to take into your real job.

**Step 4 — Reflection (5 min).** Close all your tabs except this one.
The lead will pose a reflection question and ask you to sit in silence
for 30 seconds before anyone shares. The question is:

> *Where in your real job could you use this exact loop next week?*

Don't put it in Copilot. Don't even type it. Just have the answer ready
when the lead invites the room to share.

---

## You're done.

You have a polished executive briefing in `templates/briefing-template.md`,
a populated timeline in `templates/timeline-template.md`, and a moment
of clarity about where this goes next. That's the whole series:
**clean → synthesize → communicate.**

Pick the one Copilot prompt you used today that surprised you the most.
That's the one you'll use tomorrow.
