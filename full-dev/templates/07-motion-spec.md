# Motion Specification — <Project>

## Global
- Libraries (and why each is needed):
- Smooth scroll: yes/no — why
- Easing tokens:
- Reduced-motion strategy:
- Mobile strategy:

## Section: <name>
Purpose of motion here:

| Element | Role | Trigger | From | To | Duration | Delay / stagger | Easing | Scroll relation | Exit | Reduced motion | Mobile |
|---|---|---|---|---|---|---|---|---|---|---|---|
| | lead | | | | | | | | | | |
| | support | | | | | | | | | | |

Reference: <Figma prototype / video / reference URL + timestamp>

<repeat per section>

## Scroll & video (one row per scroll-bound effect)
Technique options: CSS view()/scroll() · GSAP pin/scrub · video scrub · canvas sequence · Three.js · WebCodecs. See `references/scroll-video-interaction.md`.

| Section / element | Technique | Trigger range (start → end) | Pin (desktop / mobile, viewports) | Scrub smoothing | Snap | Frames / duration | Asset (file · res · codec · budget · poster) | Interaction | Mobile | Reduced motion | Fallback |
|---|---|---|---|---|---|---|---|---|---|---|---|
| | | `top top` → `+=250%` | | | | | | | | | |

Motion reference: `docs/full-dev/motion-refs/<file>` (+ scroll-kit demo used as the starting point)

## Borrowed components
| Component | Source + URL | License / attribution | What changes to fit the concept | Tokens mapped |
|---|---|---|---|---|
| | | | | |

## Page transitions
| From → To | Shared element | Behaviour | Duration | Fallback |
|---|---|---|---|---|
