# V5 Readiness Notes - Wood Shell Tongue Drum

Current status: `L2 V5 build-packet candidate`.

Authority is limited to review and prototype planning until measurement closes the gates below. The repo contains useful packet material, a workbook, a hero SVG, print/capstone outputs, and planning folders, but it does not contain measured prototype evidence, calibrated CAD, fabrication DXF, or released G-code.

Do not describe this repo as build-ready, measured, validated, repeatable, or L3 until the Phase 1 prototype data is captured and folded back into the packet. Round 2 recovery did not add fabricated CAD geometry, DXF coordinates, or tuning frequencies.

## Authority Chain

| Artifact | Role | Authority posture |
| --- | --- | --- |
| `wood-shell-tongue-drum-design-table.xlsx` | parametric design source | `pending_measurement`; unmeasured design-table scaffold |
| `design.md` | governing model and first-prototype rationale | design intent and derived estimates |
| `family-spec.csv` | variant matrix | planning matrix; every row says no measured prototype data |
| `validation.csv` | target and measurement protocol | measurement plan; measured fields are empty |
| `drawings/00-hero-v1-standard.svg` | hero side-section preview | derived preview, not fabrication release |
| `concepts/round-body-variants_concept-sheet.png` | concept sheet | concept-only visual support |
| `cad/README.md` | CAD staging plan | CAD deferred until measurements |
| `cad/mcp-session-log.md` | external-tool provenance stub | records that no MCP/CAD authoring session exists yet |
| `cnc/README.md` | CNC and G-code staging plan | G-code deferred until measurements |
| `tuning-gates.md` | L1/L2 tuning gate surface | measurement plan; no added target frequencies |

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
| Visual authority register | concept/preview artifacts recorded as non-authority or pending measurement | added |
| MCP/CAD provenance | `cad/mcp-session-log.md` says whether external tools created artifacts | stubbed; no tool sessions |
| Explorer | root HTML dashboard for current gates | added |

## Promotion Rule

The current safe promotion is L2 only. L3 requires `validation.csv` and `validation-loop.csv` to contain Phase 1 measurements, then CAD/DXF/CNC files must be regenerated from the calibrated workbook and recorded in `visual-output-register.csv` with fabrication authority.
