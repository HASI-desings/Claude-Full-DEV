# Phase 1 — Understand the Company

Goal: know what you're designing *for* before thinking about how it looks. Deliverable: `docs/full-dev/01-identity.md` (template: `templates/01-identity.md`). ★ Gate: user approves.

Deep dives: `library/superpowers/brainstorming`, `library/addyosmani/interview-me`, `library/mattpocock/grilling`, `library/pdlc/opportunity-assessment`, `library/pdlc/competitive-landscape`, `library/marketing/product-marketing`.

## 1. Look before you ask
- Read everything the user gave (brief, links, existing site, socials, files, earlier docs). If they named the company, **research it**: web search the name, fetch their current site and socials, find 3–5 direct competitors and fetch their sites. Note what each competitor communicates and what they all look like (the industry cliché you must avoid).
- Never ask what the material already answers.

## 2. Interview — one question at a time
Write a one-line hypothesis of what they want + a confidence %. Ask the single question whose answer would change the build most, with your guess attached:

```
Q: <one focused question>
MY GUESS: <your hypothesis and why>
```

Stop asking at ~90% confidence; propose sensible defaults for the rest, stated out loud.

Territory to cover (not a script — never read it out):
1. What the company actually does, and the problem it solves
2. Who the customers are (be specific: age, context, budget, device)
3. What makes it different from competitors
4. Emotions a visitor should feel; the impression the site must leave
5. The primary action(s) a visitor should take
6. Short- and long-term ambitions
7. Functional requirements (shop, booking, auth, CMS, dashboard, i18n/RTL, payments, forms…)
8. What the site must communicate that competitors fail to
9. Constraints: deadline, budget, hosting, existing brand assets, who maintains it
10. Anti-goals: what would make it a failure even if it technically works

## 3. Avoid the literal translation
Industry ≠ visuals. A tech company doesn't need circuit boards; construction doesn't need buildings; fashion doesn't need models; finance doesn't need charts. Write down the clichés of this industry explicitly so Phases 2–6 can avoid them.

## 4. Feasibility pass (quick)
Flag anything risky now: missing content/photography, integrations that need paid APIs, unrealistic timelines, legal (payments, privacy, accessibility law). Classify the build: **marketing site**, **content/CMS site**, **e-commerce**, **web app/SaaS**, or hybrid — it decides Phase 4.

## 5. Write the identity doc
Personality (3–5 adjectives *with* their opposites they must not become), positioning statement, audience, emotional goals, primary/secondary actions, requirements list (MoSCoW), clichés to avoid, open questions. Keep it to ~1–2 pages. Mark everything you inferred as **[proposal]**.

Present it, ask what's wrong or missing, revise, get approval.
