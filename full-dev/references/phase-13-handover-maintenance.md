# Phase 13 — Handover & Maintenance

The client should get more than a ZIP of source code. Deliverable: `HANDOVER.md` (template: `templates/HANDOVER.md`), README, ADRs, and a maintenance plan.

Deep dives: `library/addyosmani/documentation-and-adrs`, `library/vercel/verification`, `library/superpowers/systematic-debugging`, `library/vercel/cdn-caching`, `library/pdlc/caching-strategy`, `library/marketing/seo-audit`.

## Handover pack
- **README:** what the project is, stack, local setup, scripts, env var names, folder map, how to deploy.
- **ADRs** (`docs/adr/NNNN-title.md`): stack, CMS/backend, auth, animation libraries, hosting — context, decision, consequences.
- **Design system doc** + link to Figma / preview page; rules for adding new sections without breaking the concept.
- **Content guide:** how to edit content (CMS steps or file paths), image specs, alt text rules.
- **Runbook:** redeploy, roll back, rotate a secret, restore the database, who owns domain/DNS/accounts.
- **Credentials inventory:** which accounts exist and who owns them — never the secrets themselves.

## Maintenance
- **Verification-first debugging:** reproduce → trace browser → API → database with evidence → find root cause → fix → verify in production. No guess-fixes.
- **Monitoring:** Vercel Analytics/Speed Insights, error tracking (Sentry or Vercel logs), uptime checks.
- **Recurring checks** (offer to set these up as scheduled tasks if the session supports them): monthly Lighthouse + broken-link + dependency/security audit; quarterly content/SEO review; check Core Web Vitals trends.
- **Continuous improvement:** analytics-driven tweaks to conversion paths; keep new features inside the design system and concept.
