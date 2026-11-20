# Phase 7 — Motion Design & Interaction Planning

Animation is designed, not sprinkled. "Make it smooth and animated" is never a spec. Deliverable: `docs/full-dev/07-motion-spec.md` (template: `templates/07-motion-spec.md`) + motion references. ★ Gate.

Deep dives: `library/emil/animate`, `library/emil/choreograph`, `library/emil/find-animation-opportunities`, `library/emil/animation-performance`, `library/emil/review-animations`, `library/emil/gestures`, `library/emil/animation-vocabulary`, `library/vercel/react-view-transitions`, engine `--domain gsap`.

## 1. Gate every animation (from Emil Kowalski's method)
1. **Should it animate at all?** Seen 100+×/day or keyboard-triggered → no animation. Tens/day → near-imperceptible. Occasional (modal, drawer) → standard. Rare/first-time (hero load, onboarding, success) → this is where the delight budget lives.
2. **Name its purpose:** feedback · spatial consistency · state indication · preventing a jarring change · explanation (marketing) · delight (rare moments only) · **concept expression** (the two-object behaviour). Can't name it → don't build it.
3. **Cheapest tool that works:** CSS transition → CSS `@starting-style`/keyframes → WAAPI → Motion (springs, layout, gestures) → GSAP + ScrollTrigger (scroll-scrubbed timelines, pinning, path drawing, SplitText) → Lenis (smooth scroll, only if the experience needs it) → Three.js / R3F (concept-justified 3D only).

## 2. Spec every animated element
For each section, a table with one row per moving element:

| Element | Role (lead/support/decoration) | Trigger | From | To | Duration | Delay/stagger | Easing | Scroll relation | Exit | Reduced-motion | Mobile |

Trigger = load, enter viewport (at what %), scroll-scrub (start/end positions), hover, click, drag, route change. From/To = position, scale, rotation, opacity, clip-path/mask.

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

## 5. Motion references
Words can't carry complex timing. Get or make a reference: Figma prototype/Motion (read via `get_motion_context` if Figma MCP exists), After Effects export, screen recording of a reference site (record it yourself with the browser tool/GIF capture when available), or a quick CodePen-style prototype you build and show. Store references next to the spec. When implementing, compare against them frame by frame.

## 6. Present
Show the spec table per section plus a storyboard (key frames as sketches/screens) or a working prototype of the hero sequence. Get approval before implementation.
