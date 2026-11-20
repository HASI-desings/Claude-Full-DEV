# Claude Full DEV

**A single "mega skill" that turns Claude into a creative director + full-stack web developer.**
It takes a website from a vague business idea all the way to a verified production deployment, and it refuses to produce generic, template-looking AI websites.

The skill is named **`full-dev`** (Claude's skill rules don't allow the word "claude" inside a skill name).

---

## What it does

`full-dev` runs a 13-phase studio workflow with an approval gate after each phase:

| # | Phase | What Claude delivers |
|---|---|---|
| 1 | Understand the company | Researches the company and competitors, interviews you one question at a time, writes an identity & requirements doc |
| 2 | **Two-object creative concept** | Picks an identity object + an unexpected object, forces 5 connections, finds natural ones, and builds a design language and central concept from them |
| 3 | **Live inspiration research** | Actually browses Awwwards, MaxiBestOf, Muzli, Pinterest, Supahero, Recent.design and Dark Mode Design (in parallel when it can), screenshots references, and picks 5–6 elements to reinterpret, never copy |
| 4 | Architecture & plan | Sitemap, user journeys, a purpose for every section, stack choice, data model, build plan |
| 5 | Design system | Type, colour, layout, components and a signature brand element, backed by a bundled design-intelligence engine (194 palettes, font pairings, 130 UX rules, GSAP presets) |
| 6 | Visual design | 6–7 genuinely different hero explorations, rendered, then every section designed |
| 7 | Motion design | Spec for each animated element (trigger, from/to, duration, easing, reduced motion, mobile), following Emil Kowalski's motion rules |
| 8 | Content & SEO | Real copy, metadata, JSON-LD, asset list |
| 9 | Development | Next.js (or the leanest fitting stack), built section by section and compared against the design after each one |
| 10 | Refinement & mobile | Screenshot-driven fixes; mobile layouts designed for mobile, not shrunk from desktop |
| 11 | QA | Visual, functional, motion, accessibility (WCAG 2.2 AA), performance, SEO and security, with evidence for each |
| 12 | GitHub + Vercel | Push, deploy, set env vars and domain, then verify on the live URL |
| 13 | Handover & maintenance | README, ADRs, runbook, monitoring, recurring checks |

Running through all of it: an **anti-generic checklist** (the current "AI-made website" tells) and a set of **continuous innovation** questions that challenge the first idea at every phase.

### It uses everything Claude has
The skill detects which tools the session has and uses them to do the legwork itself:

- **Web search & fetch** for references and live docs
- **A browser** (Claude in Chrome / built-in / Playwright) to visit inspiration sites, screenshot references, test the build on mobile sizes and read console errors
- **Figma MCP** to read your designs exactly, or to create the design system and hero frames itself
- **Subagents** for parallel research and fresh-eyes QA
- **Artifacts** for inspiration boards, hero options and design-system previews
- **Vercel MCP / CLI** to deploy and read logs, **Supabase MCP** for schema and RLS, **GitHub** to push

Each capability has a fallback (for example, a phone-only user without a terminal gets complete files at exact paths).

---

## Install

### Claude app (claude.ai / desktop / mobile)
1. Download **`full-dev.zip`** from this repo (tap it → Download).
2. In Claude's **Settings**, open the **Skills** section (easiest on the web) and **upload** `full-dev.zip`.
3. Make sure **code execution / file creation** is on, so the bundled design engine can run.
4. Optional but recommended: connect **Figma, Vercel, Supabase and GitHub** connectors, and Claude in Chrome.

### Claude Code
```bash
# personal (all projects)
git clone https://github.com/HASI-desings/Claude-Full-DEV.git /tmp/cfd && cp -r /tmp/cfd/full-dev ~/.claude/skills/full-dev

# or per project (version-controlled with the code)
mkdir -p .claude/skills && cp -r /tmp/cfd/full-dev .claude/skills/full-dev
```
Restart Claude Code; the skill shows up as `full-dev`.

---

## How to use

Start a project:
> Use full-dev. I want a website for **[company]**. They do **[what]** for **[who]**. Here's their current site / Instagram: …

Jump into one phase:
> full-dev: run the two-object concept for my streetwear brand.
> full-dev: find inspiration on Awwwards and Supahero for a dark, mechanical fintech hero.
> full-dev: build a motion spec for this hero (Figma link).
> full-dev: QA and deploy this repo to Vercel.

Claude keeps every deliverable in `docs/full-dev/` in your project, so any later session picks up where the last one stopped.

---

## What's inside

```
full-dev/
├── SKILL.md                 ← orchestrator: pipeline, gates, working rules
├── references/              ← one playbook per phase + toolkit + anti-generic + innovation
├── templates/               ← identity, concept, reference analysis, architecture,
│                              design system, motion spec, QA report, handover
├── tools/ui-ux-pro-max/     ← searchable design data + Python CLI (no dependencies)
└── library/                 ← 67 original specialist skills (as GUIDE.md), see library/INDEX.md
LICENSES/                    ← licenses of every included source
full-dev.zip                 ← ready-to-upload skill package
```

## Credits

Built on the creative workflow by **Hussnain Sohail (HASI Designs)**, merged with these open-source skills (licenses in `LICENSES/`):

| Source | License | Used for |
|---|---|---|
| [obra/superpowers](https://github.com/obra/superpowers) | MIT | Brainstorming, plans, TDD, debugging, verification |
| [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | MIT | Interviews, specs, frontend engineering, perf, a11y, security, ADRs, shipping |
| [mattpocock/skills](https://github.com/mattpocock/skills) | MIT | Grilling, domain modelling |
| [sethdford/claude-skills](https://github.com/sethdford/claude-skills) (PDLC) | MIT | Feasibility, PRD, story mapping, edge cases, system design |
| [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | MIT | Design-intelligence engine |
| [anthropics/skills](https://github.com/anthropics/skills) | Apache-2.0 | Frontend design, webapp testing |
| [emilkowalski/skills](https://github.com/emilkowalski/skills) | MIT | Animation and design engineering |
| [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills) | MIT | Copy, SEO, schema, site architecture |
| [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | MIT | React best practices, web interface guidelines, deploy |
| [vercel/vercel-plugin](https://github.com/vercel/vercel-plugin) | Apache-2.0 | Backend, env vars, CI/CD, verification, CDN caching |
| [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) | Apache-2.0 | Browser automation |
| [petrkindlmann/qa-skills](https://github.com/petrkindlmann/qa-skills) | MIT | Accessibility, visual, performance, security and E2E testing |

Original guides are included unmodified except that `SKILL.md` was renamed to `GUIDE.md` and internal links were updated to match.
