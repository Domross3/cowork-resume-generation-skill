# The Profile Interview

Purpose: turn an uploaded resume plus one conversation into a `PROFILE.md` that is (a) a complete, verified inventory of everything the user could ever put on a resume, and (b) a set of personal standing rules that make every future resume fast and consistent.

Run this as a conversation, not a form. Use the AskUserQuestion tool where the client supports it for discrete choices; use open chat for stories. Batch questions — never more than one round per topic. The user already uploaded materials in Phase 1; only ask about what the documents don't answer.

## 1. Targets first

What roles/industries are they applying to over the next year? One kind of role or several? This decides whether the profile needs multiple framings (e.g., a technical-led ordering vs a business-led ordering) and which details are worth deep-mining.

## 2. Expand every experience

For each job, project, and activity in the inventory, dig for what the original resume left out. The old resume is a floor, not a ceiling. Useful probes:

- "Walk me through what you actually did here — what would your manager say you did?"
- "Is there a number you can defend in an interview? Time saved, money, users, records, people led, percent improvement?" If they can't defend it, don't record it. Record defensible numbers WITH their provenance (e.g., "confirmed $5,500 grant — old '$500' figure outdated") so future generations never regress to stale figures.
- "What's the story behind this — a failure you diagnosed, a decision you made?" Stories become interview ammunition and differentiated bullets.
- "What are the caveats?" (no tests, single user, prototype-only). Record caveats explicitly — they define the boundary of honest quantification.

Also mine for what's missing entirely: coursework, certifications, programs, awards, leadership, side projects. The whitespace loop later NEEDS surplus content — a good profile holds roughly two resumes' worth.

## 3. Elicit standing rules

This is the heart of the profile. Interview for each category (see `example-rules.md` for a worked example of the output):

- **Mandatory items** — "What must appear on every resume no matter the role?" Push for exact phrasing rules (e.g., a program name that must always be written out in full, never the acronym).
- **Banned items** — "Anything you never want listed?" (lapsed certifications, discontinued projects, spoken languages, dead skills). Record the WHY so future sessions don't relitigate.
- **Volatile facts** — anything that changes or is undecided (graduation date, end dates, GPA). Mark these "confirm every time."
- **Disclosure rules** — anything where honest framing matters and the user has a considered position: AI-assisted work, team vs solo contributions, in-progress items. Get the exact framing they're comfortable with and write it down. Example: a user who architects projects but has AI agents write most implementation code may want a hands-on vs agent-directed skills split on every resume — that's a rule, not a per-resume decision.
- **Space allocations** — flagship items that deserve emphasis ("this program always gets its own bullet"), caps ("no project may take more space than X"), and one-liners ("this job is one line max").
- **Framings** — if they target multiple role types, define each variant (what leads, what's cut) and when to use it.
- **Voice** — tone preferences, capitalization conventions, formatting tics.

## 4. Write PROFILE.md

Structure:

```markdown
# <Name> — Master Profile (for resume generation)
Source of truth compiled <date> from <sources>.

## Contact
## Education   (+ full course/certification inventory if relevant)
## Work Experience   (every role, every defensible bullet, provenance notes inline)
## Projects   (with caveats recorded)
## Leadership & Activities
## Skills
## Resume-generation rules (standing)
1. ...numbered, imperative, specific...
```

Walk the user through the draft section by section and get explicit sign-off on the rules. Then tell them: **"Keep this file. Next time, upload it and name the role — that's all I need."** If a memory directory or persistent folder is available, offer to store it there too.

## 5. Keep it alive

The profile is living. Whenever a later session surfaces a correction, new job, or new preference, offer to update `PROFILE.md` immediately — with a dated provenance note where a fact changed.
