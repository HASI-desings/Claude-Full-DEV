# Phase 12 — GitHub & Vercel Deployment

Ship only after QA passes. The job isn't "deployed" — it's "production verified". ★ Gate.

Deep dives: `library/vercel/deploy-to-vercel`, `library/vercel/deployments-cicd`, `library/vercel/env-vars`, `library/addyosmani/shipping-and-launch`, `library/addyosmani/ci-cd-and-automation`, `library/addyosmani/git-workflow-and-versioning`, `library/qa/release-readiness`.

## Steps
1. **Repository:** initialise git if needed; `.gitignore` covers `.env*` (except `.env.example`), `node_modules`, `.next`, `.vercel`. Review the codebase once (dead code, TODOs, console logs, leaked secrets: grep for `sk_`, `key`, `secret`, `token`).
2. **Commit & push:** meaningful commits; push to GitHub — `gh repo create` / GitHub MCP when available; otherwise ask the user to create an empty repo you can push to, or give browser upload steps.
3. **Vercel project:** Vercel MCP (`create_project`, link the GitHub repo) → or `vercel link` / `vercel` CLI → or dashboard "Import Git Repository" via browser/instructions.
4. **Environment variables:** set per environment (Production / Preview / Development) via MCP (`create_project_env`), `vercel env add`, or dashboard. Secrets marked sensitive. Never paste secrets into chat logs you commit.
5. **Deploy:** preview first; check the preview URL; then promote/deploy to production. Read build logs on failure (`get_deployment`, `get_runtime_logs`, `get_runtime_errors`).
6. **Domain:** add the custom domain (`add_project_domain`), configure DNS records, confirm HTTPS.
7. **Verify production — on the real URL:**
   - every page loads; key journeys work end to end (forms submit, auth works, payments in test/live as agreed)
   - mobile + desktop screenshots match the approved local version
   - Lighthouse on production; OG preview renders; sitemap/robots reachable
   - runtime logs clean after exercising the site
8. **Document** the deployment: repo URL, Vercel project, environments, env var *names*, domain/DNS, how to redeploy and roll back (Vercel "Instant Rollback" / promote previous deployment).

Never expose API keys, credentials or secret env vars in frontend code or public repositories.
