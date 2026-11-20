# Phase 4 — Concept to Experience: Architecture & Plan

Translate requirements + concept into one continuous, intentional experience, and decide how it gets built. Deliverable: `docs/full-dev/04-architecture.md` (template: `templates/04-architecture.md`). ★ Gate.

Deep dives: `library/marketing/site-architecture`, `library/pdlc/user-story-mapping`, `library/pdlc/prd-template`, `library/pdlc/edge-case-analysis`, `library/pdlc/system-decomposition`, `library/addyosmani/api-and-interface-design`, `library/addyosmani/spec-driven-development`, `library/vercel/create-a-backend`, `library/superpowers/writing-plans`, `library/addyosmani/planning-and-task-breakdown`.

## A. Experience architecture
1. Website objectives (measurable where possible)
2. Target audiences and their top tasks
3. User journeys — for each audience: entry point → key moments → conversion → what happens after
4. Sitemap (pages, hierarchy, URL slugs)
5. Required pages and sections
6. Functional components (forms, cart, auth, search, filters, booking, dashboard…)
7. Navigation model — and whether the nav itself can be part of the concept
8. Calls to action, primary and secondary, per page
9. Content hierarchy per page

**Section breakdown** — for every section on every page:
| Section | Purpose | Information | Emotion | Composition | Link to concept | Motion/interaction idea |

Every section needs a reason to exist. No padding sections to make it longer; no dropping business requirements for aesthetics.

## B. Technical architecture
Choose the **minimum stack that fits** — say why in one line each, as an ADR (`library/addyosmani/documentation-and-adrs`).

| Build type | Default stack |
|---|---|
| Marketing / brand / portfolio | Next.js (App Router, static/ISR) or Astro for content-heavy; CSS Modules or Tailwind with tokens; GSAP + ScrollTrigger + Lenis only if motion spec needs them |
| Content/CMS | Next.js + headless CMS (Sanity, Payload, Contentful) or MDX |
| E-commerce | Next.js + Shopify Storefront API / Medusa / Stripe; or Supabase + Stripe for small catalogues |
| Web app / SaaS / dashboard | Next.js + Supabase (Postgres, Auth, RLS, Storage) or Vercel serverless functions + managed DB |
| 3D-centric | add Three.js / React Three Fiber only for a concept-justified 3D element |

Plain HTML/CSS/JS is valid for a one-page site. Don't add a backend a static site doesn't need.

If there's a backend, define: data model (entities, relations), auth & roles, RLS/authorization rules, API surface (route handlers / server actions, request/response shapes, errors), integrations, env vars list (names only), caching/revalidation strategy, file storage.

Include **edge cases** that will bite real users: empty states, slow network, form errors, sold-out, unauthenticated deep links, huge text, RTL/Urdu if relevant, no-JS/reduced-motion rendering.

## C. Build plan
Break the work into small, independently verifiable tasks in build order (setup → design tokens → layout shell → sections one by one → backend features → integrations → QA). Each task: files touched, what "done" looks like, how to verify (screenshot vs design, test, command). Save as `docs/full-dev/plan.md`. Follow `library/superpowers/writing-plans` for structure on larger projects.

Present the sitemap + section table + stack + plan summary; get approval.
