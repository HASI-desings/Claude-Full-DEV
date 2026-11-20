# Phase 8 — Content, Copy, Assets & SEO

Copy can make a design feel as templated as the design itself. Real words go in before development finishes. Deliverable: page-by-page copy deck, metadata, schema plan, asset list. ★ Gate.

Deep dives: `library/marketing/copywriting`, `library/marketing/copy-editing`, `library/marketing/content-strategy`, `library/marketing/product-marketing`, `library/marketing/seo-audit`, `library/marketing/ai-seo`, `library/marketing/schema`, `library/marketing/site-architecture`, `library/marketing/competitor-profiling`.

## Copy
- Write from the visitor's side, in plain, specific language. Name things by what users understand, not how the system works.
- Headlines say something only this company could say. Test: swap in a competitor's name — if it still works, rewrite.
- CTAs say exactly what happens ("Book a fitting", not "Submit"); an action keeps its name through the flow (Publish → "Published").
- Errors explain what happened and how to fix it; empty states invite the next action.
- Sentence case, active voice, no filler, tone matched to the identity doc.
- Never invent testimonials, stats, awards or client names. Use clearly marked placeholders and list what the client must supply.
- Bilingual/RTL sites (e.g. Urdu/Arabic): plan both versions and the language switch now.

## Assets
List every image, video, illustration, icon, 3D model and font needed per section: source (client shoot, commissioned, licensed stock, generated, built in code), dimensions/ratio, format (AVIF/WebP, MP4/WebM, SVG, GLB), budget in KB, alt text. Prefer assets built in code (SVG, CSS, canvas) when they express the concept. Never use photos of real people or brands you have no rights to.

## SEO & discoverability
- One H1 per page; logical heading order; descriptive slugs.
- Unique title (≤60 chars) and meta description (≤155) per page; Open Graph + Twitter cards with a designed OG image.
- Structured data (JSON-LD): Organization, WebSite, plus Product, LocalBusiness, Article, FAQ, BreadcrumbList as relevant.
- `sitemap.xml`, `robots.txt`, canonical URLs, hreflang for multilingual.
- Content readable without JS animation (SEO + reduced motion + slow devices).
- AI search: clear factual answers, entity-rich About page, FAQ content — see `ai-seo`.
- Performance is SEO: Core Web Vitals targets LCP < 2.5s, INP < 200ms, CLS < 0.1.

Present the copy deck alongside the designs so the user reviews words in context.
