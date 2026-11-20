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

### Video & frame-sequence specs (scroll-scrubbed media)
| Item | Spec |
|---|---|
| Source | Shot/rendered at ≥ the largest output size, locked-off camera or smooth motion, no flicker; 4–6 s for scrub video |
| Scrub video | `tools/scroll-kit/prepare-scrub-video.sh` → all-keyframe (`-g 1`, no B-frames), no audio, `+faststart`. Desktop 1920 (or 1280) wide ≤ 6 MB; mobile 960 wide ≤ 2.5 MB; MP4 H.264 for all + WebM VP9 for Chromium/Firefox; 24–30 fps |
| Image sequence | `tools/scroll-kit/extract-frames.sh` → 60–150 frames; desktop ≤ 1600 px (~40–80 KB each), mobile ≤ 800 px; WebP q≈70 (AVIF if decode cost is tested); `manifest.json` |
| Poster | First (or most meaningful) frame as WebP/JPG at display size — it is the LCP image, the reduced-motion still and the no-JS fallback. Preload it (`fetchpriority="high"`) if it's above the fold |
| Background loop (non-scrub) | Normal encode (keyframe every ~2 s), `muted playsinline autoplay loop`, ≤ 2 MB, paused off-screen |
| 3D | GLB, Draco/Meshopt compressed, ≤ 2–3 MB; textures KTX2/WebP ≤ 2048 px; a still render for fallback |
| Alt / description | Every video/canvas gets a text alternative (`aria-label` or nearby caption); decorative ones `aria-hidden` |

## SEO & discoverability
- One H1 per page; logical heading order; descriptive slugs.
- Unique title (≤60 chars) and meta description (≤155) per page; Open Graph + Twitter cards with a designed OG image.
- Structured data (JSON-LD): Organization, WebSite, plus Product, LocalBusiness, Article, FAQ, BreadcrumbList as relevant.
- `sitemap.xml`, `robots.txt`, canonical URLs, hreflang for multilingual.
- Content readable without JS animation (SEO + reduced motion + slow devices).
- AI search: clear factual answers, entity-rich About page, FAQ content — see `ai-seo`.
- Performance is SEO: Core Web Vitals targets LCP < 2.5s, INP < 200ms, CLS < 0.1.

Present the copy deck alongside the designs so the user reviews words in context.
