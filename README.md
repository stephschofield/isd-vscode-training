# isd-vscode-training — landing page

This branch (`gh-pages`) hosts the training landing page at:

**https://stephschofield.github.io/isd-vscode-training/**

## Editing

Everything lives in `index.html` (single file, no build step).
Push to `gh-pages` and GitHub Pages rebuilds the site automatically.

## What lives where

- **`gh-pages` branch** (this one) → landing page only.
- **`main` branch** → lab content under `session-one/`, `session-two/`, `session-three/`.

The landing page links to each session folder via `vscode.dev`, e.g.
`https://vscode.dev/github/stephschofield/isd-vscode-training/tree/main/session-one`.

The repo must remain **public** for those links to work without authentication.

## Flipping a session from "Coming soon" → "Available now"

In `index.html`, change the tile's `data-status="coming-soon"` to `data-status="ready"`
and update the pill text from `Coming soon` to `Available now`.
