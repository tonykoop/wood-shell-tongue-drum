# V5 Readiness Notes - Wood Shell Tongue Drum

Current status: `prototype/planning packet with V5 explorer`.

Fabrication authority is limited to the current design table and packet sources. The repo contains useful packet material, a workbook, a hero SVG, print/capstone outputs, and planning folders, but it does not contain measured prototype evidence, calibrated CAD, fabrication DXF, or released G-code.

Do not describe this repo as build-ready, measured, validated, or repeatable until the Phase 1 prototype data is captured and folded back into the packet.

## Authority Chain

| Artifact | Role | Authority posture |
| --- | --- | --- |
| `wood-shell-tongue-drum-design-table.xlsx` | parametric design source | planning/design-table authority, unmeasured |
| `design.md` | governing model and first-prototype rationale | design intent and derived estimates |
| `family-spec.csv` | variant matrix | planning matrix; every row says no measured prototype data |
| `validation.csv` | target and measurement protocol | measurement plan; measured fields are empty |
| `drawings/00-hero-v1-standard.svg` | hero side-section preview | derived preview, not fabrication release |
| `concepts/round-body-variants_concept-sheet.png` | concept sheet | concept-only visual support |
| `cad/README.md` | CAD staging plan | CAD deferred until measurements |
| `cnc/README.md` | CNC and G-code staging plan | G-code deferred until measurements |

## Measurement-Required Claims

- Padauk K constant for the specific stock.
- First tongue pitch and back-solved material correction.
- V1 Standard A Kurd tongue field tuning, including cents error and environment.
- Helmholtz cavity response, gu-port end correction, and coupling ratio.
- Shell rim flatness, wall thickness uniformity, and air seal.
- Slit kerf width, tongue Q/sustain, and stress-relief performance.
- Seasonal movement at the bowl-top rabbet joint.
- Player ergonomics for the 20 inch Floor Pouf size.

## V5 Blockers

| Gate | Needed evidence | Current status |
| --- | --- | --- |
| Phase 1 prototype | V1 Standard build with measured tongue/cavity data | missing |
| CAD authority | SolidWorks/STEP/STL derived from calibrated workbook | deferred |
| Fabrication DXF | tongue layout and fixture DXF tied to calibrated CAD/design table | deferred |
| G-code | machine-specific files generated from calibrated CAD/CAM | deferred |
| Visual authority register | concept/preview artifacts recorded as non-authority | added |
| Explorer | root HTML dashboard for current gates | added |

## Promotion Rule

The next safe promotion is from prototype/planning packet to build-packet candidate only after `validation.csv` and `validation-loop.csv` contain Phase 1 measurements and the CAD/DXF/CNC files are regenerated from the calibrated workbook.
