# Lab 3 prompts — copy-pasteable library

> Every prompt used in `lab/03-briefing.md`, plus a few stretch prompts.
> Group by intent, not by walkthrough part — that way you can grab the
> right tool when you face the same problem in your real job.

## Tightening prompts

For shrinking a draft without losing meaning. Used most heavily in the
TL;DR and Recommendation sections.

```
Tighten this TL;DR to 3 sentences, total 60 words or less, and don't
change what I meant. Show me what you cut and why.

[paste your three sentences here]
```

```
Cut this briefing by 30%. Tell me what you cut and why.
```

```
Make this 30% shorter and tell me what you cut.
```

## Hedge-detection prompts

For finding and removing softening language that erodes a recommendation.

```
List every word or phrase in this paragraph that hedges, softens, or
qualifies the recommendation. For each one, suggest a sharper
replacement that keeps the meaning.

[paste your paragraph]
```

```
This paragraph contains hedge words. Rewrite it without any of these:
"could," "might," "potentially," "in some cases," "I think," "appears
to," "may help to," "we believe."
```

## Bullets → narrative prompts

The single most powerful move in this lab. Use it any time bullets are
hiding the underlying story.

```
Take these bullet points and write them as a single short paragraph
(~100 words) that an exec would actually read. Keep the logic; lose
the bullets. Use plain language and short sentences. Don't add
anything I didn't say.

[paste your bullets]
```

```
Convert these bullets into one tight paragraph. Match my voice (short
sentences, no jargon). 60 words max.
```

## Persona-aware critique prompts

For pressure-testing prose against the actual reader.

```
Critique this draft like Alex Chen (see exec-persona.md) would.
Be specific about which sentences would make them stop reading and why.

[paste your draft]
```

```
Critique these risks like Alex Chen (see exec-persona.md) would. Which
ones are real? Which ones are CYA filler? Which obvious risks am I
dodging?

[paste your risks]
```

```
Read this whole briefing as Alex Chen would. Where does it lose me?
Where does it sound like marketing? What's the weakest paragraph?
Don't rewrite it — just point.

[paste full briefing]
```

## Rewriting for a different reader prompts

For when a single section needs to land for a specific persona.

```
Rewrite this theme paragraph for a skeptical COO. 3 sentences max.
Name the audience the track serves. No jargon, no marketing voice.

[paste theme paragraph from themes.md]
```

## Steel-man prompts

Final pressure-test before you ship.

```
Steel-man the recommendation in this briefing. What's the strongest
case against it? What would you change in the briefing to address that
case without weakening the recommendation?

[paste full briefing]
```

## Convert briefing → deck outline

For mapping a finished briefing into a slide-shaped outline that
Pandoc can convert into PowerPoint. Used in Part 6a.

```
Map this briefing into the 7-slide outline below. For each slide, give
me a 1-line title (use the heading already in the template) and 3-5
short bullets. Don't add content I didn't write. Keep each bullet to
one short line.

[paste the deck-outline-template skeleton, then paste the full briefing]
```

## Stretch prompts

For after the lab, when you want to push further.

```
Rewrite this for a CFO instead of a COO. Same recommendation, same
data, different reader. Keep it under 600 words.
```

```
Convert this briefing into a one-slide summary I could paste into a
deck. Use 5 bullets max. Keep the recommendation in the slide title.
```

```
Argue against this paragraph. Then polish it.
```

---

## Prompt-writing principles for editing work

These are the third and final principles set across the lab series.
Series 1 was about cleaning; Series 2 was about synthesizing; this set
is about editing.

- **Anchor every prompt to who's reading.** The persona changes the
  prose more than any other variable. *"For Alex Chen"* produces
  different output than *"for an executive."*
- **Constraints make Copilot sharper.** Word counts, sentence counts,
  forbidden-word lists ("no hedge words"), and "show me what you cut"
  all force Copilot to make explicit decisions you can review.
- **Always write your own bad first draft.** Copilot is significantly
  better at editing yours than at generating its own from scratch.
  Generated-from-scratch text drifts toward LinkedIn voice within
  three sentences.
- **"Argue against this paragraph" before "polish this paragraph."**
  Pressure-testing surfaces the weakness; polishing only sands it.
  Polish after pressure-test, not before.
