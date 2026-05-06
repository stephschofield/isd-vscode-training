# Build the Lab 3 deliverables: briefing.docx and deck.pptx
#
# Reads from templates\ (where attendees fill in their own content).
# Writes to the project root by default. Late joiners can copy
# final\briefing.md and final\deck-outline.md over the templates first.
#
# Requires: pandoc (https://pandoc.org/installing.html)
#
# Run:  powershell -ExecutionPolicy Bypass -File scripts\build-deliverables.ps1

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
Set-Location $RepoRoot

if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Error "pandoc is not on PATH. install it from https://pandoc.org/installing.html and re-run."
    exit 1
}

$BriefingSrc = 'templates\briefing-template.md'
$DeckSrc     = 'templates\deck-outline-template.md'
$BriefingOut = 'briefing.docx'
$DeckOut     = 'deck.pptx'

if (-not (Test-Path $BriefingSrc)) {
    Write-Error "$BriefingSrc not found. run from the repo root."
    exit 1
}

if (-not (Test-Path $DeckSrc)) {
    Write-Error "$DeckSrc not found. run from the repo root."
    exit 1
}

pandoc $BriefingSrc -o $BriefingOut
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Host "wrote $BriefingOut"

pandoc $DeckSrc -o $DeckOut -t pptx --slide-level=1
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Host "wrote $DeckOut"
