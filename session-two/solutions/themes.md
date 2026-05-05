# Innovation Summit 2026 — Themes (canonical)

> This is the canonical "good answer" for Lab 2. Your themes don't have
> to match this exactly. Different framings of the same evidence are
> valid. This file exists so a late joiner can copy it and continue, and
> so Lab 3 has a stable input regardless of how the live session went.
>
> Five themes. Each carries evidence quotes from the inputs and an honest
> count of supporting submissions in
> [`../from-previous-session/clean_submissions.csv`](../from-previous-session/clean_submissions.csv).
> Each carries the strongest counter-argument that survived our pressure-
> test in Parts 4 and 6 of [`../lab/02-synthesis.md`](../lab/02-synthesis.md).

---

## Theme 1: AI in the boring middle of the workday

**Why it matters (1 sentence):**
Stakeholders converge that the differentiated story Meridian can tell
isn't about moonshot AI but about how it has quietly changed the
day-to-day work of customer success, planning, and operations teams.

**Evidence:**
- *"AI in real workflows, by the people who actually do the work. Not a
  keynote about the future of AI."* — Jane, exec sponsor transcript
- *"AI in everyday workflows is real. We have forty-eight submissions
  on it, which is more than any other category. Most of them are good,
  several are excellent."* — Marcus, program lead transcript
- *"The boring middle is the story"* — whiteboard margin scribble,
  attributed to Jane

**Submissions supporting this theme:** 54 (largest single category).

> **Note on the count vs. Marcus's quote.** Marcus says *"forty-eight submissions"* in his transcript — that is the raw `topic_tag = "AI in Workflows"` count in [`../from-previous-session/clean_submissions.csv`](../from-previous-session/clean_submissions.csv). The mapped count here is **54**, taken directly from [`./theme-session-map.csv`](./theme-session-map.csv) (rows where `assigned_theme = "AI in the boring middle of the workday"`); the +6 delta is six data-and-analytics talks re-cast as AI-in-workflows during the mapping step. Both numbers are correct at their own level of analysis: 48 is the raw topic-tag, 54 is the mapped theme.

**Strongest counter-argument:** *"The risk is we end up with thirty variations of the same talk."* (Priya) — **mitigation:** curate for variety of role, function, and honest failure stories, not just success narratives.

---

## Theme 2: Cloud spend as financial discipline, not a side quest

**Why it matters (1 sentence):**
Both Jane and the CFO have explicitly asked for a credible external
narrative on responsible cloud spending — and the submission base
genuinely supports it.

**Evidence:**
- *"Our CFO asked me twice in the last month why we don't have a
  clearer story externally about how we manage cloud spend."* — Jane,
  exec sponsor transcript
- *"Cloud spending — yeah, that's a real one too. We have a solid
  batch of submissions on FinOps and cost discipline."* — Marcus,
  program lead transcript

**Submissions supporting this theme:** 34
**Strongest counter-argument:** "FinOps will feel boring next to AI;
adjacency in the schedule matters" (Marcus) — **mitigation:** schedule
cloud sessions in their own track, not as the second talk after an AI
keynote, and include at least one talk that admits to what hasn't been
figured out yet (Priya's ask).

---

## Theme 3: Real customer stories from inside the company

**Why it matters (1 sentence):**
All three stakeholders agree the Summit needs at least one named,
specific, internal-customer-on-stage moment per day or it will feel
abstract — and the dataset has enough credible submissions to fill a
full track.

**Evidence:**
- *"I want a real account manager standing on stage describing what one
  specific customer asked for, how the field team responded, what they
  got wrong."* — Jane, exec sponsor transcript
- *"The submissions are there. The challenge is getting field folks
  comfortable on stage."* — Marcus, program lead transcript
- *"customer voices [tick mark]"* — whiteboard, ASKS column

**Submissions supporting this theme:** 42 (includes 2 submissions
explicitly framed as external-brand-visibility content, plus several
data-and-analytics talks re-cast as customer-story angles during
mapping)

> **Note on the count.** The mapped count of **42** comes from [`./theme-session-map.csv`](./theme-session-map.csv) (rows where `assigned_theme = "Real customer stories from inside the company"`). The raw `topic_tag = "Customer Stories"` count in [`../from-previous-session/clean_submissions.csv`](../from-previous-session/clean_submissions.csv) is **34**; the +8 delta reflects re-casting during the mapping step.

**Strongest counter-argument:** None survived the pressure-test
intact — this is the safest theme. The remaining risk is execution
(stage-shy speakers), not framing.

---

## Theme 4: Developer experience as a strategic investment

**Why it matters (1 sentence):**
Engineering leadership has made a credible argument that DX shows up in
cloud cost, customer responsiveness, and senior-engineer retention —
and ~30 submissions exist to support a real track, *if* it's framed
around outcomes rather than tooling.

**Evidence:**
- *"Developer experience is a strategic investment for this company,
  not a comfort item. The reason our cloud bills are high is partly
  that engineers have to wait six minutes for a CI run."* — Priya, eng
  director transcript
- *"There's a version of that direction that is about how we ship
  faster and more reliably, which is exactly the kind of 'we run our
  own platform like adults' story Jane says she wants."* — Marcus,
  program lead transcript
- *"Fine. Include DX. But make it about outcomes — shipping speed,
  cost, retention. Not about tools."* — Jane, 1:1 follow-up notes

**Submissions supporting this theme:** 30
**Strongest counter-argument:** "DX is inward-facing; it'll bore the
audience" (Jane, initially) — **mitigation:** the framing problem
*is* the topic problem. Curate DX sessions around outcomes (shipping
speed, cost, retention) and reject pitches that are tooling
demonstrations.

---

## Theme 5: Security and compliance as something we ship, not survive

**Why it matters (1 sentence):**
Security shows up in the submission base (~26 talks) but in none of the
stakeholder transcripts as a top-line ask — meaning it's a theme the
*data* surfaced rather than the executives, and worth keeping precisely
because it isn't politically pre-loaded.

**Evidence:**
- 26 submissions in the cleaned dataset under the canonical "Security
  and Compliance" topic tag (verified count from
  `clean_submissions.csv`)
- No stakeholder explicitly opposed it; absence from the transcripts
  reads as "taken for granted," not "rejected"
- Implicit support from Marcus: *"Every session should trace to a
  stated direction"* — Security is a direction the submission base
  supports independent of stakeholder push

**Submissions supporting this theme:** 26
**Strongest counter-argument:** "If no exec is asking for it, it
shouldn't be a track" — **mitigation:** keep as a smaller, contained
direction (one track, not two), and let the submission base earn it
on its own merit rather than pitching it as strategically pivotal.

---

## Themes considered and not included

These came up in the inputs but did not survive the grounded-themes
bar. Naming them here so the cut is auditable:

- **External brand visibility for Meridian** — pushed by Jane
  ("press, podcasts, the recordings going somewhere people
  can find them") but only 2 submissions in the dataset directly
  support an external-facing brand session. The pressure-test surfaced
  Priya's strong objection. **Compromise** in the options memo: the
  Summit will be recorded and selectively distributed externally, but
  brand outcomes will not shape the program structure. (Marcus's
  "record sessions, distribute after, don't bend the program shape"
  line carried.)
- **Quantum computing** — appeared in the kickoff notes (Henrik,
  twice) and the offsite whiteboard parking lot. **Zero matching
  submissions** in `clean_submissions.csv`. No internal expertise
  named. Cut decisively.
- **Data and analytics as a top-line theme** — supported by 20
  submissions but not raised by any stakeholder as a strategic
  priority. Better placed as cross-cutting content distributed across
  the AI-in-workflows and customer-stories tracks than as its own
  direction.
