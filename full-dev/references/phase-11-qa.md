# Phase 11 — Quality Assurance

Do not declare the site complete while critical issues remain. Every check produces evidence. Deliverable: `docs/full-dev/qa-report.md` (template: `templates/qa-report.md`). ★ Gate.

Deep dives: `library/anthropic/webapp-testing` (Playwright helper scripts), `library/vercel/agent-browser`, `library/qa/playwright-automation`, `library/qa/accessibility-testing`, `library/qa/visual-testing`, `library/qa/performance-testing`, `library/qa/security-testing`, `library/qa/cross-browser-testing`, `library/qa/exploratory-testing`, `library/qa/release-readiness`, `library/vercel/web-design-guidelines`, `library/superpowers/verification-before-completion`. For independent judgement on high-stakes projects, have a fresh subagent that didn't build it run the review.

## Tooling (use what exists, in this order)
1. **Browser tools** (Chrome / built-in / cloud browser): click through every journey, screenshot each page at mobile + desktop, read console and network errors.
2. **Playwright** (terminal): scripted journeys, screenshots, `@axe-core/playwright` scans, visual snapshots. `library/anthropic/webapp-testing/scripts/with_server.py` starts the dev server for a test run.
3. **Lighthouse** (`npx lighthouse <url> --view` or PageSpeed Insights via fetch) for performance, accessibility, SEO, best practices.
4. **Vercel Web Interface Guidelines** — fetch the live rules (URL in `library/vercel/web-design-guidelines/GUIDE.md`) and review the code against them, reporting `file:line` findings.
5. **Supabase advisors** (`get_advisors`) for security/performance of the database, if used.

## Checklist
**Visual** — matches approved design? concept recognisable? typography consistent? colours exact? sections connected? feels original (run `references/anti-generic.md` once more)?

**Functional** — every link, button, form (validation, success, failure, spam protection), navigation, auth flow, payment flow (test mode), 404/500 pages, no console errors.

**Motion** — smooth on a mid-range device, no glitches or flashes on load, transitions correct when interrupted, scroll triggers in sync after resize/refresh, reduced-motion renders everything readable.

**Technical**
- Responsive at all Phase 10 sizes; no horizontal overflow
- Accessibility: WCAG 2.2 AA — automated scan clean, plus manual keyboard-only pass and a screen-reader spot check (automated tools catch only ~30–40%)
- Performance: LCP < 2.5s, INP < 200ms, CLS < 0.1; JS budget sensible; images optimised; fonts subset
- SEO: titles, descriptions, OG, JSON-LD validates, sitemap, robots, canonicals
- Security: no secrets in client bundle or repo (search the build output), env vars correct per environment, security headers, RLS on, server-side validation, dependency audit (`npm audit`)
- No broken routes; production build (`next build`) passes with no type errors

## Report
For each issue: severity (critical / major / minor), where, evidence (screenshot/log), fix, re-verified ✓. Fix criticals and majors, re-run the affected checks, then present the report.
