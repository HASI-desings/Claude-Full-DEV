# Phase 5 — Design System

Define the brand system deliberately. Never let a model's defaults invent the identity. Deliverable: `docs/full-dev/05-design-system.md` + tokens (`tokens.css` / Figma variables) + a preview page. Template: `templates/05-design-system.md`. ★ Gate.

Deep dives: `library/anthropic/frontend-design` (anti-generic method), `library/emil/apple-design`, `library/emil/emil-design-eng`, `library/addyosmani/accessibility-engineering`, engine guide `tools/ui-ux-pro-max/GUIDE.md`.

## The design-intelligence engine (bundled)
`tools/ui-ux-pro-max/` = searchable data (styles, 194 product palettes, font pairings, 130 UX rules, GSAP presets, stack guidance) + a dependency-free Python CLI. Run it by **absolute path** from this skill's directory (`python3` or `python`):

```bash
E="<skill-dir>/tools/ui-ux-pro-max/scripts/search.py"
python3 "$E" "<product> <industry> <mood terms>" --design-system -p "Project"      # full baseline
python3 "$E" "<mood terms>" --domain typography -n 8                               # font pairings
python3 "$E" "<mood terms>" --domain color -n 8                                    # palettes
python3 "$E" "<interaction>" --domain gsap                                         # motion presets
python3 "$E" "<concern>" --domain ux                                               # UX rules (a11y, forms, nav…)
python3 "$E" "<topic>" --stack nextjs                                              # stack-specific guidance
python3 "$E" "<query>" --design-system --tokens css                                # machine-readable tokens
python3 "$E" "<query>" --design-system --persist --preview -p "Project" --output-dir "<project-root>"
```

**How to use its output:** it gives the *competent conventional* answer. Use its UX rules, contrast checks and anti-patterns as a quality floor. Use its style/palette/font picks as **raw material and a contrast point** — the final system must come from the two-object concept, not from the top search result. No terminal? Read `tools/ui-ux-pro-max/data/*.csv` directly or skip it and apply the rules below.

## 5.1 Typography
Primary, secondary, optional display face; weights; heading and body scales (fluid with `clamp()`); letter-spacing; line-heights; max line length (<80ch); responsive behaviour. Explore faces that echo the concept (the clock's engraved numerals, the shell's spiral proportions) — not the popular default. One or two families; if two, clearly distinct. Check licensing (Google Fonts / Fontshare / paid — tell the user). Type is an active design element, not a neutral vehicle.

## 5.2 Colour
Primary, secondary, accent, background, surface, text (primary/secondary/muted), border, interaction states (hover/active/focus/disabled), feedback (success/warn/error), gradients only if conceptually justified. Derive from the objects' real colours and materials. **Every colour has a stated purpose.** Verify contrast: body text ≥ 4.5:1, large text/UI ≥ 3:1, visible focus ring. Define dark mode if needed as a designed variant, not an inversion.

## 5.3 Visual components
Buttons (all states), navigation (desktop + mobile), cards *only where content is genuinely card-shaped*, containers, grid, borders, icons (one consistent SVG set, never emoji), image treatment (ratio, masking, grain), text treatments, decorative elements, background patterns, interactive components. Radius, shadow and border values vary with hierarchy — not one value for everything.

## 5.4 Layout system
Max content width, column grid (desktop/tablet/mobile), spacing scale (e.g. 4/8-based), section spacing, alignment rules, breakpoints (design at 1440, 1024/768, 390/375), safe areas.

## 5.5 Signature brand element(s)
One or more recurring elements born from the two-object concept: a graphic object, recurring shape, custom texture, framing technique, line/path, unusual type treatment, recurring animation. Define where it appears and where it must *not* (overuse kills it). This is what makes the site one recognisable system.

## 5.6 Motion tokens
Motion is part of the system, not something added in Phase 9. Define in `tokens.css`:
- **Easing:** `--ease-out`, `--ease-in-out`, `--ease-drawer` (Phase 7 defaults), plus one *signature* curve born from the concept (e.g. a mechanical "tick" vs an organic drift).
- **Durations:** `--dur-press` (100–160ms), `--dur-ui` (150–250ms), `--dur-panel` (200–500ms), `--dur-reveal` (marketing).
- **Stagger:** `--stagger-tight` / `--stagger-loose`.
- **Scroll:** `--scrub` (smoothing, e.g. 0.5), `--pin-length` per chapter (in viewports, desktop/mobile), `--parallax-max` (e.g. 12%).
- **Distances:** reveal offset (`--reveal-y`), magnetic pull, max tilt.
- **Reduced-motion variants:** what each token becomes under `prefers-reduced-motion` (usually 0 distance, short opacity only).
GSAP/Motion read these from CSS (`getComputedStyle`) or a shared `motion.ts`. Never hard-code a duration in a component.

## 5.7 Component adaptation rules
When a section will use a library component (Aceternity, Magic UI, React Bits, 21st.dev…), the design system decides how it looks, not the library. Follow `references/component-sources.md` → *adaptation rule*: map every colour/radius/shadow/font/duration to tokens, change at least one structural trait so it expresses the concept, delete unspecced extras, add reduced-motion + focus states, record source + license. Add a "Borrowed components" row in the preview page showing the library default next to our adapted version.

## Produce it
- **Figma MCP available:** create/update the file: variables (colour, spacing, radius, type), text styles, component sheet, signature element page. Share the link.
- **Otherwise:** `styles/tokens.css` (CSS custom properties) + optional Tailwind theme mapping + a `design-system.html` preview page (type scale, palette with contrast ratios, components in all states, signature element) shown as an artifact or file.
- Run `references/anti-generic.md` against the system. Revise anything that reads as a default and say what you changed and why.

Get approval. After approval, tokens are the single source of truth — components never hard-code hex values or pixel sizes.
