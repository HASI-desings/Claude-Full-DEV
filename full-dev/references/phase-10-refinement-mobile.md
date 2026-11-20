# Phase 10 — Iterative Refinement & Mobile

The first implementation is not the product. Refine with evidence, not adjectives. ★ Gate when every section matches.

Deep dives: `library/emil/review-animations`, `library/emil/gestures`, `library/vercel/web-design-guidelines`, `library/qa/cross-browser-testing`, `library/qa/visual-testing`.

## Refinement loop (per issue)
1. Capture the wrong section (screenshot or recording) — yourself via browser if available, else ask the user.
2. Name the exact problem (spacing, proportion, type, colour, timing, scroll position, easing).
3. Compare with the approved reference (Figma node / prototype / motion reference).
4. Fix only that issue. Don't touch other sections; preserve the design system.
5. Re-capture and compare again. Repeat until it matches.

Accept precise feedback like: "follow this exact layout", "match these proportions", "begin at 30% scroll", "scale 0→100%", "character by character", "don't change other sections". When the reference is clear, approximate is not done.

When reviewing motion code, report fixes as a table: | Before | After | Why |.

## Mobile — a real design, not a smaller desktop
Test at **375×667, 390×844, 430×932** (phones), **768×1024, 1024×1366** (tablets), plus 1280/1440/1920 desktop. Check:
1. Navigation and menu (open/close, focus trap, scroll lock, back behaviour)
2. Typography scale and line lengths; no orphaned single words in headlines
3. Spacing and section rhythm
4. Touch targets ≥ 44×44px with spacing; no hover-only functionality
5. Image cropping/art direction per breakpoint
6. Animation performance on a mid-range phone; simplify or replace heavy motion (pinning, 3D, long scrubs) on small screens
7. Horizontal overflow (none, anywhere)
8. Loading performance on 4G
9. Safe areas / notches, `100dvh` instead of `100vh`
10. Landscape orientation doesn't break

## Scroll performance pass (every scroll-bound section)
- **60 fps on a mid-range phone** (e.g. a 2–3-year-old Android): Chrome DevTools Performance panel with 4× CPU throttle as a first check, then a real device via remote debugging. No long tasks > 50 ms while scrolling; no layout/paint in the scroll frames (only composite).
- **Memory:** heap and GPU memory stable after scrolling the page 3× top↔bottom (frame sequences, video blobs, WebGL textures). Rising = a leak or missing dispose.
- **Resize / rotate / refresh:** pins, horizontal tracks and scrub ranges still correct after window resize, phone rotation, reload mid-page, and after fonts/images load (`ScrollTrigger.refresh()` hooked up).
- **iOS Safari:** video shows (muted/playsinline), scrubs both ways, sticky stages use `dvh`, no jump when the toolbar collapses, no rubber-band artefacts at pin edges. Test on a device or a cloud device service; say so if you couldn't.
- **Reduced motion:** emulate it — every section readable, nothing pinned, no scrub, no Lenis.
- Fix order: lighter asset → fewer layers → lower DPR → simpler technique on mobile (the spec's mobile column).

If the automatic responsive result is poor: design a dedicated mobile frame for that section (Figma via MCP or an HTML sketch), get approval, then implement exactly that layout. The visual identity stays consistent across devices even when compositions differ.
