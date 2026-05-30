# Tongue-Tuning Gates

Status: L1/L2 concept and measurement plan. This file does not introduce new tuning frequencies, CAD geometry, DXF coordinates, or measured acoustic claims.

## Authority Posture

The packet may be used for review and prototype planning. It may not be used as a build-ready tuning release until the physical gates below are measured, recorded, and folded back into the design table.

Existing target and predicted values in `design.md`, `family-spec.csv`, and `validation.csv` are inherited packet estimates. Round 2 recovery did not add new numeric targets. Treat all acoustic values as `pending_measurement` unless a later evidence row records a real prototype measurement.

## Material Gates

| Gate | Why it matters | Evidence needed | Blocks |
| --- | --- | --- | --- |
| Soundboard species and stock ID | Wood K constants vary by board, grain, moisture, and supplier | Stock label, species confirmation, thickness map, moisture/environment note | Tongue length release |
| Padauk or alternate K calibration | The library K value is only a planning model for the actual board | One calibration tongue, measured pitch, back-solved K, cents error | Full tongue-field cutting |
| Soundboard thickness uniformity | Cantilever frequency depends directly on thickness | Multi-point caliper map before cutting tongues | Tuning repeatability claim |
| Grain and defect review | Runout, checks, glue lines, and knots can split tongues or detune sustain | Photo log and reject/accept notes | Shop release |

## Structure Gates

| Gate | Why it matters | Evidence needed | Blocks |
| --- | --- | --- | --- |
| Shell rim planarity | Air leaks and uneven soundboard support change Helmholtz response | Dial-indicator or feeler-gauge check | Soundboard glue-up |
| Chamber air seal | Helmholtz coupling requires controlled air movement through the port | Low-pressure smoke, vacuum, or leak check | Coupling claim |
| Gu-port field tuning | Port end correction cannot be trusted from concept geometry alone | Step-drill log with measured cavity response after each change | Port finalization |
| Seasonal joint rest | Wood movement can alter seal, pitch, and sustain | Post-rest recheck after humidity or time interval | Repeatability claim |

## Tongue-Tuning Workflow

1. Cut or route only the calibration tongue or sacrificial coupon first.
2. Measure the calibration pitch with the selected tuner or spectrum method.
3. Back-solve the actual board K constant and compare it to the planning value.
4. Update the design table before cutting the remaining tongue field.
5. Cut remaining tongues intentionally long or high, then file/sand down to pitch.
6. Record each tongue measurement in `validation.csv`, including environment and cents error.
7. Do not promote CAD, DXF, SVG, print plates, or G-code to fabrication authority until they are regenerated from the calibrated table.

## L3 Promotion Gates

- `validation.csv` has measured values for the V1 Standard prototype tongue field.
- `validation-loop.csv` rows `vl002`, `vl003`, and `vl004` are no longer `measurement_required`.
- `visual-output-register.csv` identifies the calibrated source for every drawing, CAD, DXF, and print output.
- `cad/mcp-session-log.md` records any external CAD, OpenSCAD, Illustrator, Blender, Photoshop, or image-generation session that produced or edited an artifact.
- `risks.md` has updated residual risks for cracking, detuning, air leaks, and seasonal drift after the first measured build.
