#!/usr/bin/env python3
"""
Regenerate session-one/data/clean_submissions.csv from raw_submissions.csv
by applying ONLY the cleanup steps that lab/01-cleanup.md actually teaches
attendees to perform.

Why this script exists
----------------------
The earlier canonical clean_submissions.csv had divergences from what the
lab teaches:

  - company: heavily title-cased, but the lab never asks attendees to
    clean company.
  - bio_short: wholly rewritten, but data/README says bios are "mostly
    fine; a few are blank".
  - "Dr." prefix: the lab teaches "Dr. " (with period and space); the
    earlier canonical stripped the prefix entirely.
  - Out-of-window dates: the lab says "Don't delete them. Show me the
    list so I can decide row by row"; the earlier canonical silently
    dropped all 3 non-2026 dates.
  - "Unknown" escape hatch: the lab teaches "Mark anything you're truly
    not sure about as Unknown rather than guessing"; the earlier
    canonical contained zero Unknown values.
  - Row count: the lab says "168-174 range is also fine - a few
    (revised) resubmissions legitimately survive dedup"; the earlier
    canonical was exactly 162.

Part 5's "Compare your cleaned file against clean_submissions.csv" prompt
would have systematically reported divergences for cleanup steps the lab
never asked attendees to perform. This script eliminates that drift by
reproducing the lab's transformations exactly.

Run: python3 session-one/data/regenerate_clean.py
"""
from __future__ import annotations

import csv
import re
from collections import defaultdict
from pathlib import Path

HERE = Path(__file__).parent
RAW = HERE / "raw_submissions.csv"
CLEAN = HERE / "clean_submissions.csv"

CANONICAL_TOPICS = ["AI", "Cloud", "Data", "Security", "DevOps", "Leadership"]
CANONICAL_TRACKS = ["Technical Deep Dive", "Strategy", "Workshop"]

# Topic surface form -> canonical (Part 2 Step 1)
TOPIC_MAP = {
    "ai": "AI",
    "a.i.": "AI",
    "artificial intelligence": "AI",
    "gen ai": "AI",
    "cloud": "Cloud",
    "cloud computing": "Cloud",
    "data": "Data",
    "data & analytics": "Data",
    "analytics": "Data",
    "security": "Security",
    "cyber security": "Security",
    "cybersecurity": "Security",
    "devops": "DevOps",
    "dev ops": "DevOps",
    "devsecops": "DevOps",
    "leadership": "Leadership",
    "people leadership": "Leadership",
    "mgmt": "Leadership",
}

# Track surface form -> canonical (Part 2 Step 3 stretch + Part 4 Step 2 fixes)
TRACK_MAP = {
    "technical deep dive": "Technical Deep Dive",
    "tech deep dive": "Technical Deep Dive",
    "strategy": "Strategy",
    "stratagy": "Strategy",
    "workshop": "Workshop",
    "work shop": "Workshop",
}

# Experience level surface form -> canonical (Part 4 Step 2)
EXPERIENCE_MAP = {
    "beginner": "Beginner",
    "novice": "Beginner",
    "intermediate": "Intermediate",
    "advanced": "Advanced",
    "expert": "Advanced",
}

# Word-form session lengths (Part 4 Step 1)
LENGTH_WORDS = {"thirty": 30, "forty-five": 45, "sixty": 60, "1 hour": 60}


def normalize_topic(value: str) -> str:
    return TOPIC_MAP.get(value.strip().lower(), value.strip())


def normalize_track(value: str) -> str:
    v = value.strip().lower()
    if not v:
        return "Unknown"  # Part 4 Step 2: mark blanks as Unknown
    return TRACK_MAP.get(v, value.strip())


def normalize_experience(value: str) -> str:
    v = value.strip().lower()
    if not v:
        return "Unknown"  # Part 4 Step 2: mark blanks as Unknown
    return EXPERIENCE_MAP.get(v, value.strip())


def normalize_length(value: str) -> int | str:
    """Part 4 Step 1: convert any non-numeric length into pure 30/45/60."""
    v = value.strip().lower()
    if v.isdigit():
        return int(v)
    if v in LENGTH_WORDS:
        return LENGTH_WORDS[v]
    # Strip "min" / "m" suffix
    m = re.match(r"^(\d+)\s*(min|m)$", v)
    if m:
        return int(m.group(1))
    return value


def normalize_date(value: str) -> str:
    """Part 2 Step 2: convert to YYYY-MM-DD. Preserve out-of-window dates
    (Part 4 Step 3 says don't auto-delete; flag instead)."""
    v = value.strip()
    if re.match(r"^\d{4}-\d{2}-\d{2}$", v):
        return v
    # M/D/YY or M/D/YYYY
    m = re.match(r"^(\d{1,2})/(\d{1,2})/(\d{2,4})$", v)
    if m:
        mo, day, yr = m.group(1), m.group(2), m.group(3)
        if len(yr) == 2:
            yr = "20" + yr
        return f"{yr}-{int(mo):02d}-{int(day):02d}"
    # Long form: "March 12, 2026"
    months = {
        "january": 1, "february": 2, "march": 3, "april": 4, "may": 5,
        "june": 6, "july": 7, "august": 8, "september": 9, "october": 10,
        "november": 11, "december": 12,
    }
    m = re.match(r"^(\w+)\s+(\d{1,2}),?\s+(\d{4})$", v)
    if m and m.group(1).lower() in months:
        mo = months[m.group(1).lower()]
        day = int(m.group(2))
        yr = m.group(3)
        return f"{yr}-{mo:02d}-{day:02d}"
    return v


def normalize_av(value: str) -> str:
    """Part 4 Step 4: Yes/No. Blanks -> No (default to no AV)."""
    v = value.strip().lower()
    if v in ("yes", "y", "true", "1"):
        return "Yes"
    if v in ("no", "n", "false", "0", ""):
        return "No"
    return value


def normalize_name(value: str) -> str:
    """Part 2 Step 3: trim, "First Last" Title Case, "Dr. " for titles."""
    v = " ".join(value.split())  # collapse internal whitespace + trim
    has_dr_prefix = re.match(r"^dr\.?\s+", v, re.IGNORECASE)
    if has_dr_prefix:
        v = re.sub(r"^dr\.?\s+", "", v, flags=re.IGNORECASE)
    # Title case while preserving common name particles
    parts = []
    for word in v.split():
        # Handle hyphens and apostrophes
        parts.append("-".join(p.capitalize() for p in word.split("-")))
    titled = " ".join(parts)
    return f"Dr. {titled}" if has_dr_prefix else titled


def canonicalize_email(email: str, name_to_canonical: dict[str, str]) -> str:
    """Part 3 Step 1: collapse .work variants onto canonical address."""
    e = email.strip().lower()
    # If this email is a .work variant we know about, return its canonical.
    return name_to_canonical.get(e, e)


def build_email_canonical_map(rows: list[dict]) -> dict[str, str]:
    """For each speaker with multiple emails, pick the non-.work variant
    as canonical (matches the lab's "simpler one" guidance)."""
    by_name = defaultdict(set)
    for r in rows:
        name_norm = normalize_name(r["speaker_name"]).lower()
        # Strip "Dr. " prefix for grouping (a person is the same person
        # regardless of whether one row uses the title and another doesn't)
        name_key = re.sub(r"^dr\.\s+", "", name_norm)
        by_name[name_key].add(r["speaker_email"].strip().lower())
    mapping: dict[str, str] = {}
    for emails in by_name.values():
        if len(emails) <= 1:
            continue
        non_work = [e for e in emails if ".work@" not in e]
        canonical = non_work[0] if non_work else sorted(emails)[0]
        for e in emails:
            mapping[e] = canonical
    return mapping


def row_completeness(row: dict) -> int:
    """Count populated fields. Higher = more complete."""
    return sum(1 for v in row.values() if str(v).strip() not in ("", "Unknown"))


def main() -> None:
    with RAW.open(newline="", encoding="utf-8") as f:
        raw_rows = list(csv.DictReader(f))
        fieldnames = list(raw_rows[0].keys())

    # Pass 1: per-row normalization (Parts 2 + 4)
    email_map = build_email_canonical_map(raw_rows)
    norm_rows: list[dict] = []
    for r in raw_rows:
        nr = dict(r)
        nr["speaker_name"] = normalize_name(r["speaker_name"])
        nr["speaker_email"] = canonicalize_email(r["speaker_email"], email_map)
        # company: NOT cleaned (lab doesn't teach it)
        # talk_title: strip whitespace only (lab doesn't teach title cleaning)
        nr["talk_title"] = r["talk_title"].strip()
        nr["topic_tag"] = normalize_topic(r["topic_tag"])
        nr["track_preference"] = normalize_track(r["track_preference"])
        nr["session_length_min"] = str(normalize_length(r["session_length_min"]))
        nr["submission_date"] = normalize_date(r["submission_date"])
        # bio_short: NOT rewritten (data/README: "mostly fine; a few are blank")
        nr["experience_level"] = normalize_experience(r["experience_level"])
        nr["requires_av"] = normalize_av(r["requires_av"])
        norm_rows.append(nr)

    # Pass 2: collapse exact duplicates (Part 3 Step 1 final dedup)
    # An exact duplicate = all 12 columns identical case-sensitively.
    seen_keys: set[tuple] = set()
    deduped: list[dict] = []
    for r in norm_rows:
        key = tuple(r[c] for c in fieldnames)
        if key in seen_keys:
            continue
        seen_keys.add(key)
        deduped.append(r)

    # Pass 3: same speaker + same talk = duplicate submission (Part 3 Step 2).
    # Apply Part 4 Step 1 first: when session_length_min conflicts within
    # the group, "most recent submission_date wins". Then keep the most
    # complete row (Part 3 Step 2).
    by_speaker_title: dict[tuple, list[dict]] = defaultdict(list)
    for r in deduped:
        by_speaker_title[(r["speaker_name"], r["talk_title"])].append(r)

    final: list[dict] = []
    for (sname, ttitle), group in by_speaker_title.items():
        if len(group) == 1:
            final.append(group[0])
            continue
        # If session_length conflicts within the group, most recent date wins.
        lengths = {g["session_length_min"] for g in group}
        if len(lengths) > 1:
            group_sorted = sorted(group, key=lambda r: r["submission_date"], reverse=True)
            winner_length = group_sorted[0]["session_length_min"]
            group = [g for g in group if g["session_length_min"] == winner_length]
            if len(group) == 1:
                final.append(group[0])
                continue
        # Otherwise keep the most complete row, tie-break lowest submission_id.
        best = max(group, key=lambda r: (row_completeness(r), -int(r["submission_id"][-12:], 16)))
        final.append(best)

    # Sort by submission_id for stability
    final.sort(key=lambda r: r["submission_id"])

    with CLEAN.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        for r in final:
            writer.writerow(r)

    print(f"raw rows:    {len(raw_rows)}")
    print(f"after exact-dup pass: {len(deduped)}")
    print(f"clean rows:  {len(final)}")
    # Reporting
    unknown_track = sum(1 for r in final if r["track_preference"] == "Unknown")
    unknown_exp = sum(1 for r in final if r["experience_level"] == "Unknown")
    out_of_window = sum(1 for r in final if not r["submission_date"].startswith("2026"))
    dr_titled = sum(1 for r in final if r["speaker_name"].startswith("Dr. "))
    print(f"  Unknown track_preference: {unknown_track}")
    print(f"  Unknown experience_level: {unknown_exp}")
    print(f"  out-of-window dates kept: {out_of_window}")
    print(f"  Dr. titled speakers:      {dr_titled}")


if __name__ == "__main__":
    main()
