# Resources

## Local Packet Sources

- `wood-shell-tongue-drum-design-table.xlsx` - workbook source for the 4-variant x 3-size family.
- `design.md` - governing model, family matrix, and recommended prototype logic.
- `validation.csv` - predicted targets plus the measurement plan that retires the current unknowns.
- `drawing-brief.md` and `cnc/jig-and-template-plan.md` - manufacturable review surface before full CAD exists.

## Instrument-Maker References Used

- `instrument-maker/skills/v4/instrument-maker-v4/references/new-instruments-v4.md` - family definition for the wood shell tongue drum.
- `instrument-maker/skills/v4/instrument-maker-v4/references/acoustic-models.md` - cantilever and Helmholtz formulas plus empirical-correction guard rules.
- `instrument-maker/skills/v4/instrument-maker-v4/references/manufacturing-and-cnc.md` - router, lathe, fixture, and shop-planning guidance.
- `instrument-maker/skills/v4/instrument-maker-v4/references/sourcing-and-production.md` - BOM, RFQ, validation, and packet-language standards.
- `instrument-maker/skills/v4/instrument-maker-v4/references/solidworks-integration.md` - honest SolidWorks handoff expectations for when CAD becomes load-bearing.

## Sister Repos

- `tongue-drum` - canonical cantilever-idiophone reference and DoE tuning precedent.
- `steel-tongue-drum` - steel cantilever cousin with the same broad tuning workflow but different material constants.
- `ceramic-tongue-drum` - vessel-style cousin that shares the cavity-coupling logic while changing the material pipeline.
- `conga` and `ashiko-drum-workshop` - shell-construction references for stave and segmented drum bodies.

## Public-Safe Notes

- This repo is planning-grade documentation, not a claim of a measured or commercially proven product.
- Current Helmholtz ratios, dome multipliers, and K constants should be read as derived estimates until prototype data lands in `data/` and `validation.csv`.
- Supplier facts, prices, and stock should be re-checked at purchase time.
