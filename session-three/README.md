# isd-vscode-session3

> **🔒 INTERNAL repo.** This is the source-of-truth and planning workspace
> for Lab 3 — facilitator script, planning docs, tests, and backlog live
> here. The **attendee-facing copy** will be published to
> [`stephschofield/isd-vscode-training/session-three/`](https://github.com/stephschofield/isd-vscode-training/tree/feat/initial-publish-session-three/session-three)
> (currently on the `feat/initial-publish-session-three` branch, pending
> merge of [`isd-vscode-training#1`](https://github.com/stephschofield/isd-vscode-training/pull/1);
> the repo is also still private until the publish lands).
> Edit lab content here, then **manually republish** to the training repo
> after edits land. Do not point attendees at this repo.

## Lab 3 — From Strategy to Executive Story

Part of the **ISD +1 Campaign** hands-on lab series:

> **AI as your thought partner. VS Code as your +1.**
>
> You are the strategist. AI is your junior analyst — fast, tireless, and
> ready to work. Your role gets amplified. VS Code gives you the running
> start.

This is **the third and final lab** in the series:

| Lab | Theme                                    | Verb            |
|-----|------------------------------------------|-----------------|
| 1   | Turn Messy Data into a Clean Foundation  | **Clean**       |
| 2   | Find the Signal. Shape the Strategy.     | **Synthesize**  |
| 3   | From Strategy to Executive Story         | **Communicate** ← *you are here* |

---

## Start here → [`lab/03-briefing.md`](lab/03-briefing.md)

Open that file in VS Code, then render the preview side-by-side with
the source. **On Windows/Linux:** press **Ctrl+K**, release, then **V**.
**On macOS:** press **⌘ K**, then **⌘ V** (keep ⌘ held for the second
press too). (Don't use **Ctrl/Cmd + Shift + V** — that opens the preview
in the same pane and hides your draft.) Then follow the steps. The whole
lab takes **60 minutes**.

By the end of the session you'll walk out with **two executive-ready
deliverables on your machine** about the Meridian Innovation Summit
(both written into `final/` by the conversion script in Part 6):

- `final/briefing.docx` — a Word overview your COO could read in 5 minutes
- `final/deck.pptx` — a 7-slide PowerPoint deck you could hand to your
  leadership team

The Markdown briefing in `templates/briefing-template.md` is the
**authoring intermediate** — it's what you write in VS Code, and it's
what the conversion script in Part 6 turns into the two final files.

---

## What you'll do

- Translate the Lab 2 themes and recommendation into a **first-draft
  briefing** in `templates/briefing-template.md`
- Use Copilot Chat as a **sharp-edged editor** — tightening, finding
  hedges, converting bullets into narrative
- Build a **structured event timeline** for the Innovation Summit
- Map the briefing into a **7-slide deck outline** in
  `templates/deck-outline-template.md`
- Run the conversion script to produce `final/briefing.docx` and `final/deck.pptx`
- Read your finished briefing aloud and time it (target: 5 minutes)
- Reflect on where you'd use this exact loop in your real job next week

---

## Folder layout

```
isd-vscode-session3/
├── README.md                         ← you are here
├── lab/
│   └── 03-briefing.md                ← attendee walkthrough (start here)
├── facilitator/
│   └── 03-briefing-guide.md          ← lead-facilitator script
├── prompts/
│   └── 03-prompts.md                 ← copy-pasteable prompt library
├── scripts/
│   ├── build-deliverables.sh         ← macOS / Linux conversion script
│   └── build-deliverables.ps1        ← Windows conversion script
├── templates/
│   ├── briefing-template.md          ← what you fill in during the lab
│   ├── timeline-template.md          ← timeline scaffold
│   ├── deck-outline-template.md      ← 7-slide deck scaffold
│   └── exec-persona.md               ← who you're writing for
├── from-previous-session/
│   ├── README.md                     ← read this first if you missed Labs 1 or 2
│   ├── clean_submissions.csv         ← Lab 1 output
│   ├── themes.md                     ← Lab 2 output
│   ├── theme-session-map.csv         ← Lab 2 output
│   └── options-memo.md               ← Lab 2 output (your spine)
└── final/
    ├── briefing.md                   ← canonical "what good looks like"
    ├── timeline.md                   ← canonical timeline
    ├── deck-outline.md               ← canonical deck outline
    ├── briefing.docx                 ← canonical Word output (also where `scripts/build-deliverables.{sh,ps1}` writes the attendee version)
    └── deck.pptx                     ← canonical PowerPoint output (also where `scripts/build-deliverables.{sh,ps1}` writes the attendee version)
```

---

## Missed Lab 1 or Lab 2? You're still good.

The series builds on itself, but **Lab 3 is set up so you can join cold**.
Read [`from-previous-session/README.md`](from-previous-session/README.md)
first — it's a 3-minute orientation that catches you up on what the
previous two labs produced and how to use those outputs today.

Then jump into [`lab/03-briefing.md`](lab/03-briefing.md).

---

## Before you start

**Pre-reqs (have these ready before you arrive):**

- A **GitHub account** — sign up at <https://github.com/signup> if you
  don't have one
- **GitHub Copilot** access provisioned (you'll see the Copilot chat
  icon in the VS Code sidebar — same setup as Labs 1 and 2)
- The 1-hour intro **VS Code training** (sent separately before Lab 1)
- A working **browser**. The Codespace includes **Pandoc** preinstalled —
  that's what turns your Markdown briefing into the `.docx` and `.pptx`
  deliverables in Part 6, no install required.

**Day-of setup:**

1. **Open the Codespace.** From the [training hub](https://stephschofield.github.io/isd-vscode-training/),
   click *Open in Codespaces* on the Session 3 tile, or use this direct link:
   [open Session 3 in Codespaces ↗](https://codespaces.new/stephschofield/isd-vscode-training/tree/main?devcontainer_path=session-three/.devcontainer/devcontainer.json&quickstart=1).
   The Codespace boots with `session-three/` as the workspace, Copilot
   pre-installed, and Pandoc ready to go.
2. Confirm **GitHub Copilot Chat** is signed in (chat bubble icon in
   the **left sidebar** of VS Code), and set the chat mode dropdown to
   **Agent** — you'll stay in Agent mode for the whole lab so Copilot
   can read your draft and edit files when asked.
3. Open [`lab/03-briefing.md`](lab/03-briefing.md) and toggle the
   Markdown preview side-by-side. **On Windows/Linux:** press
   **Ctrl+K**, release, then **V**. **On macOS:** press **⌘ K**, then
   **⌘ V** (keep ⌘ held for the second press too). (If the shortcut
   doesn't work, right-click the file in the file explorer and pick
   **Open Preview to the Side**.)

If your Copilot icon shows a red dot, ask one of the leads — that's a
2-minute fix and it should not block you from starting.

> Prefer working locally? You can clone the repo, open `session-three/`
> in desktop VS Code, and install [Pandoc](https://pandoc.org/installing.html)
> yourself. The Codespace path is the recommended one.

---

## A note on what this lab is — and isn't

**This lab is about editing, not generating.**

The default reflex with AI is "have it write the thing for me." Today
you'll do the opposite: you'll write the first ugly draft yourself, and
use Copilot as the world's most patient editor. By the end of the
session you'll feel the difference, and you'll know which one produces
better executive writing.

The briefing and deck you walk out with are yours — not Copilot's.
