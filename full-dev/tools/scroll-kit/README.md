# Scroll Kit — working scroll, video and 3D demos

Small, dependency-light, single-file demos. Each is commented section by section and is the starting point for a Phase 9 implementation, **not** a design. Every demo uses placeholder tokens in `:root`. Replace them with the project's `tokens.css` and reshape the motion to the approved spec (`references/component-sources.md` → adaptation rule).

Guide: `references/scroll-video-interaction.md`.

## Run
CDN scripts use exact versions (gsap@3.15.1, lenis@1.3.27, three@0.187.0). Video and frames load via `fetch`, so serve the folder over HTTP:

```bash
cd <skill-dir>/tools/scroll-kit && python3 -m http.server 8000   # open http://localhost:8000/
```

## Demos

| File | Technique | Libraries | Mobile | Reduced motion |
|---|---|---|---|---|
| `video-scrub.html` | Scroll → `video.currentTime`, sticky stage, Blob URL, seek-when-idle loop, iOS unlock | none | Picks the mobile file < 768 px | Poster only, no pin |
| `image-sequence-canvas.html` | Scroll → frame index → `drawImage`, progressive preload, nearest-frame fallback | none | Mobile frame set (800 px) | One frame, no pin |
| `pinned-storytelling.html` | Pinned section, labelled timeline, scrub, snap to chapters | GSAP + ScrollTrigger | Shorter pin | Chapters stacked, nothing pinned |
| `horizontal-scroll.html` | Vertical scroll drives a horizontal track; `containerAnimation` for inner triggers | GSAP + ScrollTrigger | Vertical stack | Vertical stack |
| `css-scroll-timeline.html` | `animation-timeline: scroll()/view()`, `animation-range`, named view timeline, `@supports` fallback | none (CSS only) | Same CSS | Final state |
| `lenis-gsap-setup.html` | Lenis + ScrollTrigger sync (README pattern), anchors, nested scroll opt-out, teardown | Lenis, GSAP | Native touch scroll | Lenis not created |
| `scroll-3d-object.html` | Three.js object posed by scroll, pointer tilt, render on demand, pause off-screen, dispose | three | Object scales to portrait | One still frame |

Each demo exposes a cleanup function on `window.__*Cleanup` to show what must be torn down on a route change.

## Asset scripts (ffmpeg)

```bash
# all-keyframe scrub video: desktop + mobile, MP4 (H.264) + WebM (VP9), poster
./prepare-scrub-video.sh input.mov out/ hero
# env: DESKTOP_W=1920 MOBILE_W=960 FPS=30 CRF_H264=24 CRF_VP9=34 MAX_SECONDS=0

# image sequence for canvas: numbered WebP (and/or AVIF) + manifest.json
./extract-frames.sh input.mp4 out/ 120
# env: WIDTH=1600 MOBILE_W=800 FORMAT=webp|avif|both QUALITY=70
```

`prepare-scrub-video.sh` prints a table with size, frame count and keyframe count per file and flags anything over budget or not all-intra.

## Sample assets
`assets/video/` and `assets/frames/` were produced by the two scripts from a 4-second generated test clip (frame numbers burned in, so you can see the scrub position). Replace them with the project's footage.

## Verified
All demos were opened in Chromium (Playwright) at 1440×900 and 390×844, at 0/50/100% scroll, plus a reduced-motion pass: no console errors, no horizontal overflow; video scrubbed 0 → 1.97 → 3.94 s and the canvas drew frames 1 → 31 → 60. Not tested on a physical iPhone or Android. Do that in Phase 10/11.
