# Phase 9 — Development & Implementation

Build faithfully to the approved design, in controlled stages. Deliverable: a working codebase, verified section by section.

Deep dives: `library/addyosmani/incremental-implementation`, `library/addyosmani/frontend-ui-engineering`, `library/vercel/react-best-practices`, `library/vercel/composition-patterns`, `library/superpowers/test-driven-development`, `library/addyosmani/security-and-hardening`, `library/addyosmani/performance-optimization`, `library/addyosmani/accessibility-engineering`, `library/vercel/create-a-backend`, `library/addyosmani/git-workflow-and-versioning`, `library/superpowers/systematic-debugging`.

## 0. Kick-off
Before any code: inspect the approved design (Figma via MCP, or the Phase 6 prototypes), the design system, motion spec and plan. Post a short implementation plan (stack, folder structure, build order, libraries and why each is needed). Fetch current docs for any library whose API you're unsure of (Next.js, GSAP, Lenis, Three.js, Supabase) — don't code from stale memory.

Commitments, stated to yourself:
- Do not simplify complex visuals into generic components.
- Do not invent new design directions or swap the concept for a template.

## 1. Project setup
- Next.js (App Router, TypeScript) is the default when the project benefits from React, SEO and routing; otherwise the Phase 4 choice.
- Tokens from Phase 5 → `styles/tokens.css` (+ Tailwind theme if used). Fonts via `next/font` (self-hosted, `display: swap`, subset).
- Structure by feature/section: `app/`, `components/sections/<Section>/`, `components/ui/`, `lib/`, `styles/`, `public/`. Small focused files.
- Install only what the motion spec and features require. GSAP plugins registered once; Lenis wired to ScrollTrigger if both are used.
- `.env.example` with names only; `.env.local` git-ignored.

## 2. Build loop — one section at a time
For each section in plan order:
1. Build structure + static styling with real copy and tokens.
2. Make it responsive (mobile composition from Phase 6/10).
3. Add its motion per the spec. Never animate the whole site in one pass.
4. **Verify:** run it, screenshot desktop + mobile, compare side by side with the design (and the motion reference); check timing, scroll positions, reduced-motion state, keyboard focus, console errors.
5. List visible differences, fix them, re-screenshot. Only then move on.
6. Commit with a clear message.

No browser available? Ask the user for screenshots/recordings at each checkpoint, or deploy preview builds and verify via fetch.

## 2b. Heavy effects (scroll-scrub, video, canvas, WebGL)
Start from the matching `tools/scroll-kit/` demo and `references/scroll-video-interaction.md`. Order inside the section's build loop:
1. **Static first** — final-state layout with real copy, the poster/still in place, correct on mobile and with JS off. This is also the reduced-motion version.
2. **Motion** — entrance and hover motion from the spec.
3. **Scrub / pin / 3D** — the scroll-bound layer last, behind `gsap.matchMedia()` (desktop / mobile / reduced-motion conditions) or `@supports (animation-timeline: view())`.

Rules:
- **Lazy-load the heavy parts:** dynamic-import Three.js/R3F, Lenis and big GSAP plugins only in the components that use them (`next/dynamic` with `ssr: false` for WebGL); start loading when the section is ~1 viewport away (IntersectionObserver `rootMargin`); fetch scrub video/frames only then, poster before.
- **One loop:** drive Lenis from `gsap.ticker`; don't run separate rAF loops per effect; render WebGL on demand.
- **Borrowed components:** install via the source's CLI into `components/ui/`, then adapt per `component-sources.md` before the section is reviewed. Keep license notices in `THIRD_PARTY_NOTICES.md`.
- **Cleanup on route change / unmount:** `useGSAP()` or `gsap.context().revert()`; `mm.revert()`; kill ScrollTriggers you created; `gsap.ticker.remove()` + `lenis.destroy()`; cancel rAF; disconnect observers; remove listeners; `URL.revokeObjectURL`; dispose Three.js geometry/materials/textures/renderer. Then `ScrollTrigger.refresh()` once on the new page.
- **Verify like the kit:** screenshots at 0/50/100% of each scroll effect on desktop and 390 px, reduced-motion pass, console clean.

## 3. Logic & backend
- Test-first for real logic (pricing, cart, auth rules, data transforms, API handlers): failing test → minimal code → pass → refactor.
- Server-side validation on every input (zod or similar); never trust the client.
- Supabase: migrations in files, RLS on every table, typed client, least-privilege keys server-side only. Vercel functions/route handlers for secrets-bearing calls.
- Handle loading, empty, error and success states for every async UI.

## 4. Quality rules while building
1. Follow the design system — no hard-coded colours/sizes.
2. Reusable components; clean, maintainable architecture.
3. Responsive layouts; no horizontal overflow.
4. Optimised images (`next/image`, AVIF/WebP, explicit sizes, lazy below the fold, priority for LCP).
5. Minimal dependencies; dynamic-import heavy libs (Three.js) only where used.
6. Accessible: semantic HTML, labels, focus states, keyboard paths, ARIA only when needed, contrast.
7. SEO fundamentals from Phase 8 (metadata API, JSON-LD, sitemap, robots).
8. Respect `prefers-reduced-motion`; animations never block content or interaction.
9. No layout shift (reserve space); no excessive GPU work (cap blur, limit concurrent WebGL, pause off-screen).
10. Every button, link and form actually works.
11. Secrets never in client code (`NEXT_PUBLIC_` only for public values).

## 5. Explain as you go
After each section, give the user a short section-by-section explanation of what was built and why (structure, styling approach, motion technique), so they understand their codebase. Not line by line.

## 6. Delivering without a terminal
If the user can't run commands, deliver complete files at exact repo paths (not diffs), keep the structure simple, and give the exact browser steps (GitHub web upload / Vercel import) to see it live.
