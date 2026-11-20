# Phase 3 — Live Inspiration & Creative Research

You don't remember what's on Awwwards this month, so go and look. Claude does the browsing a human designer would. Deliverable: `docs/full-dev/03-inspiration.md` + an inspiration board (artifact / HTML / Figma page). Template: `templates/03-reference-analysis.md`. ★ Gate.

## Step 1 — Research brief (write it first, 10 lines max)
From the identity doc and the approved concept:
- **Industry terms** (and the clichés to avoid)
- **Mood terms** (3–5 personality adjectives)
- **Concept terms** — the two objects and their design-language words (e.g. "layered", "mechanical", "translucent", "organic grid")
- **Needed pieces** — nav, hero, product/service showcase, process, gallery, pricing, footer, page transitions, mobile menu…
- **Interaction ambitions** — scroll storytelling, 3D object, cursor play, text reveals, horizontal scroll…
- Dark or light leaning

Search with *concept and mood terms first*, industry terms second. The best references for a fintech built on "mechanical clock" might be a watchmaker's site, not a bank.

## Step 2 — Sources and how to query them

| Source | URL | What to mine | How Claude gets in |
|---|---|---|---|
| Awwwards | https://www.awwwards.com/ (`/websites/`, category pages, Sites of the Day) | Exceptional interaction, animation, technical execution | Web search `site:awwwards.com/sites <terms>`; fetch the `/sites/<name>` page for credits, tags, tech; open the live site in a browser |
| MaxiBestOf | https://maxibestof.one/ | Browse by industry, section type, typography, visual style | Browser (JS filters) or web search `site:maxibestof.one <terms>` |
| Muzli | https://muz.li/ (and its search) | Fresh ideas, trends, collections | Web search `site:muz.li <terms>`; fetch collection posts |
| Pinterest | https://www.pinterest.com/search/pins/?q=<terms> | Materials, textures, photography, architecture, industrial design, fashion — **not just websites**; the two objects themselves | Browser (often needs the user's login — ask, never bypass); `image_search` as fallback |
| Supahero | https://www.supahero.io/ | Hero-section patterns — feeds the 6–7 hero explorations in Phase 6 | Browser/fetch the gallery |
| Recent.design | https://recent.design/ | Contemporary web, motion, 3D, branding | Fetch/browse |
| Dark Mode Design | https://www.darkmodedesign.com/ | Contrast, light, depth, glow, dark composition | Fetch/browse (essential if dark leaning) |

Optional extra sources when coverage is thin: Godly (godly.website), Siteinspire, Land-book, Lapa Ninja, One Page Love, CSS Design Awards, Mobbin (app UI). Verify each loads before relying on it.

### Motion & component sources (for the *interaction ambitions* in the brief)
Use these to find **how** an effect is built and what it feels like in motion. Full catalog, licenses and the adaptation rule: `references/component-sources.md`.

| Source | URL | What to mine | How Claude gets in |
|---|---|---|---|
| Codrops | https://tympanus.net/codrops/ (demos hub) | Scroll, WebGL, distortion, page-transition techniques with source | Web search `site:tympanus.net/codrops <effect>`; open the demo live; read its GitHub repo |
| GSAP showcase | https://gsap.com/showcase/ | Production sites using ScrollTrigger, pinning, SplitText | Browse; open the live site and record its scroll |
| CodePen | https://codepen.io/search/pens?q=<effect> | Small isolated prototypes (ScrollTrigger, Lenis, canvas, shaders) | Web search `site:codepen.io <effect> gsap`; open in a browser |
| 21st.dev | https://21st.dev | Community React components by effect name | Search the site or the Magic MCP if connected (`claude-toolkit.md`) |
| Motion examples | https://motion.dev/examples | Springs, layout, gestures, scroll hooks in React | Fetch/browse |
| Three.js examples · R3F/Drei | https://threejs.org/examples/ · https://drei.docs.pmnd.rs | 3D techniques (materials, post, scroll cameras) | Browse; read the example source |
| Spline · Rive · LottieFiles · Unicorn Studio communities | spline.design/community · rive.app/community · lottiefiles.com · unicorn.studio | Designer-made 3D, state-machine and shader scenes | Browse; check license/plan before suggesting one |

Treat these like the inspiration sites: one element, reinterpreted, never a copied component.

## Step 3 — Execute (parallel when possible)
- **With subagents:** dispatch one per source (or per 2 sources) with the research brief and this return format: *8 candidates → URL, site name, the single strongest element, why it fits the brief, 1-line risk (cliché? heavy? inaccessible?)*. Merge, dedupe, rank.
- **Without:** run 2–3 searches per source yourself, same format.
- **Visit the top 12–15 live** in a browser when available: screenshot the hero (desktop + mobile width), scroll and screenshot key sections, note motion (what moves, trigger, timing, easing feel). Record a GIF/scroll capture for motion you may want to reproduce. Check the console for the stack when relevant (GSAP, Three.js, Lenis, Webflow…).
- **Motion reference capture** (for every scroll or interaction effect you might use): record the behaviour, don't describe it. With a browser tool: GIF/screen recording while scrolling at a steady pace top→bottom and back up. With Playwright: `recordVideo` on the context, scroll in steps, or screenshots at 0/25/50/75/100% of the effect's scroll range. Note per capture: trigger point (% of viewport), scroll distance the effect lasts (in viewports), what is pinned, easing feel, what happens on mobile and with reduced motion (emulate both). Save to `docs/full-dev/motion-refs/<name>.(gif|webm|png)` and link it from `03-inspiration.md`. No tool? Ask the user for a phone screen recording.
- Also run the Pro Max engine (`tools/ui-ux-pro-max`, see Phase 5) with `--design-system` for this product type — not to follow it, but to see the *conventional* answer you are deliberately departing from.

## Step 4 — Select 5–6 references, one element each
Never copy a whole site. Take one element from each, e.g.:
navigation from A · hero composition from B · typography treatment from C · scroll interaction from D · product presentation from E · footer or page transition from F.

For each selected reference write:
1. **What we like**
2. **The specific element we're learning from**
3. **Why it suits our concept** (tie to the two objects)
4. **How we reinterpret it** — what changes so it becomes ours

Every element must bend to the two-object concept. If it doesn't fit the concept, drop it no matter how good it is.

## Step 5 — Inspiration board
Present a board: concept summary at top, then each reference with link, a short description in your own words, the element taken, and the reinterpretation. Add a strip of material/texture/object references from Pinterest/image search. Screenshots of other sites are for private study only — link to sources, don't republish their assets.

Ask the user which references excite them and which feel wrong, revise, get approval.

## Rules
- Never copy layouts, code, copy or assets. Learn the principle, rebuild it in our language.
- Prefer recent work (last 1–2 years) for trend awareness, but timeless craft beats trendy.
- Note performance/accessibility red flags of references so you don't inherit them.
- Figma replication training (screenshot → Figma at low opacity → rebuild spacing/type/proportions) is for *learning* a pattern, never for producing a client's final design. With Figma MCP you can set this up for the user.
