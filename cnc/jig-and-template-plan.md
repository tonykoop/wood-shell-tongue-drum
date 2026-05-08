# Wood Shell Tongue Drum — Jig And Template Plan

This file makes the manufacturing choices reviewable before CAM exists. The V1 Standard 16 in prototype is deliberately a low-CAD build: flat soundboard, stave shell, laserable templates, and measurements that calibrate the later V2/V4 dome work.

## Decision Matrix

| Build feature | Recommended first-prototype choice | Why | Validation checkpoint |
|---------------|------------------------------------|-----|-----------------------|
| Shell construction | 16-stave Black Walnut cylinder | Lowest piece count; matches ashiko/conga stave skills; easy to true on lathe | Dry-clamp 4-stave arc; full ring closes within 1/16 in before glue |
| Stave bevel jig | Tilting-arbor table-saw jig referenced from stave centerline | Keeps both bevels symmetric; avoids compounded miter drift | 11.25 deg +/- 0.1 deg per edge; ring closes without clamp force spikes |
| Glue-up form | MDF cylinder caul with band clamp | Stabilizes OD while preserving an open interior for squeeze-out cleanup | Shell remains round within +/- 0.030 in after cure |
| Lathe mount | Waste-block faceplate + soft expansion plug | Keeps shell supported without crushing the rim | Rim TIR <= 0.005 in after truing |
| Soundboard hold-down | MDF spoilboard + laser-cut vacuum/tape clearance template | Keeps tape/vacuum away from tongue free ends and slit kerfs | No tape under moving tongue regions; test pass clears template |
| Tongue routing | CNC 1/8 in upcut spiral, through-cut +0.030 in | Directly controls kerf, tongue length, and stress-relief radius | Kerf 0.125 in +/- 0.005 in on poplar test disc |
| Tongue layout verification | Laser-cut MDF overlay | Cheap check before cutting Padauk; catches radial crowding and rim collisions | Overlay confirms longest A3 tongue has rim clearance |
| Gu-port tuning | Step-drill from pilot while logging f_H at every 0.25 in | Port area is the Helmholtz knob; measured curve validates the model | Stop at 0.80 <= f_H/f_ding <= 1.20; record final diameter |
| V2/V4 dome flip | Three-pin flip jig | Needed only after V1 validates the flat model | Datum repeatability <= 0.010 in on poplar dome blank |

## Laser Outputs

| File to emit | Size | Material | Notes |
|--------------|------|----------|-------|
| `soundboard-tongue-overlay-v1-standard.dxf` | 16 in OD | 1/8 in MDF | Shows center datum, rim keep-out, all 11 tongue centerlines, slit endpoints |
| `vacuum-gasket-v1-standard.dxf` | 16 in OD | 1/16 in rubber or kraft template | Hold-down clearance around every tongue and the ding strike area |
| `stave-label-strip.svg` | 16 labels | paper / masking tape | Labels staves 01-16 in grain order before beveling |
| `gu-port-log-card.svg` | 4 x 6 in | cardstock | Port diameter, measured f_H, ratio, environment, action |

## CAM Readiness Gates

- The CNC setup sheet must name machine, controller/post, work coordinate origin, spoilboard strategy, and hold-down.
- Every toolpath must include tool ID, diameter, flute direction, RPM, feed, depth of cut, stepover, and final pass allowance.
- Run a poplar or MDF soundboard test before Padauk; measured slit kerf and A4 pitch prediction go into `validation.csv`.
- Do not publish G-code as build-ready until it has been dry-run above the spoilboard and the first cut photos exist.

## Public Review Notes

The repo is intentionally public-reviewable before final G-code: the review surface is the design table, cut list, fixture logic, drawing brief, and validation plan. G-code becomes public only after the V1 prototype confirms the K constant, Helmholtz end correction, and practical hold-down strategy.
