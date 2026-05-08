# Visual BOM — Photo shotlist for the BOM hero plate

A Visual BOM lays out every part for one drum on a flat surface against a clean backdrop and labels the parts with quantities, IDs, and final cost. The result is a single hero-style photograph that serves as the cover image for the build-log site, the printable shop packet, and the recruiter-facing deck.

## Hero shot — V1 Standard 16″ (recommended first prototype)

**Frame:** top-down, 4:5 portrait orientation, shop-tabletop or seamless butcher-paper backdrop (warm neutral — kraft or off-white).

**Lighting:** one diffused softbox at 45° camera-left, slight bounce-fill from camera-right.

**Layout** (top-down grid, parts arranged left-to-right by build phase):

```
Row 1 — Body
  [16 stave blanks fanned in a circle]   [shell after lathe-turning, set on rim]   [rabbet detail close-up]

Row 2 — Soundboard
  [Padauk disc with slit pattern routed]  [1/8" upcut spiral bit]  [tongue length schedule card]

Row 3 — Tuning hardware (sparse)
  [step drill bit]  [Buna-N O-ring]  [Korg OT-120 tuner]

Row 4 — Finish + accessory
  [Watco Danish Oil]  [Renaissance Wax]  [pair of mallets]  [felt foot pads]
```

Caption: `Wood Shell Tongue Drum — V1 Cylinder + Flat Top, Standard 16″ — Heifer Zephyr Instruments — Total BOM ~$XXX`. Plug the actual rolled-up sum from `bom.csv` extended_cost column for V1+Standard rows.

## Detail shots — shared across variants

1. **Stave miter** — close-up of one stave edge showing 11.25° bevel against a digital protractor. Side-lit to emphasize the angle.
2. **Tongue slit** — extreme close-up of one slit-and-tongue, top-down, showing kerf width and the slit terminus geometry. Side-lit.
3. **Rabbet joint** — section view of the rabbet with the soundboard half-engaged. Highlights the air-seal surfaces.
4. **Gu port** — bottom view of the shell with the step-drilled port; ruler in frame for scale.
5. **Bowl ring stack** (V3/V4 only) — one of the graduated rings photographed flat against the backdrop, showing 12-segment construction with the 15° miters.
6. **Domed soundboard** (V2/V4 only) — 3/4 angle showing the dome rise on the Padauk blank after CNC surfacing; light raking across the curve to show the parabolic profile.

## Variant comparison shot (after Phases 1–4)

After all four variants are built, one final group shot:

- V1, V2, V3, V4 in a row at Standard 16″ size, soundboards facing camera, 3:2 landscape orientation.
- Backdrop: dark-gray seamless or wood floor.
- Lighting: two softboxes at 45° each side, slightly above eye level.
- Caption: `Heifer Zephyr Wood Shell Tongue Drum — V1 → V4 Family — All Standard 16″, A Kurd`.

This becomes the hero on the build-log site (`site/index.html`) once all four variants ship.

## Process / progression montage

A 4 × 2 grid of in-shop process shots illustrating the build sequence:

1. Stave glue-up under ratchet straps
2. Lathe-truing the OD
3. CNC routing the tongue slits in Padauk soundboard
4. Rabbet joint assembly with cauls
5. Gu-port step-drilling with mic + tuner in frame
6. Tongue tuning with sanding bar and Korg
7. Final finish — Danish Oil application
8. Hero shot of the finished V1 Standard

This montage anchors the build-log site mid-page and serves as the printable packet's "build workflow" foldout.

## Constraints

- All photographs must show **the actual instrument and parts**, not concept renders. The concept sheet in `concepts/` is for ideation; the BOM hero is for documentation.
- Dimensions in caption text must match `bom.csv` and `cut-list.csv` exactly. Any drift is a packet-validation failure.
- No props that aren't part of the BOM. Parts should look like a clean inventory, not a styled lifestyle shot.
- Shot list updates: as builds complete, replace each Required cell with a real path (`images/IMG-XXXX.jpg`) and mark Status = Captured.
