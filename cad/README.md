# CAD — Wood Shell Tongue Drum

This folder holds the SolidWorks parametric assembly and any exported neutral-format files (STEP, IGES, STL) for the wood shell tongue drum family.

## Status

**Empty at first commit.** SolidWorks files are produced after the first prototype's measurements are folded back into the workbook so the CAD reflects calibrated, not estimated, dimensions.

## Planned contents

```
cad/
├── README.md                    (this file)
├── wood-shell-tongue-drum.SLDASM        — top-level family assembly
├── parts/
│   ├── shell-cylinder.SLDPRT            — V1, V2 body
│   ├── shell-hemisphere.SLDPRT          — V3, V4 body
│   ├── soundboard-flat.SLDPRT           — V1, V3 top
│   ├── soundboard-domed.SLDPRT          — V2, V4 top
│   ├── stave-template.SLDPRT
│   ├── ring-segment-template.SLDPRT
│   └── gu-port-feature.SLDPRT
├── design-table/
│   └── wood-shell-tongue-drum-design-table.xlsx  — symlink to repo root
├── exports/
│   ├── v1-standard-16.step               — for KiCad/Fusion interop
│   ├── v1-standard-16.stl                — for 3D-print prototype shells
│   └── soundboard-tongue-field.dxf       — for laser-cut tongue layout templates
└── sw-reference/
    └── (Pack-and-Go bundles for derived family members)
```

## SolidWorks workflow

The assembly is **driven by the parametric workbook** (`wood-shell-tongue-drum-design-table.xlsx`) at the repo root. Per `references/solidworks-integration.md` in the parent instrument-maker skill, the workflow is:

1. Open `wood-shell-tongue-drum.SLDASM` in SolidWorks.
2. The design table is linked via External Reference. SolidWorks reads the size-preset block (rows 179–195) on rebuild.
3. Change a preset cell in the workbook; rebuild the assembly; geometry updates.
4. Run the `Extract_Dimensions.swp` macro (in `assets/solidworks/` of the parent skill) to dump every dimension to a CSV.
5. Run `python3 scripts/ingest_dimension_csv.py --csv ... --workbook ...` from the parent skill to validate SW dimensions vs Excel design table within ± 0.5 % tolerance.

A MasterLayout pattern (per Tony's standard) keeps geometry coherent across V1 → V4 by sharing the shell-OD, shell-height, and soundboard-thickness sketches.

## Why CAD is deferred

The first prototype is V1 Cylinder + Flat Top, Standard 16″ — a geometry that is fully specified by the workbook formulas and the cut-list dimensions. Stave geometry, lathe truing, and rabbet joint can all be built from the cut-list alone. CAD becomes load-bearing when:

1. We need 3D-surface toolpaths for V2/V4 dome work (fed to Fusion CAM).
2. We want to pre-visualize the segmented bowl ring stack for V3/V4.
3. The polychrome-segment aesthetic requires per-segment color planning.

Until then, the workbook drives the build and CAD ships when its leverage justifies its production cost.

## Cross-references

- Parametric source: [`../wood-shell-tongue-drum-design-table.xlsx`](../wood-shell-tongue-drum-design-table.xlsx)
- Drawing brief (what the SVGs will show): [`../drawing-brief.md`](../drawing-brief.md)
- CNC toolpath plan: [`../cnc/README.md`](../cnc/README.md)
- SolidWorks workflow reference: [`tonykoop/instrument-maker`](https://github.com/tonykoop/instrument-maker) → `references/solidworks-integration.md`
