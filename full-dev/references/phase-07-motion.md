# Phase 7 — Motion Design & Interaction Planning

Animation is designed, not sprinkled. "Make it smooth and animated" is never a spec. Deliverable: `docs/full-dev/07-motion-spec.md` (template: `templates/07-motion-spec.md`) + motion references. ★ Gate.

Deep dives: `library/emil/animate`, `library/emil/choreograph`, `library/emil/find-animation-opportunities`, `library/emil/animation-performance`, `library/emil/review-animations`, `library/emil/gestures`, `library/emil/animation-vocabulary`, `library/vercel/react-view-transitions`, engine `--domain gsap`. Scroll, video, 3D and interaction: **`references/scroll-video-interaction.md`** (decision tree, budgets, recipes) + working demos in `tools/scroll-kit/`; GSAP: `library/gsap/*` (official); 3D: `library/threejs/*`; scroll systems: `library/mengto/*`. Ready-made components: **`references/component-sources.md`**.

## 1. Gate every animation (from Emil Kowalski's method)
1. **Should it animate at all?** Seen 100+×/day or keyboard-triggered → no animation. Tens/day → near-imperceptible. Occasional (modal, drawer) → standard. Rare/first-time (hero load, onboarding, success) → this is where the delight budget lives.
2. **Name its purpose:** feedback · spatial consistency · state indication · preventing a jarring change · explanation (marketing) · delight (rare moments only) · **concept expression** (the two-object behaviour). Can't name it → don't build it.
3. **Cheapest tool that works:** CSS transition → CSS `@starting-style`/keyframes → WAAPI → Motion (springs, layout, gestures) → GSAP + ScrollTrigger (scroll-scrubbed timelines, pinning, path drawing, SplitText) → Lenis (smooth scroll, only if the experience needs it) → Three.js / R3F (concept-justified 3D only).

## 2. Spec every animated element
For each section, a table with one row per moving element:

| Element | Role (lead/support/decoration) | Trigger | From | To | Duration | Delay/stagger | Easing | Scroll relation | Exit | Reduced-motion | Mobile |

Trigger = load, enter viewport (at what %), scroll-scrub (start/end positions), hover, click, drag, route change. From/To = position, scale, rotation, opacity, clip-path/mask.

### Scroll, video and interactive rows
Scroll-bound effects need more than the table above. For each one, also fill the *Scroll & video* table in the template:

| Field | Meaning | Example |
|---|---|---|
| Technique | from the decision tree in `scroll-video-interaction.md` | CSS view() · GSAP pin+scrub · video scrub · canvas sequence · Three.js · WebCodecs |
| Trigger range | start/end as `<element edge> <viewport edge>` | `top top` → `+=250%` |
| Pin | what pins and for how long (viewports, desktop / mobile) | stage, 2.5 / 1.6 |
| Scrub smoothing | `true` (none) or catch-up seconds | 0.6 |
| Snap | none / labels / progress steps | labels |
| Frames / duration | for video & sequences | 4 s @ 30 fps · 120 frames |
| Asset | file, resolution, codec, size budget, poster (Phase 8) | hero-desktop.mp4 1920 H.264 all-intra ≤ 6 MB |
| Interaction | pointer/drag/gesture mapping | tilt ±8°, damped 0.12, fine pointer only |
| Mobile | the designed alternative | vertical stack, 800 px frames |
| Reduced motion | the static state | poster frame, no pin |
| Fallback | no WebGL / no `animation-timeline` / video error | still image |

Patterns, with demos to start from: pinned storytelling, horizontal scroll, text/mask reveals, parallax depth, scroll-scrubbed video, canvas image sequences, cursor/magnetic, drag/physics, 3D tied to scroll, shared-element transitions (all in `scroll-video-interaction.md` §5).

### Borrowed components
If a row uses a library component, name it (source + component), its license, and what changes to fit the concept. A row that says only "use Aceternity spotlight" is not a spec.

## 3. Defaults that keep it feeling right
- Animate `transform` and `opacity` (and `clip-path`); never layout properties; never `transition: all`.
- Never `scale(0)` — start at 0.9–0.97 + opacity 0. Popovers scale from their trigger; modals stay centred.
- Entering/exiting → ease-out; moving on screen → ease-in-out; never ease-in on UI. Strong curves:
  `--ease-out: cubic-bezier(0.23, 1, 0.32, 1)`, `--ease-in-out: cubic-bezier(0.77, 0, 0.175, 1)`, `--ease-drawer: cubic-bezier(0.32, 0.72, 0, 1)`.
- UI durations: press 100–160ms, tooltip 125–200ms, dropdown 150–250ms, modal/drawer 200–500ms. Marketing/explanatory motion can be longer.
- Springs for drag, momentum, interruptible gestures; bounce 0.1–0.3.
- **Choreography:** one entrance per container (never animate a parent *and* stagger its children); no uniform stagger — vary it; sequence only when order carries meaning; choreography never blocks interaction; every sequence survives interruption.
- One orchestrated moment beats scattered effects. Fade-and-slide-up on every section reads as AI-generated.
- `prefers-reduced-motion`: every section renders in its final readable state; disable parallax/scrub; keep opacity fades at most.
- Budget: 60fps → 16.7ms/frame; 120Hz → 8ms. Test on a mid-range phone, not the laptop.

## 4. Pattern library (examples, use only if they serve the concept)
- **Hero:** nav drops in; main visual scales into place; headline reveals by line/word/character (split text, mask reveal); supporting text fades; CTAs enter with controlled delays.
- **Process:** an SVG path draws with scroll progress; step numbers appear as the path reaches them; content enters progressively.
- **Images:** mask/clip-path reveals; parallax at different speeds; scale/reposition tied to scroll progress.
- **Transitions:** sections linked by shared elements; backgrounds morph; an object travels between sections; type and graphics keep continuity across routes (View Transitions API / shared layout).
- **Scroll-scrubbed media:** product footage or a CG render scrubbed by scroll (`video-scrub.html` / `image-sequence-canvas.html`); a 3D object whose pose follows scroll (`scroll-3d-object.html`).
- **Chapters:** a pinned stage where a visual transforms through labelled chapters (`pinned-storytelling.html`); a horizontal track for a row-shaped collection (`horizontal-scroll.html`).

## 5. Motion references
Words can't carry complex timing. Use the motion captures from Phase 3 (`docs/full-dev/motion-refs/`). Get or make a reference: Figma prototype/Motion (read via `get_motion_context` if Figma MCP exists), After Effects export, screen recording of a reference site (record it yourself with the browser tool/GIF capture when available), or a quick prototype you build from the matching `tools/scroll-kit/` demo and show. Store references next to the spec. When implementing, compare against them frame by frame.

## 6. Present
Show the spec table per section plus a storyboard (key frames as sketches/screens) or a working prototype of the hero sequence. Get approval before implementation.
