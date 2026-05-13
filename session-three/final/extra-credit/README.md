# Extra credit — make the deck not look like 2014

> **You're here because you finished the lab and you're staring at
> `final/deck.pptx` thinking, "this is structurally right and visually
> embarrassing."** Same. This README walks you through rebuilding the
> same deck with a design-aware AI skill so the visuals stop being the
> weakest link. Same content, same prompts, same persona — different
> renderer.

This is a **stretch path, after the main lab is complete**. Don't start
here. The main lab ([`lab/03-briefing.md`](../../lab/03-briefing.md)) is
where you learned the editing loop and produced the canonical
[`final/briefing.docx`](../briefing.docx) and
[`final/deck.pptx`](../deck.pptx). This is what you do with the last
20–30 minutes if you have them, or after the workshop on your own machine.

The arguments in your deck are already yours. This step makes the
*presentation* match the *thinking*.

---

## What you'll do

- Pick a design skill (or MCP server) from the menu below
- Hand it your existing `final/deck-outline.md` and
  `templates/exec-persona.md` — no new writing required
- Reuse the Lab-3 prompts from `prompts/03-prompts.md` to keep the
  *writing* tight while the skill handles the *visuals*
- Produce a styled deck in your chosen format — `.pptx` or HTML
- Compare your result to the included example
  (`meridian-innovation-summit-deck.html`) to see one finished version

You can do this in **Claude Code** or **Copilot Chat (Agent mode)** —
the skills below run in either; pick whichever you already have open.

---

## Pick your skill — the menu

These are an equal-weight menu. Read the one-liners, pick the one that
matches how you want to work, click through to the upstream repo for
the canonical install instructions. (We don't paraphrase install steps
here — those drift, and the upstream README is the source of truth.)

### [ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill)

**Reach for this when** you want a senior UI/UX reviewer in the loop —
you write the slide, it tells you what's wrong with it and rewrites the
visual structure. Best fit if you like a critique-and-revise rhythm.

- **Install:** see the [upstream README](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill#readme)
- **Invoke:** drop the skill into your Claude Code skills directory,
  then ask: *"Use ui-ux-pro-max to review and restyle the slides in
  `final/deck-outline.md` for an executive audience (`templates/exec-persona.md`).
  Output as a standalone HTML deck."*

### [taste-skill](https://github.com/Leonxlnx/taste-skill)

**Reach for this when** the brief is "make it look intentional, not
generic." taste-skill leans on aesthetic curation rather than rule-
based design — it picks a direction (editorial, brutalist, glass, etc.)
and commits to it.

- **Install:** see the [upstream README](https://github.com/Leonxlnx/taste-skill#readme)
- **Invoke:** *"Use taste-skill to design a deck from
  `final/deck-outline.md`. Audience is `templates/exec-persona.md`
  (skeptical COO). Pick a single visual direction and apply it
  consistently across all 7 slides."*

### [impeccable](https://github.com/pbakaus/impeccable)

**Reach for this when** typography, spacing, and color discipline
matter more than novelty. impeccable favors restraint — it's the right
skill for executive output where "professional" matters more than
"distinctive."

- **Install:** see the [upstream README](https://github.com/pbakaus/impeccable#readme)
- **Invoke:** *"Use impeccable to style a 7-slide HTML deck from
  `final/deck-outline.md`. Target reader is `templates/exec-persona.md`.
  Restrained color palette, typographic hierarchy, no decorative noise."*

### [Stitch MCP server](https://github.com/google-labs-code/stitch-skills)

**Reach for this when** you want generation rather than review — Stitch
is an MCP server (Google Labs) that produces design-aware artifacts and
hands them back into your editor. Best fit if you want the skill to
*make* the visuals rather than critique them.

- **Install:** see the [upstream README](https://github.com/google-labs-code/stitch-skills#readme)
  for MCP server setup (you'll add it to your MCP config — slightly
  more setup than the Claude Code skills above)
- **Invoke (after MCP is connected):** *"Use Stitch to generate a
  styled deck from `final/deck-outline.md`. Audience:
  `templates/exec-persona.md`. Output: HTML deck or PowerPoint."*

### Or any tool of your choice

The four above are starting points, not a closed list. Anything that
satisfies these two shape rules works:

- It accepts your existing `final/deck-outline.md` (or `final/briefing.md`)
  and `templates/exec-persona.md` as input.
- It produces either `.pptx`-compatible content or a standalone HTML
  deck as output.

If you've got a favorite design skill or generation tool that fits
those rules, use it.

---

## Pick your output format

You have two options. Both are real.

- **PowerPoint (`.pptx`)** — closes the loop with the lab's canonical
  `final/deck.pptx`. You're upgrading the file you already produced.
  Best when the deck will be opened in PowerPoint, edited by a
  teammate, or merged into a corporate template downstream. Stitch MCP
  emits `.pptx` directly; the Claude Code skills typically emit HTML,
  but you can hand the styled HTML back to Pandoc or a screenshot tool
  to produce a `.pptx` if you need it.
- **HTML deck** — matches the included example
  (`meridian-innovation-summit-deck.html`). Best when the deck will be
  presented from a browser, embedded in a doc, or shared via a link.
  All four skills above can produce this directly. Export to PDF from
  the browser if you need a static artifact.

Not sure? Use HTML. It's the faster path with the named skills, and
the example file in this folder is HTML for a reason — you can open it
right now and see what good looks like.

---

## Run the loop

Three short steps. Same muscle memory you built in Lab 3.

1. **Hand the skill your audience.** Open `templates/exec-persona.md`
   in the chat alongside the skill's invocation. The persona is what
   keeps the deck from drifting into marketing voice — same reason it
   set the tone for your briefing in Part 0 of the main lab.
2. **Hand it your content source.** Two choices:
   - `final/deck-outline.md` — slide-by-slide structure, one H1 per
     slide. This is what you want most of the time.
   - `final/briefing.md` — narrative source. Use this if you want the
     skill to re-derive the slide breakdown rather than honor the one
     you already shipped.
3. **Reuse the Lab-3 prompts to keep the writing tight.** The skill is
   the visual designer; the prompts in `prompts/03-prompts.md` are
   still your editor. Specifically:
   - The **tightening** prompts (`prompts/03-prompts.md` → *Tightening
     prompts*) for any slide where the bullets got verbose.
   - The **hedge-detection** prompts (→ *Hedge-detection prompts*) for
     any slide where the visual treatment somehow re-introduced
     "potentially" or "may help to."
   - The **persona-aware critique** prompts (→ *Persona-aware critique
     prompts*) to pressure-test the finished deck against Alex Chen
     before you call it done.

You're not writing new prompts. You're routing the prompts you
already used through a skill that also knows what good visuals look
like.

---

## What "good" looks like

Open [`meridian-innovation-summit-deck.html`](./meridian-innovation-summit-deck.html)
in your browser. That's a finished extra-credit pass on this same
content — the 7 outline slides plus a cover scene (8 sections total),
same persona, same recommendation.

What you're looking for in that example:

- Color used semantically (track A vs B vs C are visually distinct,
  not just labeled), not decoratively
- A typographic hierarchy you can read while squinting from across the
  room — title, supporting line, body
- Whitespace that actually breathes, not "default Pandoc grid"
- A finished feel an exec could skim in 90 seconds and act on

Your output won't look identical — different skill, different
direction, different taste. That's fine. The question is whether *your*
version would survive the same skim test.

---

## A note on what this is — and isn't

**This extra credit is about presentation, not content.**

The main lab was about editing — turning a recommendation into prose
sharp enough that an exec would act on it. That work is done. Your
briefing and your deck outline already say the right things in the
right order.

This step makes the *deck* look like it deserves the *thinking* that
went into it. The arguments are still yours. The skill is just a
better visual designer than the default Pandoc template.

If you walk out of the workshop with both — the editing reflex from
the main lab, and a deck that doesn't look like a 2014 template — you
got a lot more out of 60 minutes than most people do.
