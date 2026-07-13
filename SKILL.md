---
name: resume-loop
description: Full pipeline for building a tailored, print-perfect one-page resume - profile interview, HTML generation, and an automated whitespace audit loop. Use this whenever the user wants to create, tailor, update, or fix a resume or CV, mentions applying to a job or internship, uploads an old resume, complains about resume formatting/length/whitespace, or wants a "profile" for future resume generation - even if they don't say the word "resume-loop". Also use when a returning user uploads a PROFILE.md and names a target role.
---

# Resume Loop

Build resumes people are proud to send. The system has two durable ideas:

1. **A persistent profile.** One interview produces a `PROFILE.md` — the user's complete inventory of experience PLUS their personal standing rules. Every future resume is generated from it in minutes, not hours.
2. **A measured whitespace loop.** Resumes are generated as a single self-contained HTML file with an embedded audit script that reports dangling lines and page-fill %. You iterate against measurements, not eyeballs, until the page is exactly full.

## Routing

- User has a `PROFILE.md` (uploaded or in the working folder) → skip to **Phase 3**.
- User has no profile → start at **Phase 1**. Tell them the plan up front: "We'll build your profile once — then any future resume takes minutes."
- User only wants formatting fixed on an existing resume → convert it to the HTML template and run **Phase 4** directly.

## Phase 1 — Intake

Ask the user to upload their current resume (any format) and share anything else useful: LinkedIn text, GitHub/portfolio URLs, project readmes, performance reviews. Extract every fact into a draft inventory before asking a single question — never make the user retype what a document already says.

## Phase 2 — Interview → PROFILE.md

Read `references/interview.md` and run the interview. The goal is not just facts — it's the user's **personal standing rules** (what must always appear, what's banned, what needs confirming every time, how to disclose sensitive framing). Rules are what make the second resume take five minutes.

End the phase by writing `PROFILE.md`, walking the user through it section by section, and telling them to keep it: it's their asset, and they re-upload it next time. See `references/example-rules.md` for what a strong rules section looks like.

## Phase 3 — Generate

1. Confirm any facts the profile flags as volatile (graduation date, current-role end date) — every single time.
2. Ask for the target role/posting if not given; choose the framing the profile prescribes (e.g., experience-first vs projects-first).
3. Build the resume as ONE self-contained HTML file from `assets/template.html`, following the layout constants and content rules in `references/layout-and-audit.md`.

Hard defaults that apply to every user regardless of their profile:

- Exactly one printed US Letter page. Never a second page, never 101% fill.
- Never invent or round-up numbers. Quantify only what the user can defend in an interview.
- Fill the page with content, not air — add a bullet/course/project rather than inflating margins or line-height.
- Every claim traces to the profile. If it's not in `PROFILE.md`, ask before writing it.

## Phase 4 — Audit loop

Read `references/layout-and-audit.md` and run the measure→edit→re-measure loop until the audit shows **zero DANGLE/SHORT flags and 95–97% page-fill**. Three ways to read the audit, in order of preference: Claude-in-Chrome extension, headless Chromium via shell, or the user opening the `?audit` URL and pasting the report back. Do not skip the loop and do not trust visual inspection over the measurements.

## Phase 5 — Export & learn

Guide the PDF export (instructions at the end of `references/layout-and-audit.md`), deliver both the HTML and PDF, and then — important — ask what they'd change. Any correction the user makes is a candidate standing rule. Offer to append it to `PROFILE.md` so the system gets better every run.
