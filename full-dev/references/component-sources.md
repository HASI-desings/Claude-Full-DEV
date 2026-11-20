# Component & Motion Sources — verified catalog

Ready-made animated components save hours, and they are also the fastest way to make a site look like every other AI-built site. This file says **where** to get them, **what each is good at**, **what the license demands**, and the **adaptation rule** that makes a borrowed piece ours.

Verified November 2026 (npm registry, LICENSE files, official READMEs, web search). Licenses change: re-check the source's LICENSE before shipping anything commercial.

## The adaptation rule (non-negotiable)

A borrowed component is **raw material**, never a finished part.

1. **Concept first.** A component enters the build only if a row in `07-motion-spec.md` calls for its behaviour. Never browse a library and then look for a place to put something.
2. **Restyle to tokens.** Replace every colour, radius, shadow, font, duration and easing with our Phase 5 tokens (`var(--…)`). No hex values from the library survive.
3. **Change the signature.** Alter at least one structural thing (shape, path, direction, trigger, rhythm) so the motion expresses the two-object concept, not the library's demo.
4. **Strip what isn't specced.** Delete extra glows, gradients, particles and hover effects the spec doesn't ask for.
5. **Make it accessible.** Add `prefers-reduced-motion` handling, keyboard and focus states, and real text (not text painted only on canvas).
6. **Check it.** Run `anti-generic.md` (section "Component-library defaults"). If someone could name the library from a screenshot, it isn't adapted yet.
7. **Record it.** List source, URL, license and what changed in `docs/full-dev/07-motion-spec.md` → *Borrowed components*. Add attribution where the license requires it.

## Choosing a source

| Need | First choice | Why |
|---|---|---|
| Scroll storytelling, pinning, scrub, SVG paths, split text | **GSAP + ScrollTrigger** (code it, see `scroll-video-interaction.md`) | Most control; all plugins free |
| React UI micro-interactions (tabs, dialogs, number tickers, text effects) | Motion Primitives → Magic UI → Animata → Cult UI | MIT, shadcn-style copy-in, built on Motion |
| A specific named effect you can't find | 21st.dev (search / Magic MCP) | Largest community index; check each component's license |
| Text animations, shader/WebGL backgrounds | React Bits | Wide range, some GSAP/OGL/Three based |
| Hero spectacle (spotlights, beams, 3D cards) | Aceternity UI | Free tier, but the most recognisable look: adapt hard |
| Plain HTML/CSS buttons, loaders, toggles | Uiverse | MIT, no framework |
| Learning a technique (WebGL distortion, scroll effects) | Codrops demos, GSAP showcase, CodePen | Study, then rebuild in our language |
| 3D | Three.js / React Three Fiber + Drei | MIT; see `library/threejs/*` |
| Designer-authored 3D / vector animation | Spline, Rive, Lottie | When a designer owns the asset; check plan terms |

## Catalog

| Source | URL | License (verified) | Install | Stack | Best at | Risk / notes |
|---|---|---|---|---|---|---|
| **21st.dev** + **Magic MCP** | 21st.dev · 21st.dev/mcp | MCP code: ISC. Each component: its author's license | `npx @21st-dev/cli@latest install claude --api-key <key>` (key from 21st.dev/mcp; old Magic keys were reset). Components: shadcn registry URLs | React, Tailwind, Motion | Searching thousands of community components; generating variants inside the editor | Licenses vary per component. Treat output as a draft to adapt |
| **Aceternity UI** | ui.aceternity.com | Own "Aceternity License"; free components + paid Pro / All-Access | `npx shadcn@latest add https://ui.aceternity.com/registry/<name>.json` (Pro: token via `ACETERNITY_PRO_TOKEN`) | React, Tailwind, Motion | Hero effects, 3D cards, beams, spotlights | The most recognisable "AI landing page" look. Read the licence page before commercial use |
| **Magic UI** | magicui.design | MIT | shadcn CLI | React, TS, Tailwind, Motion | Marquee, number ticker, text animations, borders | Defaults are widely recognised. Adapt hard |
| **React Bits** | reactbits.dev | **MIT + Commons Clause** | `npx shadcn@latest add @react-bits/<Name>-TS-TW` or jsrepo | React (JS/TS, CSS/Tailwind); some GSAP, OGL, Three | Text animations, backgrounds, interactive effects | You may use components in client and commercial sites. You may **not** sell the components themselves (e.g. a template/kit built mainly from them) |
| **Motion Primitives** | motion-primitives.com | MIT | CLI or copy; needs `motion`, `lucide-react`, Tailwind | React, Tailwind, Motion | Restrained UI motion: tabs, dialogs, text effects | Low |
| **Animata** | animata.design | MIT | Copy-paste | React, Tailwind, Motion | Micro-interactions, text, cards | Low |
| **Cult UI** | cult-ui.com | MIT | shadcn CLI | React, Tailwind, Motion | Interactive components, shaders | Low |
| **Eldora UI** | eldoraui.site | MIT | shadcn CLI | React, TS, Tailwind, Motion | 150+ landing components | Low; verify the repo LICENSE |
| **Skiper UI** | skiper-ui.com | Commercial. **Free tier requires attribution**; Pro removes it | Copy | React, Tailwind, Motion | Polished product interactions | Add the credit or buy Pro |
| **Hover.dev** | hover.dev | Not verified (free + paid) | Copy | React, Tailwind, Motion | Interaction patterns | Use as reference only until terms are confirmed |
| **shadcn/ui registries** | ui.shadcn.com (Registry directory) | Per registry | `npx shadcn@latest add <url or @ns/name>` | React, Tailwind | Mixing several libraries through one CLI | Licenses differ per registry |
| **Uiverse** | uiverse.io | MIT | Copy HTML/CSS (or Tailwind) | Plain CSS | Buttons, loaders, toggles, checkboxes | Low; many are flashy by default |
| **Codrops** | tympanus.net/codrops | Demos MIT unless stated; bundled fonts/images keep their own licenses | Download the demo / GitHub | Vanilla JS, GSAP, Three, WebGL, Lenis | Learning advanced scroll, WebGL and transition techniques | Check each demo's asset licenses |
| **CodePen** | codepen.io | Public Pens are MIT by default (CodePen policy); private Pens are not | Copy | Anything | GSAP/ScrollTrigger collections, quick prototypes | Credit the author; check the Pen's own notes |
| **GSAP showcase** | gsap.com/showcase | Inspiration only | — | GSAP | Seeing what's possible, motion references | Never copy a site |
| **GSAP 3.15** | gsap.com · npm `gsap` | Standard "no charge" license: free incl. commercial, **all plugins** (ScrollTrigger, SplitText, ScrollSmoother, MorphSVG…) since Apr 2025 | `npm i gsap` · `@gsap/react` | Any | Timelines, pinning, scrub, SplitText | None |
| **Motion** 14 | motion.dev | MIT (Motion+ extras are paid) | `npm i motion` | React, JS, Vue | Springs, layout animation, gestures, scroll hooks | None |
| **Lenis** 1.3 | github.com/darkroomengineering/lenis | MIT | `npm i lenis` + `lenis/dist/lenis.css` | Any | Smooth scroll synced with ScrollTrigger | Only when the spec needs it |
| **Three.js** 0.187 · **R3F** 9 · **Drei** 10 | threejs.org · r3f.docs.pmnd.rs | MIT | `npm i three @react-three/fiber @react-three/drei` | JS / React | 3D scenes, scroll-driven 3D, shaders | Bundle size, GPU cost: lazy-load |
| **Spline** | spline.design | Runtime on npm; editor plans vary (free-plan export terms not verified) | `@splinetool/runtime` / `@splinetool/react-spline` | Web component / React | Designer-made 3D scenes | Heavy runtime; check plan for watermark/export |
| **Rive** | rive.app | Runtimes MIT; editor plans vary | `@rive-app/canvas` / `@rive-app/react-canvas` | Canvas/WebGL | Interactive vector animation with state machines | Editor pricing |
| **LottieFiles** | lottiefiles.com | `lottie-web` / `dotlottie-web` MIT; community animations under the Lottie Simple License (check each) | `@lottiefiles/dotlottie-web` | Canvas/SVG | Icon and illustration animation from After Effects | Generic community files look generic |
| **Unicorn Studio** | unicorn.studio | Not verified (free + paid plans) | Embed script | WebGL | No-code shader/WebGL scenes | Check watermark and plan terms |

## Agent skills bundled in `library/` (MIT)

| Folder | Source | Use for |
|---|---|---|
| `library/gsap/*` (8) | greensock/gsap-skills (official) | Core, timelines, ScrollTrigger, plugins, utils, React, frameworks, performance |
| `library/threejs/*` (13) | cloudai-x/threejs-skills | Fundamentals, geometry, materials, lighting, textures, loaders, animation, interaction, shaders, post-processing, R3F, asset pipeline, performance |
| `library/mengto/*` (7) | MengTo/Skills | Scroll-scrubbed sequences, cinematic GSAP + Lenis systems, horizontal scenes, word reveals, Three.js scroll worlds, progress timelines, animation performance audits |

## Attribution checklist (put in `HANDOVER.md`)
- MIT / ISC / Apache code copied into the project: keep the copyright notice in a `THIRD_PARTY_NOTICES.md` (or file header).
- Skiper UI free tier: visible credit as their terms require.
- React Bits: fine in sites; not in a resold kit.
- Codrops/CodePen: credit the author in the notices file; check bundled assets.
- Spline / Rive / Lottie / Unicorn assets: record the plan and license of each file.
