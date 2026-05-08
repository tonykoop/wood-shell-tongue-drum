# CNC — Wood Shell Tongue Drum

This folder holds CNC toolpaths, post-processed G-code, fixture STLs, and tool-list files for the wood shell tongue drum family.

## Critical CNC operations

| Operation                     | Variants     | Tool                           | Stock                              | Stepover / DOC               |
|-------------------------------|--------------|--------------------------------|-------------------------------------|------------------------------|
| Soundboard tongue slits       | All          | 1/8″ upcut spiral, 1/4″ shank  | Padauk disc, 0.25″–0.5″ thick      | full-depth single pass at 100 ipm feed |
| Soundboard OD profile cut     | All          | 1/4″ compression, 1/4″ shank   | Padauk disc, oversize blank         | 0.250″ DOC, multi-pass       |
| Dome 3D surfacing — convex top| V2, V4       | 3/4″ ball-end, 1/2″ shank      | Padauk glue-up blank, 1.5″ thick   | 0.05″ stepover, 0.25″ DOC    |
| Dome 3D surfacing — concave bottom | V2, V4  | 3/4″ ball-end, 1/2″ shank      | flip-jig with datum pins            | 0.05″ stepover, 0.25″ DOC    |
| Bowl 3D surfacing — exterior  | V3, V4 (CNC alt) | 3/4″ ball-end, 1/2″ shank  | Black Walnut glue-up blank, 5″ thk | 0.05″ stepover, 0.50″ DOC    |
| Bowl 3D surfacing — interior  | V3, V4 (CNC alt) | 3/4″ ball-end, 1/2″ shank  | flip-jig with datum pins            | 0.05″ stepover, 0.50″ DOC    |

## Tool list

All tools listed in `bom.csv` under tooling rows. Critical tools:

- `SLIT-BIT-UPCUT-1-8` — Amana 46202 1/8″ solid carbide upcut spiral. Buy 3 (one breaks per shell).
- `BALLEND-3-4` — Amana 46377 3/4″ ball nose, 1/2″ shank. One bit good for 3+ dome surfaces if kept clean.

## Tongue-slit toolpath spec

The tongue field on the recommended V1 Standard 16″ prototype has 11 slits in the A Kurd zigzag-ascending layout (see `drawing-brief.md` §03 for radial coordinates).

**Fixture:** soundboard disc held face-up on a 16″ MDF backing board with double-sided tape OR vacuum hold-down. Datum: disc center to spindle home.

**Cut order:** ding first (centered slit), then tongues 1, 2, 3, … in radial order. Cutting from inside-out minimizes stress accumulation.

**Cut depth:** through the soundboard thickness + 0.030″ to ensure clean break-through into the spoilboard. On 0.375″ Padauk: cut depth = 0.405″.

**Feed/speed:** 100 ipm feed at 18,000 RPM with 1/8″ upcut spiral. Validate on a poplar test cut first.

**Tongue-base relief:** the slit terminus is a 1/8″-radius half-circle at the tongue base (eyelet detail). This relieves stress concentration and gives a defined free length. The radius matches the bit diameter — single-axis plunge then retract.

**Slit width:** 1/8″ kerf (single pass with the 1/8″ bit). Holding ± 0.005″ kerf width is critical; verify with feeler gauge on a test cut.

## Dome 3D-surfacing toolpath spec (V2, V4)

Dome blank: 17″ × 17″ × 1.5″ Padauk glue-up, 3 plies of 0.5″.

**Coordinate system:** Z-zero on the top of the blank; X/Y origin at the blank center.

**Surface model:** parabolic dome with rise per size preset (Standard: 0.75″). Equation in Fusion / SolidWorks: `z = rise × (1 - (r/R)^2)` where `R = OD/2` and `r = sqrt(x² + y²)`.

**Stepover:** 0.05″. Adaptive scallop control around the rim where the slope is steepest.

**Two-sided machining:**
1. Machine convex top first; allow the bottom datum pins to remain unprofiled.
2. Flip-jig the blank into a fixture with three datum pins located 1″ inside the 16″ rim circle.
3. Machine concave bottom matching the rabbet rim profile.

**Surface finish target:** ≤ 32 µin Ra. Verify with a comparator block; if scallop steps are visible, reduce stepover to 0.03″.

## Pre-built G-code files

```
cnc/
├── README.md                    (this file)
├── tongue-slits-v1-standard.nc  — recommended first prototype slit field
├── tongue-slits-v1-travel.nc    — 12" Travel size
├── tongue-slits-v1-floor.nc     — 20" Floor Pouf size
├── soundboard-od-profile.nc     — disc cut to OD with rabbet allowance
├── dome-convex-v2-standard.nc   — V2 Standard 16" dome top
├── dome-concave-v2-standard.nc  — V2 Standard 16" dome bottom
├── dome-convex-v4-standard.nc   — V4 Standard 16" dome top (same as V2)
└── fixtures/
    ├── flip-jig-datum-pins.stl  — 3D-print fixture for dome flip
    ├── soundboard-vacuum-mat.dxf — laser-cut vacuum gasket pattern
    └── tongue-field-jig.stl     — workholding for tongue-tuning at the bench
```

## Status

**G-code files are placeholders at first commit.** They are emitted from the SolidWorks / Fusion CAD models once the first prototype's measurements have calibrated the workbook formulas. Hand-cutting the V1 Standard prototype (using the cut-list and a manual CNC plunge protocol) is the recommended fast-track to first measurements.

## Cross-references

- Tongue lengths: [`../design.md`](../design.md) §4
- Tool spec: [`../bom.csv`](../bom.csv) (tooling rows)
- CAD source: [`../cad/README.md`](../cad/README.md)
- Drawings: [`../drawing-brief.md`](../drawing-brief.md)
