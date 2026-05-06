# Session 2 — Find the Signal. Shape the Strategy.

*[← back to series overview](../README.md)*

Part of the **ISD +1 Campaign** hands-on lab series:

> **AI as your thought partner. VS Code as your +1.**
>
> You are the strategist. AI is your junior analyst — fast, tireless, and
> ready to work. Your role gets amplified. VS Code gives you the running
> start.

This is **the second lab** in the series:

| Lab | Theme                                    | Verb            |
|-----|------------------------------------------|-----------------|
| 1   | Turn Messy Data into a Clean Foundation  | **Clean**       |
| 2   | Find the Signal. Shape the Strategy.     | **Synthesize**  ← *you are here* |
| 3   | From Strategy to Executive Story         | **Communicate** |

---

## Start here → [`lab/02-synthesis.md`](lab/02-synthesis.md)

Open that file in VS Code, hit **Ctrl/Cmd + K**, then **V** to render the
preview side-by-side with the source. Then follow the steps. The whole
lab takes about **75–90 minutes**.

You're here to do the work that, until recently, only humans could do:
take a pile of noisy stakeholder input, pull real themes out of it, and
pressure-test those themes out loud — with Copilot as your thinking
partner, not your decision maker.

By the end of the session you'll have a **1-page strategic options memo**
— two or three program directions, with stated tradeoffs — that you
could hand to leadership tomorrow.

---

## What you'll do

1. **Synthesize themes** from stakeholder transcripts, notes, and the
   whiteboard, grounded in real evidence (not pulled from thin air).
2. **Map sessions to themes** so you can see which speaker submissions
   support each direction — and which themes are stakeholder wishful
   thinking with no submissions behind them.
3. **Pressure-test your thinking.** Ask Copilot to argue *against* your
   conclusions. Use it as a sparring partner, not a yes-machine.

You won't write any code. You won't run any scripts. You'll mostly read,
prompt, and argue back.

---

## Folder layout

Everything you need for today is in this `session-two/` folder:

```
session-two/
├── README.md                              ← you are here
├── lab/
│   └── 02-synthesis.md                    ← attendee walkthrough (start here)
├── prompts/
│   └── 02-prompts.md                      ← copy-pasteable prompt library
├── inputs/
│   ├── README.md
│   ├── transcripts/                       ← 3 stakeholder interview transcripts
│   ├── notes/                             ← kickoff + sponsor 1:1 notes
│   └── whiteboard/                        ← strategy offsite whiteboard
├── from-previous-session/
│   ├── README.md
│   └── clean_submissions.csv              ← Lab 1's cleaned dataset
├── outputs/                                ← created during the lab; holds your
│                                             deliverables (themes, map, memo)
│                                             that Lab 3 picks up from
└── solutions/                             ← don't open until the lab tells you to
    ├── README.md
    ├── themes.md
    ├── theme-session-map.csv
    └── options-memo.md
```

| Folder | What's in it |
|--------|--------------|
| [`lab/`](lab/) | Your step-by-step walkthrough for today |
| [`inputs/`](inputs/) | Stakeholder transcripts, notes, and the whiteboard transcription |
| [`from-previous-session/`](from-previous-session/) | Lab 1's cleaned dataset, plus a short README on what happened |
| [`prompts/`](prompts/) | A copy/paste bank of every Copilot prompt used in the session |
| `outputs/` | **Your** working folder — created during the lab; holds the themes, map, and memo you produce. Lab 3 picks up from here. |
| [`solutions/`](solutions/) | Canonical answers — **don't open until the lab walkthrough tells you to** |

---

## I missed Lab 1 — I'm here for Lab 2

You're not behind. Open
[`from-previous-session/README.md`](from-previous-session/README.md) for
a 2-minute orientation on what happened last time and what you're
inheriting. The cleaned dataset
([`from-previous-session/clean_submissions.csv`](from-previous-session/clean_submissions.csv))
is your source of truth for today — same file you would have produced
in Lab 1.

---

## What you need

- VS Code with **GitHub Copilot** already signed in (set up before Lab 1)
