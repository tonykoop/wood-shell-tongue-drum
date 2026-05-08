# Validation Report — Wood Shell Tongue Drum

Generated during the v4 public-readiness pass on 2026-05-08.

## Clean Checks

| Gate | Result |
|------|--------|
| Required Mode A files present | Pass |
| README is instrument-specific and includes hero drawing | Pass |
| Parametric design source exists | Pass (`wood-shell-tongue-drum-design-table.xlsx`) |
| BOM, sourcing, cut list, validation CSVs present | Pass |
| Assembly, RFQ, visual BOM, photo shot list present | Pass |
| Risk register exists with acoustic, structural, ergonomic, supply, and finish risks | Pass |
| Build-log site exists | Pass (`site/index.html`) |
| Print packet PDF exists | Pass |
| Capstone markdown exists | Pass |

## Fixed In This Pass

| Finding | Files updated | Resolution |
|---------|---------------|------------|
| Gu-port tuning direction was reversed in several notes | `design.md`, `README.md`, `assembly-manual.md`, `risks.md`, `validation.csv`, `site/index.html` | Clarified that increasing port area raises Helmholtz frequency; under-coupled V2/V4 variants need a larger effective port or revised neck/cavity model |
| CNC/laser/jig strategy was present but scattered | `cnc/README.md`, `cnc/jig-and-template-plan.md` | Added a single fixture/template decision matrix for public review |
| README status undersold generated packet outputs | `README.md` | Marked capstone markdown and printable packet outputs as complete; noted that PPTX refresh needs python-pptx |

## Escalated / Human-Owned

| Gate | Remaining action |
|------|------------------|
| Physical tuning validation | Build V1 Standard 16 in prototype; fill `measured_value`, `cents_error`, and environment fields in `validation.csv` |
| Supplier facts | Re-check current price, stock, shipping, and substitutes before buying |
| Capstone PPTX refresh | Existing `capstone-deck.pptx` is retained, but the local generator did not refresh PPTX because python-pptx is unavailable in this environment |
| CAD and G-code | Generate only after Phase 1 measurements calibrate Padauk K, rim seal behavior, and Helmholtz end correction |
| Real photos/audio | Replace concept/SVG placeholders with shop process photos, final instrument photos, and tuning recordings after build |
