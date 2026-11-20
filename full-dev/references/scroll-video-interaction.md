# Scroll, Video & Interaction — techniques and recipes

How to build scroll animation, scroll-scrubbed video, canvas sequences, 3D tied to scroll and rich interaction, fast, accessible and on mobile. Used in Phase 7 (spec), 8 (assets), 9 (build), 10–11 (QA). Working demos: `tools/scroll-kit/` (see its README). Deep dives: `library/gsap/*`, `library/threejs/*`, `library/mengto/*`, `library/emil/*`.

Every effect here serves an approved row in the motion spec. None of it is a reason to add motion.

## 1. Decision tree — pick the cheapest tool that works

```
Is the motion tied to scroll position?
├─ No → hover/press/enter/route?
│   ├─ simple state change ............ CSS transition / @starting-style
│   ├─ springs, layout, gestures ...... Motion (React) / WAAPI
│   └─ multi-step sequence ............ GSAP timeline
└─ Yes
    ├─ reveal / progress / parallax, no pinning, no JS logic needed
    │   └─ CSS animation-timeline: scroll() / view()   (fallback = final state)
    ├─ pinning, chapters, snapping, horizontal track, SplitText, SVG path draw
    │   └─ GSAP ScrollTrigger (+ Lenis only if the spec asks for smooth scroll)
    ├─ footage that must play forward/back with scroll
    │   ├─ ≤ 6 s clip, size budget OK ...... <video> scrub, all-keyframe encode
    │   ├─ frame-exact, iOS-critical, ≤150 frames .. canvas image sequence
    │   └─ long/HD, Chromium-first ......... WebCodecs (progressive enhancement only)
    └─ a 3D object/world that reacts to scroll
        └─ Three.js / R3F, lazy-loaded, render on demand
```

Rule of escalation: CSS → Motion → GSAP → canvas/WebGL. Move up only when the lower tool can't express the spec row.

## 2. Budgets

| Budget | Target |
|---|---|
| Frame | 60 fps → 16.7 ms; on 120 Hz → 8.3 ms. Scroll handlers do *reading*, rAF does *writing*. |
| Properties | `transform`, `opacity`, `clip-path`, `filter` (sparingly). Never animate layout (`top`, `width`, `height`, `margin`). |
| JS for motion | GSAP core+ScrollTrigger ≈ 45 KB gz; Lenis ≈ 5 KB; Motion ≈ 18–35 KB; three ≈ 150 KB+ (lazy). |
| Scrub video | Desktop ≤ 6 MB, mobile ≤ 2.5 MB, clip ≤ 6 s. Larger → shorten, lower fps (24), width, or switch to frames. |
| Image sequence | 60–150 frames; desktop ≤ 1600 px wide (~4–8 MB total), mobile ≤ 800 px (~2–3 MB). Decoded memory = w×h×4 per frame. |
| WebGL | DPR capped at 1.5–2; one canvas per page; pause off-screen; GLB with Draco/Meshopt, textures KTX2/WebP ≤ 2048 px. |
| LCP | The hero's first paint is an `<img>`/poster, never a frame that waits on JS, video or WebGL. |
| CLS | Reserve every media box (`aspect-ratio`, explicit sizes). Pin spacers are created before first paint of the section. |

## 3. Mobile strategy
- Design the mobile version of each effect in the spec, don't shrink desktop. Typical swaps: horizontal track → vertical stack; long pins → shorter pins (≈ 60%); 3D world → one object or a still; video scrub → mobile file or image sequence at 800 px.
- Use `100dvh` (or `svh`) for pinned stages; iOS toolbars change `vh`.
- Touch scroll is already momentum-smoothed: don't add Lenis `syncTouch` unless tested on devices.
- Never hijack horizontal swipes; never block pinch-zoom.
- Test on a real mid-range Android and an iPhone (Safari). Desktop DevTools throttling is not enough.

## 4. Reduced motion (`prefers-reduced-motion: reduce`)
Content must be complete and readable with zero animation.
- CSS: put motion inside `@media (prefers-reduced-motion: no-preference)` — the base styles are the final state.
- GSAP: `gsap.matchMedia()` with a `reduce` condition that creates nothing (or only opacity fades); `mm.revert()` handles toggles live.
- Lenis: don't create it (its `respectReducedMotion` default also forces instant scroll).
- Video/frames: show the poster or one meaningful frame; remove the pin (track height `auto`).
- 3D: render one static frame; no pointer tilt.
- Pins and horizontal tracks: unpinned vertical stack.

## 5. Recipes

Each recipe: **when**, **how**, **watch out**. Demo file in brackets.

### 5.1 Pinned storytelling `[pinned-storytelling.html]`
- **When:** a sequence of 2–5 ideas must be read in order while a visual transforms.
- **How:** one `gsap.timeline` with `scrollTrigger: { trigger, start: 'top top', end: () => '+=' + innerHeight * N, pin: true, scrub: 0.5–1, anticipatePin: 1, invalidateOnRefresh: true, snap: { snapTo: 'labels' } }`. `addLabel()` per chapter. Text lives in the DOM; JS only hides/shows it.
- **Watch out:** pin length = reading time — 1–1.5 viewports per chapter on desktop, shorter on mobile. Don't pin inside a `transform`ed parent. Create triggers top-to-bottom (or set `refreshPriority`). Call `ScrollTrigger.refresh()` after fonts/images change layout.

### 5.2 Horizontal scroll `[horizontal-scroll.html]`
- **When:** a collection that reads naturally as a row (timeline, gallery, chapters).
- **How:** pin the section, tween the track `x: () => -(track.scrollWidth - innerWidth)`, `ease: 'none'`, `end: () => '+=' + distance`. Elements inside use `containerAnimation: thatTween` for their own triggers.
- **Watch out:** desktop only by default (`gsap.matchMedia('(min-width: 768px) and (prefers-reduced-motion: no-preference)')`); provide keyboard reachability (the content is still in DOM order); no snap that fights the user.

### 5.3 Text and mask reveals
- **When:** a headline or manifesto is the lead element of a view.
- **How:** GSAP SplitText (free) `SplitText.create(el, { type: 'lines,words', mask: 'lines', autoSplit: true, onSplit(self) { return gsap.from(self.lines, { yPercent: 100, stagger: 0.08 }) } })`; scrubbed word reveals → `library/mengto/scroll-scrubbed-word-reveal`. CSS-only: `clip-path: inset()` keyframes on `view()`.
- **Watch out:** keep the original text accessible (SplitText adds `aria-label`; verify). Re-split on resize (`autoSplit`). One reveal style per site, not per section.

### 5.4 Parallax depth `[css-scroll-timeline.html, lenis-gsap-setup.html]`
- **When:** layers of the two-object concept should feel physically separated.
- **How:** CSS `animation-timeline: view(); animation-range: cover` with different `translateY` per layer; or GSAP `yPercent` with `scrub: true`.
- **Watch out:** ≤ 3 layers; small distances (5–20%); disable on reduced motion; oversize layers (`inset: -15%`) so edges never show.

### 5.5 Scroll-scrubbed video `[video-scrub.html]`
- **When:** real footage (product rotation, process) must follow the scroll both ways.
- **How:**
  1. Encode with `tools/scroll-kit/prepare-scrub-video.sh` → all-keyframe (`-g 1 -bf 0`), no audio, `+faststart`, desktop + mobile, MP4 (H.264) + WebM (VP9), poster.
  2. `<video muted playsinline preload="auto" poster>` inside a sticky stage in a tall track.
  3. Fetch the file into a Blob URL (instant seeks, no range requests).
  4. rAF loop: `target = progress × duration`; ease `current` toward it; set `currentTime` only when `!video.seeking`.
  5. iOS: `play().then(pause)` once on first touch.
- **Watch out:** a normal encode (keyframe every 2–10 s) stutters on every seek. Keep ≤ 6 s. The poster is the LCP element — make it a good still. Never autoplay with sound.

### 5.6 Canvas image sequence `[image-sequence-canvas.html]`
- **When:** frame-exact control, iOS-critical, transparent-looking product shots, or a CG render.
- **How:** `tools/scroll-kit/extract-frames.sh video.mp4 out 120` → WebP/AVIF frames + `manifest.json`. Canvas sized to CSS box × DPR (cap 2). Progressive preload (every 8th → 4th → 2nd → rest, 6 in flight); draw the nearest loaded frame with a "cover" fit; redraw only when the frame index changes.
- **Watch out:** memory (w×h×4 per decoded frame) — use `HTMLImageElement`, not a big `ImageBitmap` array, and the 800 px set on phones. Give the canvas `role="img"` + `aria-label`. AVIF is smaller but slower to decode: prefer WebP for > 90 frames.

### 5.7 WebCodecs (progressive enhancement)
- **When:** long or HD scrubbing on Chromium-first audiences.
- **How:** demux MP4 (e.g. mp4box.js) → `VideoDecoder` → keep a small ring buffer of `VideoFrame`s around the scroll position → `drawImage(frame)` → `frame.close()`.
- **Watch out:** feature-detect `'VideoDecoder' in window` and fall back to 5.5/5.6. Safari supports WebCodecs but WebKit bug 287516 reorders B-frame content — encode without B-frames (`-bf 0`). Always `close()` frames or memory explodes.

### 5.8 Cursor and magnetic interactions
- **When:** pointer play is part of the concept (an object that follows, attracts, reacts).
- **How:** `pointermove` writes target coordinates; one rAF loop lerps (`x += (tx − x) × 0.15`) and applies `transform`. Magnetic button: when the pointer is within radius r, translate toward it by (distance × 0.3), spring back on leave (Motion `useSpring` or `gsap.quickTo`).
- **Watch out:** only on `(pointer: fine)`; never hide the system cursor without a clear replacement; keep focus styles; no effect on touch.

### 5.9 Drag and physics
- **When:** the user is meant to handle something (carousel, sorter, toy).
- **How:** Motion `drag` with `dragConstraints` + `dragElastic`, or GSAP Draggable + InertiaPlugin (both free). Physics toys: Matter.js in a lazy-loaded island. See `library/emil/gestures`.
- **Watch out:** provide buttons/keyboard alternatives; respect `touch-action`; momentum must be interruptible.

### 5.10 3D object tied to scroll `[scroll-3d-object.html]`
- **When:** the concept's object deserves real depth (product, signature form).
- **How:** a scroll "conductor" maps progress → keyframed pose (rotation, scale, camera); damp toward it each frame; render on demand (stop when settled), pause off-screen/tab-hidden. React: R3F + Drei `ScrollControls`/`useScroll`, or drive R3F from a ScrollTrigger progress value. Worlds/chapters: `library/mengto/build-threejs-scroll-worlds`; details: `library/threejs/*`.
- **Watch out:** lazy-load (dynamic import when the section nears the viewport); poster/still first for LCP; dispose geometry, materials, textures and the renderer on unmount; DPR ≤ 1.75; test on a mid-range phone; no-WebGL fallback.

### 5.11 Shared-element page transitions
- **When:** an object travels between pages (thumbnail → hero).
- **How:** same-document: `document.startViewTransition(() => update())` and matching `view-transition-name` on both states; React/Next: `library/vercel/react-view-transitions`. Multi-page sites: `@view-transition { navigation: auto; }` on both pages (Chrome 126+, Safari 18.2+; Firefox partial).
- **Watch out:** names must be unique on the page; wrap motion in `@media (prefers-reduced-motion: no-preference)`; kill ScrollTriggers before the old page leaves.

## 6. Lifecycle & cleanup (SPA / Next.js)
- React: `useGSAP(() => {...}, { scope })` from `@gsap/react` (auto-reverts) or `gsap.context()` + `ctx.revert()` in the effect cleanup.
- `gsap.matchMedia()` → `mm.revert()` on unmount.
- Lenis: `gsap.ticker.remove(fn)`, `lenis.destroy()`.
- Canvas/video: cancel rAF, disconnect observers, remove listeners, `URL.revokeObjectURL`, `video.removeAttribute('src'); video.load()`.
- Three: `geometry.dispose()`, `material.dispose()`, `texture.dispose()`, `renderer.dispose()`.
- After route change or async content: `ScrollTrigger.refresh()` once.

## 7. Common bugs → fix
| Symptom | Cause | Fix |
|---|---|---|
| Pin jumps on fast scroll | Pin starts late | `anticipatePin: 1` |
| Triggers fire at wrong spot after load | Images/fonts changed height | Reserve space; `ScrollTrigger.refresh()` after load |
| Horizontal end wrong after resize | Static distance | Function values + `invalidateOnRefresh: true` |
| Lenis and pins drift | Not synced | `lenis.on('scroll', ScrollTrigger.update)` + ticker pattern |
| Video scrub stutters | Sparse keyframes / stacked seeks | `-g 1` encode; seek only when `!video.seeking`; Blob URL |
| Blank video on iOS | Missing `muted playsinline` / not primed | Add attributes; play/pause on first touch |
| Canvas blurry | Canvas not scaled by DPR | width/height = CSS size × min(DPR, 2) |
| Jank only on phones | Too many layers / big decode / DPR 3 | Mobile assets, fewer layers, DPR cap |
