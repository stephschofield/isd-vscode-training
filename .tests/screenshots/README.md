# U2 verification evidence — codespaces editor=web

Captured 2026-05-07 by agent-browser against the deployed
`https://stephschofield.github.io/isd-vscode-training/` page after
commit `caeb130` (gh-pages).

## What was verified

1. **Static URL contract** — every pill and CTA on the deployed landing
   page carries `editor=web` in its `href`. Confirmed via direct DOM
   query against the live page (see commit `43bbe5e` test output).
2. **GitHub honors `editor=web` through the auth flow** — opening each
   `codespaces.new/...?...&editor=web` URL in a fresh, unauthenticated
   browser session redirects to
   `github.com/login?return_to=...%26editor%3Dweb`, preserving the
   parameter intact through the login gate. After login, GitHub returns
   the user to the same URL with `editor=web` still present, which is
   what selects the web-editor channel.

## What was not verified in automation (and why)

- The post-login behavior of `editor=web` against an account whose
  default editor preference is set to "Visual Studio Code" (desktop).
  Verifying this requires a real GitHub account, consumes Codespaces
  quota, and is exactly the variable the fix is designed to override.
  Plan U2 calls for this manual check in two browsers; that step is
  intentionally human-in-the-loop and tracked separately.

## Files

| File | What it shows |
|---|---|
| `01-landing.png` | Deployed landing page (six tiles, three CTAs visible) |
| `02-codespace-session-one.png` | GitHub auth gate for session-one URL — note `editor%3Dweb` in the `return_to` URL |
| `03-codespace-session-two.png` | Same, session-two |
| `04-codespace-session-three.png` | Same, session-three |
| `u2-flow.webm` | Recording of the four navigations |
| `u2-landing-flow.webm` | Earlier recording of landing-page load + DOM-attr verification |
| `before-*.png`, `after-*.png` | Pre-existing visual-regression captures from prior PRs (not this fix) |

## Reproducing

```bash
bash .tests/test-codespaces-links.sh index.html      # link-shape contract
# Then, with agent-browser installed:
agent-browser open https://stephschofield.github.io/isd-vscode-training/
# Inspect any pill/cta href; confirm editor=web is present.
```
