# MCP Session Log

Status: provenance stub for V5 L2 recovery.

No MCP, CAD, image, measurement, Illustrator, Photoshop, Blender, OpenSCAD, Fusion, SolidWorks, or physical measurement tool session was available during Round 2 recovery. No CAD geometry, DXF coordinates, tuning frequencies, renders, or measured outputs were generated in this pass.

| session_id | tool | input_authority | outputs | role | authority_result | review_status | notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| none-2026-05-29-r2 | none | `README.md`; `design.md`; `v5-readiness.md`; `validation.csv`; `validation-loop.csv`; `visual-output-register.csv`; V5 standard reference | none | provenance_stub | pending_measurement | unreviewed | Records absence of external-tool work; future CAD/render sessions must add rows before any artifact claims authority. |
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) + OpenSCAD CLI | design.md §4 build table, drawing-brief.md Sheet 03 position grid | cad/wood-shell-tongue-drum.scad | cad_authoring | pending_measurement | self_checked | Parametric shell + soundboard envelope, tongue position/length layout reference marks from the 11-tongue A Kurd schedule. Slit-routing cut geometry and gu port placement intentionally out of scope (no cut-path/position source). OpenSCAD render check: pass (openscad -o STL, exit 0). |
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) | wolfram/wood-shell-tongue-drum-wolfram-model.wl (pre-existing, merged via PR #8) | visual-output-register.csv | packet_refresh | derived_preview | unreviewed | Added missing register row (WL-002) for the pre-existing Wolfram model; source-only, not executed by this pass. |
