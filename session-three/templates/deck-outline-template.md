<!--
Meridian Innovation Summit — Executive Deck Outline (template).

What this file is:
A slide-shaped outline for the executive presentation. Each top-level
heading (#) is one slide. Bullets beneath the heading are the slide's
body. The conversion script (scripts/build-deliverables.sh / .ps1)
turns this file into deck.pptx via Pandoc with --slide-level=1.

How to fill it in:
During Lab 3 Part 6a, paste your finished briefing from
templates/briefing-template.md into Copilot Chat with the prompt in
prompts/03-prompts.md ("Map briefing into 7-slide outline"). Copilot
returns a slide-by-slide outline you paste over each "> [Replace…]"
placeholder below.

Editing rules:
- Don't add or remove "#" headings — the deck has 7 slides by design.
- You can add or remove bullets within a slide.
- Keep each bullet to one short line.
- Don't introduce "##" headings inside a slide — Pandoc reads them as
  new slide breaks.
- Don't add a top-level title heading above slide 1 — Pandoc would
  treat it as an extra slide.
- Don't put any prose above the first "#" heading — Pandoc would
  treat that prose as an extra slide too.
-->

# Meridian Innovation Summit — Program Recommendation

> [Replace with three lines: your name + role, today's date, and the
> sentence "Decision requested" so Alex knows what this deck is
> asking for. Keep it to three lines max — this is the cover.]

# TL;DR

> [Three short bullets — what you recommend, why now, what the ask
> is. Pull verbatim from the TL;DR section of your briefing. If your
> TL;DR is three sentences, each sentence becomes one bullet.]

# Recommendation

> [Three to five bullets stating the program shape plainly. No hedge
> words. Open the first bullet with "We recommend…". Pull from the
> Recommendation paragraph of your briefing — split it into bullets
> by sentence, then tighten each.]

# Why this program shape

> [Three bullets, one per paragraph in your Why section: (1) what the
> data + stakeholders said, (2) why this shape serves those signals,
> (3) what we'd learn from running it. Each bullet is one short
> sentence — this is the slide you'll talk over, not read from.]

# Themes (program tracks)

> [Four bullets: one per track theme (A, B, C) with a one-line
> description, plus one combined bullet for the lightning-block
> themes. Use the theme names from your briefing's Themes section
> verbatim so the deck and doc stay aligned.]

# Event timeline

> [Paste the same timeline table from your briefing. Pandoc renders
> Markdown tables as a slide-embedded table — keep the table compact
> (under 10 rows) so it fits one slide. If it doesn't fit, drop the
> middle break rows and keep keynote, three session blocks, lightning,
> closing.]

# Risks + What we need from you

> [Two short groups of bullets under one slide. **Risks:** 2–3 bullets
> from your Risks section. **Asks:** 2–3 bullets from your "What we
> need from you" section, each starting with a verb (Approve, Assign,
> Confirm). Keep total bullets ≤6 so the slide doesn't crowd.]
