# Drawing Brief — Wood Shell Tongue Drum

The `drawings/` folder ships dimensioned SVGs for the matrix. Each SVG follows Heifer Zephyr's standard title block (lower-right) with: drawing name, sheet number, scale, units, project (Wood Shell Tongue Drum), date, revision, drafter (Tony Koop). All dimensions in inches unless noted; metric equivalents in brackets where helpful.

## Required drawings

| File                                  | Sheet | Title                                                         | Notes                                                                     |
|---------------------------------------|-------|---------------------------------------------------------------|---------------------------------------------------------------------------|
| `01-variant-matrix.svg`               | 1/9   | Variant Matrix V1–V4 × Three Sizes (top-down + side profiles) | Twelve-cell layout matching `concepts/round-body-variants_concept-sheet.png` with overlaid critical dims |
| `02-v1-standard-side-section.svg`     | 2/9   | V1 Standard 16″ — Side Section A-A                             | Recommended first prototype. Shell, soundboard, rabbet joint, cavity, gu port |
| `03-v1-standard-tongue-layout.svg`    | 3/9   | V1 Standard 16″ — Tongue Field (A Kurd 11-note)                | Top-down soundboard view. Slit centerlines, lengths, position numbering   |
| `04-shell-stave-template.svg`         | 4/9   | Stave Template — All Sizes (full-size cutting layout)          | One stave per size; bevel callouts at 11.25°; centerline marked            |
| `05-shell-segment-template.svg`       | 5/9   | Segment Template — All Sizes (alt body construction)           | 15° miter, 12-per-ring; 8 rings on Std, 6 on Travel, 10 on Floor          |
| `06-rabbet-joint-detail.svg`          | 6/9   | Bowl-Top Rabbet Joint — Section B-B (3× scale)                | ¼″ × ⅜″ rabbet; soundboard slip-fit; glue line; air-seal callout          |
| `07-dome-toolpath.svg`                | 7/9   | V2/V4 Dome Surfacing — CNC Toolpath Schematic                  | Convex top + concave bottom; 0.05″ stepover; flip-jig datum pins           |
| `08-bowl-segment-stack.svg`           | 8/9   | V3/V4 Hemisphere Bowl — Ring Stack Section                     | 8 rings of decreasing dia; lathe-true profile overlay                     |
| `09-gu-port-tuning-progression.svg`   | 9/9   | Gu Port Tuning — Step-Drill Progression                        | 0.25″ pilot → step increments → final size; f_H expected at each step      |

## Drawing conventions

- **Datums:** shell bottom plane = primary horizontal datum (Z=0); axis of revolution = primary vertical datum.
- **Tolerances:** ± 0.020″ default; tighter where called out (rim flatness ± 0.005″, slit kerf width ± 0.005″, miter angle ± 0.1°).
- **Cross-section hatching:** oak-grain pattern at 45° for wood; cross-hatch at 90° for void/cavity.
- **Title block size:** 4″ × 1.5″ at 1:1 scale.
- **Critical dimensions:** bold, with leader lines pointing to the dimensioned feature. Helmholtz-driving dimensions (cavity volume parameters) are double-boxed.
- **Material color cues** (when polychrome): Walnut = warm brown fill, Maple = pale cream, Cherry = pink-brown, Padauk = orange-red. Used in sheet 5 segment-stack diagrams for the diamond pattern.

## Critical dimensions (must appear on the drawings)

| Dimension                          | Drawing | Value (Standard 16″ V1) | Tolerance        |
|------------------------------------|---------|--------------------------|------------------|
| Shell OD                           | 02      | 16.000″                  | ± 0.020″         |
| Shell ID                           | 02      | 14.750″                  | ± 0.030″         |
| Shell wall thickness               | 02      | 0.625″                   | ± 0.030″         |
| Shell height                       | 02      | 8.000″                   | ± 0.030″         |
| Soundboard OD                      | 02, 03  | 16.000″                  | ± 0.010″         |
| Soundboard thickness               | 02, 03  | 0.375″                   | ± 0.005″         |
| Rabbet depth                       | 02, 06  | 0.250″                   | ± 0.005″         |
| Rabbet width                       | 02, 06  | 0.375″                   | ± 0.005″         |
| Tongue length (ding A3)            | 03      | 6.454″                   | + 0.030″ initial |
| Tongue width                       | 03      | 1.250″                   | ± 0.020″         |
| Slit kerf width                    | 03      | 0.125″                   | ± 0.005″         |
| Gu port diameter (final)           | 02, 09  | 2.500″ nominal           | tuned in shop    |
| Stave miter angle                  | 04      | 11.25°                   | ± 0.1°           |

## Sheet 03 — tongue layout details

The 11-tongue A Kurd field uses a **zigzag-ascending** pattern: ding centered, then tongues 1, 2, 3, … alternating left and right at progressively greater radii from the ding. This matches steel-tongue-drum convention and gives the player an ergonomic two-handed reach.

Position grid (radial coords, ding = origin):

| #    | Note | r (in from ding centerline) | θ (deg) | length (in) |
|------|------|------------------------------|---------|-------------|
| Ding | A3   | 0                            | —       | 6.454       |
| 1    | E4   | 4.0                          | 60      | 5.273       |
| 2    | F4   | 4.0                          | -60     | 5.123       |
| 3    | G4   | 5.5                          | 90      | 4.835       |
| 4    | A4   | 5.5                          | -90     | 4.564       |
| 5    | B4   | 6.5                          | 120     | 4.308       |
| 6    | C5   | 6.5                          | -120    | 4.185       |
| 7    | D5   | 6.0                          | 30      | 3.950       |
| 8    | E5   | 6.0                          | -30     | 3.728       |
| 9    | G5   | 6.5                          | 150     | 3.419       |
| 10   | A5   | 6.5                          | -150    | 3.227       |

(These radial coords are derived estimates for the layout drawing; SolidWorks parametric placement against shell radius will refine them. The radii are kept ≤ 6.5″ to leave wall clearance ≥ 1.0″ on the 16″ shell.)

## Status

These SVG files are listed in this brief as the *intended* drawing set. The repo currently ships the brief and the source workbook; SVGs are emitted by `scripts/generate_drawings.py` (in the parent `instrument-maker` skill) reading the workbook as its parametric source. Per the v4 deliverable list, drawings are auto-generated and refreshed when the workbook changes — they are not hand-drawn artifacts.

A placeholder hero drawing — `drawings/00-hero-v1-standard.svg` — ships in this repo at first commit so cross-references resolve. It is replaced in production by sheet 02 above.
