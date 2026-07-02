# Design Intent — wood-shell-tongue-drum rev A

- Master CAD: `cad/wood-shell-tongue-drum.scad` (sha256: d701a846f44329a595398b690165ab07ec964187416711c5692dd0064e37fa7a), driven by `wood-shell-tongue-drum-design-table.xlsx` (sha256: 411ed770bbc4f5b99388d1c6949b29f59cefa4d90490531f7d634721a3a819e8)
- Function: V1 Cylinder + Flat Top, Standard 16" — a slit-tongue idiophone with an enclosed wooden resonator (Black Walnut stave shell, Padauk soundboard). A two-DOF coupled oscillator: 11 A-Kurd cantilever tongues (flat-cantilever Euler-Bernoulli, `f = K·t/L^2`) coupled to a Helmholtz cavity (`f_H = (c/2pi)*sqrt(A_port/(V*L_neck))`) via the gu port, targeting `f_H/f_ding ∈ [0.80, 1.20]` (design.md §2, §4).
- Environment: indoor idiophone; struck tongues, seasonal wood movement affects the rabbet joint and cavity behavior (risks.md).
- Target qty: 1 (prototype, first of a 4-variant x 3-size family). Deadline: TBD. Budget/unit ceiling: TBD.

## Critical dimensions (carry tolerances)

| Feature | Nominal | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| Shell OD / height | 16.00 in / 8.00 in | ± 0.020 in default | sets cavity volume for Helmholtz coupling | design.md §4 build table |
| Wall thickness (finished) | 0.625 in | after lathe truing, 0.625-0.75 in range | cavity volume, structural rigidity | design.md §4 / §5.15 |
| Soundboard thickness | 0.375 in (Padauk) | rabbet 0.005 in slip-fit | tongue stiffness (K=24,438 for Padauk), soundboard resonance | design.md §4 |
| Tongue lengths (11, A Kurd schedule) | 6.454 in (ding) down to 3.227 in | slot-cut, caliper-checked pre-glue-up | sets each tongue's pitch | design.md §4 tongue length schedule |
| Tongue position grid (r, theta) | zigzag-ascending, r ≤ 6.5 in | "derived estimates," refined by SolidWorks placement | ergonomic two-handed reach, ≥1.0 in wall clearance on 16in shell | drawing-brief.md Sheet 03 position grid |
| Gu port diameter | 2.5 in initial | tuned in shop via step-drill | primary Helmholtz tuning knob | design.md §4 (position not yet specified — TBD) |

## Incidental (free for DFM)

- Shell finish/patina, stave vs. segmented construction choice (aesthetic-equivalent per README "dual body-construction paths"), brand mark placement.

## Must-nots (DFM may never violate)

- Do not cut tongue slits before the CNC pocketing geometry (slit + tongue-base relief) is reviewed against drawing-brief.md/cnc/README.md — cut geometry is explicitly out of scope of the current CAD envelope.
- Gu port must be drilled LAST, deliberately undersized, then step-bored while measuring f_H in shop (design.md) — never pre-drilled to a fixed size.
- Do not treat the +2.5% domed-tongue length correction (V2/V4) as validated — it is a starting estimate pending Phase 1 calibration (design.md "Highest-risk unknowns" #1).
- Soundboard rabbet fit (0.005 in slip-fit) and gu port concentricity (±0.025 in) are load-bearing tolerances for tuning accuracy — do not loosen without re-deriving f_H sensitivity (design.md §5 tolerance table).

## Material intent

- Shell: Black Walnut, 4/4 stock, 16 staves at 11.25° miter.
- Soundboard: Padauk (K ≈ 24,438), 3/8 in.
- Acceptable subs: none recorded for the V1 Standard prototype (spec-first).
- Forbidden: none recorded.

## Stage status

Stage 0 intake complete 2026-07-01. Gate A (Alpha shop compile) NOT yet run — no concessions logged, nothing presented as shippable.
