# Phase 6 — Visual Design & Prototyping

Design every page and important section before building. Deliverable: high-fidelity designs (Figma frames, or HTML/artifact prototypes) for all pages, desktop + mobile for key sections. ★ Gate on the hero, then on the full set.

Deep dives: `library/anthropic/frontend-design`, `library/emil/emil-design-eng`, `library/emil/apple-design`, `library/addyosmani/frontend-ui-engineering`.

## 1. Hero first — 6–7 genuinely different explorations
Explore across these categories (categories, not templates):
1. Typography-led
2. Image/photography-led
3. Object-led (a concept object, real or abstract)
4. Interactive (cursor, drag, input-driven)
5. 3D (only if the concept earns it)
6. Editorial (magazine-like composition)
7. Experimental (break a convention on purpose)

Use the Supahero/Awwwards research from Phase 3. For each exploration: a name, one sentence of intent, how it expresses the two-object concept, a rendered sketch, and its risk (performance, clarity, accessibility, mobile).

**Render them** — don't just describe: Figma frames via MCP, or quick static HTML using the real tokens and real copy, shown side by side (artifact/design canvas when available). Low fidelity is fine; real proportions and type are not optional.

Recommend the strongest one, say why it communicates the company best, and let the user pick or combine. ★

## 2. The rest of the site
Design remaining sections in sitemap order, keeping the system consistent while giving each section its own personality. Design states too: hover/focus/active, empty, loading, error, success.

## 3. Rules
1. No generic templates; no predictable industry conventions.
2. Avoid unnecessary gradients and decorative glows.
3. No random 3D objects without conceptual justification.
4. Avoid excessive cards and rounded containers.
5. Negative space is intentional, not leftover.
6. Strong typography and clear hierarchy — one lead element per screen.
7. Each section has its own personality within the system.
8. The two-object language runs through everything.
9. Originality, clarity and usability — together.
10. Spend boldness in one place per view; keep the rest disciplined. Before finishing a frame, remove one accessory.

Run `references/anti-generic.md` on each page before presenting.

## 4. Self-critique loop
Screenshot (or render) every design you make and look at it before showing it. Ask: does this look like it could belong to any company in this industry? Is the concept recognisable? Is the hierarchy obvious in 3 seconds? Is the CTA findable? Fix, then present.

## 5. Mobile frames
For each key section, design the mobile composition explicitly (often re-ordered, re-cropped, simplified motion) — see Phase 10. Never just scale desktop.

## 6. With Figma
If the user designs in Figma themselves, read their frames with `get_design_context` / `get_screenshot` / `get_variable_defs`, critique against concept + rules, and suggest specific changes. If Claude designs, create frames with `use_figma` on top of the Phase 5 variables and components.
