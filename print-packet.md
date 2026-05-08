# Wood Shell Tongue Drum Capstone Print Packet

Generated: 2026-05-07
Packet folder: `/sessions/practical-ecstatic-edison/mnt/GitHub/wood-shell-tongue-drum`

## File Map

| File | Purpose |
| --- | --- |
| `design.md` | Project intent, catalog metadata, assumptions, and validation plan. |
| `bom.csv` | Starter bill of materials with part categories, quantities, drawing refs, and notes. |
| `sourcing.csv` | Supplier/search tracker with specs, price/date fields, lead time, substitutes, and risks. |
| `cut-list.csv` | Rough/final stock sizes, material, grain/orientation, operations, yield, and offcuts. |
| `drawing-brief.md` | Manufacturing drawing and technical product sketch brief. |
| `assembly-manual.md` | Shop-facing sequence, tools, fixtures, safety, tuning, finishing, and maintenance notes. |
| `validation.csv` | Target/measured values, tolerance, environment, result, and tuning/build action log. |
| `supplier-rfq.md` | Supplier email/request-for-quote starter. |
| `visual-bom-brief.md` | Art direction for an image-forward visual BOM. |
| `wolfram-starter.wl` | Wolfram starter for physics, optimization, visualization, and validation. |
| `README.md` | Project artifact. |
| `photo-shotlist.md` | Project artifact. |
| `risks.md` | Project artifact. |

<div class="page-break"></div>

## design.md

Project intent, catalog metadata, assumptions, and validation plan.

# Wood Shell Tongue Drum — Parametric Design Sheet

**Owner:** Tony Koop · Heifer Zephyr Instruments
**Family:** Slit-tongue idiophone with enclosed wooden resonator (round-body)
**Members:** four geometric variants (V1–V4) × three size envelopes (Travel 12″, Standard 16″, Floor Pouf 20″)
**Status:** Design v1 — formulas parametric in `wood-shell-tongue-drum-design-table.xlsx`; no physical prototype yet
**Recommended first prototype:** **V1 Cylinder + Flat Top, Standard 16″, A Kurd**

---

## 1. Intent

This is the round-body counterpart to Tony's existing rectangular-prism wood tongue drum. A wooden shell — cylinder or hemisphere — capped by a tonewood soundboard with CNC-cut slit tongues, tuned to a chosen scale, is a modern instrument category that does not exist commercially in this round-body × dome-top × premium-tonewood format. The enclosed cavity adds **Helmholtz resonance** that an open rectangular tongue drum cannot offer — warm bass coupling beneath the lowest tongue.

The sheet treats this as a *family with four variants* rather than as four separate designs. All twelve cells (4 variants × 3 sizes) are driven by the same shared inputs: shell OD, shell height, soundboard thickness/wood, gu-port diameter, dome rise. Change one preset cell in the workbook and every dimension in the matrix updates.

| ID  | Body            | Top         | Notes                                                                  |
|-----|-----------------|-------------|------------------------------------------------------------------------|
| V1  | Cylinder        | Flat        | Lowest piece-count, most predictable tuning. **Start here.**           |
| V2  | Cylinder        | Domed       | Steel-tongue-drum aesthetic on a wooden body                            |
| V3  | Hemisphere bowl | Flat        | Tagine / Moroccan-pouf silhouette; bowl as parabolic reflector          |
| V4  | Hemisphere bowl | Domed       | Most steel-tongue-drum-adjacent silhouette in wood; near-spherical      |

| Size           | OD (in) | Height (in) | Soundboard (in) | Tongue width (in) | Target ding | Ding f (Hz) |
|----------------|---------|-------------|-----------------|-------------------|-------------|-------------|
| Travel         | 12      | 5           | 0.250           | 1.00              | D4 (MIDI 62)| 293.66      |
| Standard       | 16      | 8           | 0.375           | 1.25              | A3 (MIDI 57)| 220.00      |
| Floor Pouf     | 20      | 10          | 0.500           | 1.50              | D3 (MIDI 50)| 146.83      |

(All values in this document are computed from the workbook formulas, not pasted by hand. If you change the workbook, regenerate the BOM and validation CSVs.)

---

## 2. Governing acoustic model

The wood shell tongue drum is a **two-degree-of-freedom coupled oscillator**: the cantilever tongue is one resonator, the enclosed air cavity is another, and they share a common boundary (the soundboard).

### 2.1 Tongue — flat cantilever (Euler–Bernoulli)

For a slit tongue of length `L` (in) and thickness `t` (in) in wood with cantilever K-constant `K` (imperial composite):

```
f = K · t / L²              (flat top, Variants 1 and 3)
L = √( K · t / f )
```

Tony's material library (workbook §A, rows 19–25) records measured / literature K-constants for shop tonewoods:

| Wood          | E (GPa) | ρ (kg/m³) | K (cantilever) | Tone               | Rating |
|---------------|---------|-----------|----------------|--------------------|--------|
| Padauk        | 11.0    | 745       | 24,438         | warm, rich, sustain| ★★★★★ |
| Wenge         | 15.8    | 870       | 27,103         | bright, punchy     | ★★★★★ |
| Cherry        | 10.3    | 560       | 27,275         | balanced sweet mid | ★★★★  |
| Black Walnut  | 11.6    | 610       | 27,734         | full, mellow       | ★★★★  |
| Hard Maple    | 12.6    | 705       | 26,887         | bright sustain     | ★★★★  |
| Mahogany      | 10.1    | 590       | 26,314         | warm, full bass    | ★★★★  |
| W. Red Cedar  |  7.7    | 370       | 29,013         | light, guitar-like | ★★★   |

Padauk K = 24,438 is the lowest in the library and therefore yields the longest tongues for a given pitch — the design defaults to Padauk because it is most permissive of fitting low pitches in a given shell radius.

### 2.2 Tongue — curved cantilever (V2, V4)

A tongue cut into a domed soundboard is stiffer than a flat tongue. To preserve pitch we apply an empirical length correction:

```
L_curved = L_flat · 1.025         (+2.5 % for shallow domes, dome rise ≤ 6 % of OD)
```

This is a **starting estimate**, not a measured constant. The dominant uncertainty in V2 and V4 is whether 1.025 holds for our specific dome rise. Validation protocol: tap-tune one tongue at the design length, measure with a tuner, back-solve the actual factor, then apply to the remaining ten tongues. Treat the +2.5 % multiplier as *the empirical-learning loop's first measurement*.

### 2.3 Cavity — Helmholtz resonator

For an enclosed chamber of volume `V` (in³) with port area `A_port` (in²) and effective neck length `L_neck` (in):

```
f_H = (c / 2π) · √( A_port / (V · L_neck) )           with c = 13,552 in/s
```

Chamber volume formulas, by variant:

| Variant | Body shape         | Cavity volume formula                              |
|---------|--------------------|----------------------------------------------------|
| V1      | Cylinder, flat top | `V = π · r² · H`                                   |
| V2      | Cylinder + dome    | `V = π · r² · H + (2/3) · π · r² · h_dome`         |
| V3      | Hemisphere, flat   | `V = (2/3) · π · r³`                               |
| V4      | Hemisphere + dome  | `V = (2/3) · π · r³ + (2/3) · π · r² · h_dome`     |

Effective neck length:

| Top type | `L_neck`                         |
|----------|----------------------------------|
| Flat     | soundboard thickness `t`         |
| Domed    | `t + h_dome / 2`                 |

The **Helmholtz target** is `f_H ≤ f_ding` — the cavity should resonate at or below the lowest tongue, so it acts as a bass extension rather than a competing pitch. Coupling falls into one of three regimes:

- `f_H / f_ding < 0.8` — free bass extension; cavity reinforces below the ding (good for floor pouf).
- `0.8 ≤ f_H / f_ding ≤ 1.2` — coupled regime; cavity and ding share modal energy (the design target).
- `f_H / f_ding > 1.2` — cavity sits above the ding; cavity will fight the ding rather than support it. **Mistuned** — fix by enlarging the gu port (raises `f_H`) or shrinking it (lowers `f_H`).

The **gu port diameter** is the primary tuning knob. It is drilled last, deliberately undersized, and opened up incrementally with a step bit while measuring `f_H` (gentle puff at the port, microphone above). This is the same field-tuning method used on Hapi-style steel tongue drums.

### 2.4 Computed Helmholtz / ding ratios (current presets)

Each cell below is `f_H` (Hz) computed from the formulas above with the current size-preset inputs, and the ratio against `f_ding` for that size. Bold cells sit in the coupled regime (0.8 ≤ ratio ≤ 1.2) — that is the buildable matrix.

| Variant | Travel 12″ (D4 ding 293.66 Hz)    | Standard 16″ (A3 ding 220.00 Hz)   | Floor Pouf 20″ (D3 ding 146.83 Hz) |
|---------|-----------------------------------|------------------------------------|-------------------------------------|
| V1      | 321.5 Hz · ratio **1.09** (tight) | **194.6 Hz · ratio 0.88**          | **144.7 Hz · ratio 0.99**           |
| V2      | 220.1 Hz · ratio 0.75             | 133.5 Hz · ratio 0.61 (under-coup) | 99.1 Hz · ratio 0.67 (under-coup)   |
| V3      | 359.5 Hz · ratio 1.22 (over)      | **238.3 Hz · ratio 1.08**          | 177.2 Hz · ratio 1.21 (over, edge)  |
| V4      | 244.2 Hz · ratio 0.83             | 161.1 Hz · ratio 0.73              | 119.5 Hz · ratio 0.81               |

Reading the matrix: **V1 Standard 16″ and V1 Floor Pouf 20″ are in the sweet spot**; V3 Standard 16″ is also coupled. V2 cells are systematically under-coupled because the dome adds neck length without proportional volume — they will need a *smaller* gu port than the preset 2.5″ to lift `f_H`. V1 Travel 12″ is right at the upper edge of the coupled band.

These values are **derived estimates**, not measured. They will shift once the first prototype is tuned and the per-family corrections database is populated.

### 2.5 Tongue-fit cap

For each size, the longest tongue (the ding) cannot exceed the radial fit cap:

```
L_cap = OD/2 − 1″                  (1″ reserved for ding-strike clearance and rim)
```

| Size        | Cap (in) | V1/V3 ding length (in) | V2/V4 ding length (in) | Verdict             |
|-------------|----------|------------------------|------------------------|---------------------|
| Travel 12″  | 5.00     | 4.56 (D4)              | 4.68 (D4)              | Fits — 9 % margin   |
| Standard 16″| 7.00     | 6.45 (A3)              | 6.62 (A3)              | Fits — 8 % margin   |
| Floor Pouf  | 9.00     | 9.12 (D3)              | 9.35 (D3)              | **Doesn't fit**     |

Floor Pouf D3 ding overhangs by 0.12″ on flat tops and 0.35″ on domed tops. **Mitigation:** raise the ding to D♯3 (one semitone, MIDI 51, 155.6 Hz → flat L = 8.86″, fits with 0.14″ margin) OR thin the soundboard from 0.5″ → 0.4375″ (drops L to 8.53″, clean 0.47″ margin) OR substitute Cedar (K = 29,013 → flat L = 8.34″, 0.66″ margin). Cedar is the recommended fix because the soundboard span across 20″ wants stiffness against deflection, and Cedar's lower density lets the same thickness still bear the span.

---

## 3. Variant blocks — manufacturing and acoustic notes

Each block extends the workbook's §C–§F by spelling out the *manufacturing path* implied by the geometry.

### V1 — Ottoman Cylinder, Flat Top  ★ RECOMMENDED FIRST BUILD

**Body construction:** stave-built or segmented cylinder. The two paths are equally valid:

- **Stave shell**: 16 staves at 11.25° miter (180/16). Rip from 4/4 stock, joint edges, band-clamp glue-up around an MDF cylinder mold. Lathe-true OD/ID after cure (≥ 24 h). Wall thickness after turning: 5/8″–3/4″.
- **Segmented shell** (used when polychrome inlay is desired): 8 rings × 12 segments at 15° miter. Stack rings on a lazy-susan jig for glue-up. Diamond pattern with Walnut + Maple + Cherry accents reads beautifully on the Ottoman 16″ size.

**Top construction:** flat tonewood disc, CNC-cut to OD and edge-rabbeted ¼″ deep into the shell rim. Slits routed *before* glue-up so the tongues vibrate without router stress. Disc diameter = shell OD; thickness from preset.

**Tongue physics:** standard flat cantilever. Empirical detuning ≤ 1 % observed on Tony's prior rectangular drums — trust the model.

**Risk / Difficulty:** ★★ — proven flat-cantilever physics + well-trodden stave/segmented bowl method. Lowest risk in the matrix.

### V2 — Ottoman Cylinder, Domed Top

**Body construction:** same as V1.

**Top construction:** glue-up blank (3 plies × ~0.5″ = 1.5″ thick), flatten on jointer, then 3D-surface a parabolic dome (rise = preset 0.75″ on Standard) on the CNC. Bottom contour matches OD rim. Tongue slits cut afterward in one of two ways: (a) 1/8″ upcut spiral on a B-axis sled that tracks the dome curvature (preferred — preserves the dome face) or (b) flatten a sacrificial fixture under the dome to support tongue ends, then route slits with a regular 3-axis pass.

**Tongue physics:** curved cantilever stiffer than flat. The +2.5 % length correction is built into the workbook. Validate empirically: tap-tune ONE tongue and back-fit the multiplier *before* cutting all 11.

**Risk / Difficulty:** ★★★ — adds dome-surfacing risk and curved-cantilever uncertainty. Prototype the dome in poplar before committing Padauk.

### V3 — Hemisphere Bowl, Flat Top

**Body construction:** segmented (ring-stack of decreasing diameters approximating a hemisphere) or thick-glue-up CNC-carved hemisphere. Either path requires lathe-true rim flatness — the bowl-to-soundboard joint is acoustically critical.

**Top construction:** flat soundboard disc (same as V1). The shell rim must be precisely circular and planar — turn the rim true on the lathe *after* segment glue-up. Rabbet for the board is ¼″ deep.

**Tongue physics:** same flat cantilever as V1. The bowl shape doesn't affect tongue physics, only the Helmholtz coupling and projection pattern (the bowl acts as a parabolic reflector, projecting tongue energy upward through the slits).

**Risk / Difficulty:** ★★ — bowl turning is straightforward at 12–16″; > 18″ needs a lathe with ≥ 10″ swing over bed.

### V4 — Hemisphere Bowl, Domed Top

**Body construction:** glued bowl (segmented or stave) + glue-up dome blank, both 3D-surfaced on the CNC. Half-lap or rabbet joinery at the rim. Final assembly clamps with a custom radius caul.

**Top construction:** same dome workflow as V2.

**Tongue physics:** curved cantilever +2.5 % correction (same as V2). The flat → curved physics shift is the dominant uncertainty in V4; budget extra prototype tongues.

**Risk / Difficulty:** ★★★★ — highest piece-count + highest empirical tuning risk. Most beautiful result; **build last**.

---

## 4. Recommended first prototype — V1 Cylinder + Flat Top, Standard 16″

This is the **strongly recommended starting build**. Justification:

1. **Acoustic predictability.** Flat-cantilever physics has < 1 % empirical detuning on Tony's prior rectangular drums; the dome correction in V2/V4 is unmeasured.
2. **Helmholtz already coupled.** Standard 16″ V1 sits at `f_H / f_ding = 0.88` — inside the coupled band by design, with the gu port (2.5″) as the in-shop tuning knob if the measured ratio drifts.
3. **All 11 tongues fit cleanly.** Longest tongue (A3 ding) = 6.45″ vs the 7″ radial cap → 8 % margin. No risk of running out of soundboard.
4. **Lowest piece-count.** 16 staves + 1 disc = 17 wood pieces. Compare V4 segmented-bowl-plus-dome at 96+ pieces.
5. **Dual-path body construction.** If staves don't inspire the maker, the same shell can be built segmented for polychrome aesthetics (see V1 body construction notes).
6. **Validated workflow components.** Stave glue-up, lathe truing, CNC slit routing — all are skills exercised on Tony's existing ashiko, conga, and tongue-drum repos.

**Specific prototype build configuration:**

| Parameter         | Value                                                              |
|-------------------|--------------------------------------------------------------------|
| Shell OD          | 16.00″                                                             |
| Shell height      | 8.00″                                                              |
| Shell wood        | Black Walnut, 4/4 stock, 16 staves at 11.25° miter                |
| Wall thickness    | 0.625″ finished (after lathe truing)                               |
| Soundboard wood   | Padauk (K = 24,438)                                                |
| Soundboard thk    | 0.375″ (3/8″)                                                      |
| Disc diameter     | 16.00″ (rabbet ¼″ deep × ⅜″ wide into shell rim)                   |
| Scale             | A Kurd (A3, B3, C4, D4, E4, F4, G4, A4, B4, C5, D5)                |
| Ding              | A3 (220.00 Hz), centered                                           |
| Number of tongues | 11 (1 ding + 10 in zigzag-ascending pattern)                       |
| Slit kerf width   | 0.125″ (1/8″ CNC upcut spiral)                                     |
| Tongue width      | 1.25″                                                              |
| Gu port Ø         | 2.5″ initial; final size set by Helmholtz tuning                   |
| Predicted f_H     | 194.6 Hz (0.88 × ding)                                             |

**Tongue length schedule** (Padauk 0.375″, A Kurd transposed from workbook §A reference scale):

| #    | Note | MIDI | Freq (Hz) | L (in) | L (mm) |
|------|------|------|-----------|--------|--------|
| Ding | A3   | 57   | 220.00    | 6.454  | 163.93 |
| 1    | E4   | 64   | 329.63    | 5.273  | 133.93 |
| 2    | F4   | 65   | 349.23    | 5.123  | 130.12 |
| 3    | G4   | 67   | 392.00    | 4.835  | 122.81 |
| 4    | A4   | 69   | 440.00    | 4.564  | 115.92 |
| 5    | B4   | 71   | 493.88    | 4.308  | 109.41 |
| 6    | C5   | 72   | 523.25    | 4.185  | 106.30 |
| 7    | D5   | 74   | 587.33    | 3.950  | 100.33 |
| 8    | E5   | 76   | 659.26    | 3.728  |  94.70 |
| 9    | G5   | 79   | 783.99    | 3.419  |  86.84 |
| 10   | A5   | 81   | 880.00    | 3.227  |  81.97 |

(These are *cut lengths* of the slit, not the kerf. The CNC pocketing geometry — radial slit + perpendicular tongue-base relief — is detailed in `drawing-brief.md` and `cnc/README.md`.)

---

## 5. Build sequence — phases across the family

Phases are designed so each one produces a finished, playable instrument *and* a measurement that informs the next phase. This is the empirical-learning loop running across the four-variant matrix.

| Phase | Build                          | What it teaches                                                                                  |
|-------|--------------------------------|--------------------------------------------------------------------------------------------------|
| 1     | **V1 Standard 16″** ★ HERE      | Shell stave construction, soundboard rabbet joint, gu-port tuning, Helmholtz coupling — all in one go. Confirms `f_H` model against measurement. |
| 2     | V2 Standard 16″ (same shell)   | Curved-cantilever +2.5 % correction. Reuse Phase-1 cylinder shell — only the soundboard changes. Quantifies the dome correction factor.        |
| 3     | V3 Standard 16″                | Hemisphere-bowl construction independent of dome work. Now we know flat-top + bowl independently. |
| 4     | V4 (Standard 16″ or Floor 20″) | Combine learnings. Premium tonewoods, signature Heifer Zephyr finish.                            |
| 5     | V1 Travel 12″                  | Tightest tongue-fit margins; build last when the formulas are calibrated to your shop.            |

This sequence delivers four distinct portfolio instruments while progressively retiring acoustic risk. Each phase's measurements feed back into `validation.csv` and the per-family corrections in the workbook.

---

## 6. Critical joints and tolerances

| Joint                      | Tolerance         | Why                                                              |
|----------------------------|-------------------|------------------------------------------------------------------|
| Shell rim flatness         | ± 0.005″ TIR     | Bowl-to-soundboard joint is the primary air seal (Helmholtz Q)   |
| Soundboard rabbet fit      | 0.005″ slip-fit  | Tight enough for PVA bond, loose enough to avoid prying          |
| Stave miter angle          | 11.25° ± 0.1°    | A 0.5° error compounds over 16 staves to a 8° total deviation    |
| Slit kerf width            | 0.125″ ± 0.005″  | Wider kerfs lower tongue Q (energy leaks through the kerf)       |
| Tongue length (per cut)    | + 0.030″ initial | Cut long; file to pitch with a sanding bar (file shortens → raises pitch) |
| Gu port concentricity      | ± 0.025″         | Off-center port shifts effective neck length and `f_H`            |
| Wall thickness uniformity  | ± 0.030″         | A wedge-shaped wall makes the cavity asymmetric — kills bass      |

---

## 7. Open questions and assumptions (red-team flagged in `risks.md`)

The design table is parametric, but the following are **derived estimates** that need first-prototype measurements to harden:

- **Padauk K = 24,438** is from the workbook's material library, derived from textbook E and ρ values. Not measured on Tony's specific stock.
- **Curved-cantilever +2.5 %** correction is a starting estimate from cylinder-shell theory at small radii. The actual factor for our specific dome rise (0.75″ on Standard) is unmeasured.
- **Wall thickness** of 0.625″ is conventional but un-tuned — Helmholtz Q depends on wall stiffness.
- **Bowl-top joint type.** Three options compete (rabbet flush, lap step, cork gasket). Rabbet flush is the working assumption; the others are validation B/C plans if the rabbet leaks.
- **Slit kerf cap of 50 % of soundboard area** is a structural rule of thumb, not a measured failure threshold.
- **Effective neck length on V1 = soundboard thickness alone.** This ignores the air "plug" oscillating just below the slit. The end correction is small for tongue-drum kerfs (kerfs are slits, not circular ports), and we're absorbing the error into the 0.88-ratio safety margin. If `f_H` measures 5–10 % low on first prototype, this is the likely cause.

---

## 8. Cross-references

- **Workbook**: [`wood-shell-tongue-drum-design-table.xlsx`](wood-shell-tongue-drum-design-table.xlsx) — single sheet, 249 rows, 190 formulas. Blue cells are inputs; everything else recomputes.
- **Concept sheet**: [`concepts/round-body-variants_concept-sheet.png`](concepts/round-body-variants_concept-sheet.png) — visual layout of all twelve cells.
- **BOM, sourcing, cut list, validation**: see the four CSVs at repo root.
- **Risks**: see [`risks.md`](risks.md) for the red-team pass with verification tests attached.
- **Wolfram exploration**: see [`wolfram-starter.wl`](wolfram-starter.wl) for the 3-DOF coupled oscillator (tongue + shell + air cavity) starter.
- **Sister repos**: [`tongue-drum/`](https://github.com/tonykoop/tongue-drum) (rectangular-prism precursor) · [`steel-tongue-drum/`](https://github.com/tonykoop/steel-tongue-drum) (steel cantilever cousin) · [`ceramic-tongue-drum/`](https://github.com/tonykoop/ceramic-tongue-drum) (slip-cast cousin) · [`ashiko-drum-workshop/`](https://github.com/tonykoop/ashiko-drum-workshop) (segmented bowl reference) · [`conga/`](https://github.com/tonykoop/conga) (stave & segmented shell reference).
- **Catalog**: [`tonykoop/instrument-maker`](https://github.com/tonykoop/instrument-maker) — orchestrating skill and Master Catalog.

<div class="page-break"></div>

## bom.csv

Starter bill of materials with part categories, quantities, drawing refs, and notes.

| part_id | description | variant | size | quantity | unit | unit_cost_usd | extended_cost_usd | critical | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| SHELL-STAVE-WALNUT-T | Black Walnut stave, 4/4 stock, 6.5in length | V1+V2 | Travel 12in | 16 | each | 3.00 | 48.00 | Y | Rip from 4/4; bevel 11.25 deg both edges; sand inside to 220 |
| SHELL-STAVE-WALNUT-S | Black Walnut stave, 4/4 stock, 9.5in length | V1+V2 | Standard 16in | 16 | each | 4.50 | 72.00 | Y | Rip from 4/4; bevel 11.25 deg both edges. Recommended first prototype. |
| SHELL-STAVE-WALNUT-F | Black Walnut stave, 4/4 stock, 11.5in length | V1+V2 | Floor Pouf 20in | 16 | each | 5.50 | 88.00 | Y | Rip from 4/4; bevel 11.25 deg both edges |
| SHELL-SEG-WALNUT-T | Black Walnut segment blank, 4/4 stock, 4 in piece | V1+V2 (alt) | Travel 12in | 96 | each | 0.50 | 48.00 | N | Alt body: 8 rings x 12 segments, 15 deg miter. Skip if building stave. |
| SHELL-SEG-WALNUT-S | Black Walnut segment blank, 4/4 stock, 5 in piece | V1+V2 (alt) | Standard 16in | 96 | each | 0.65 | 62.40 | N | Alt body: 8 rings x 12 segments. Skip if building stave. |
| SHELL-SEG-WALNUT-F | Black Walnut segment blank, 4/4 stock, 6 in piece | V1+V2 (alt) | Floor Pouf 20in | 96 | each | 0.80 | 76.80 | N | Alt body: 10 rings x 12 segments. Skip if building stave. |
| BOWL-SEG-WALNUT-T | Black Walnut segment blank, 4/4 stock (graduated rings) | V3+V4 | Travel 12in | 72 | each | 0.55 | 39.60 | N | 6 rings of decreasing dia for hemisphere |
| BOWL-SEG-WALNUT-S | Black Walnut segment blank, 4/4 stock (graduated rings) | V3+V4 | Standard 16in | 96 | each | 0.65 | 62.40 | N | 8 rings of decreasing dia for hemisphere |
| BOWL-SEG-WALNUT-F | Black Walnut segment blank, 4/4 stock (graduated rings) | V3+V4 | Floor Pouf 20in | 120 | each | 0.80 | 96.00 | N | 10 rings of decreasing dia for hemisphere |
| BOWL-BLANK-WALNUT-T | Black Walnut glue-up blank for CNC bowl, 13x13x4 in | V3+V4 (alt) | Travel 12in | 1 | each | 85.00 | 85.00 | N | Alt body: 4x 1in plies. CNC 3D-surface inside and outside. |
| BOWL-BLANK-WALNUT-S | Black Walnut glue-up blank for CNC bowl, 17x17x5 in | V3+V4 (alt) | Standard 16in | 1 | each | 140.00 | 140.00 | N | Alt body: 5x 1in plies. CNC 3D-surface inside and outside. |
| BOWL-BLANK-WALNUT-F | Black Walnut glue-up blank for CNC bowl, 21x21x6 in | V3+V4 (alt) | Floor Pouf 20in | 1 | each | 210.00 | 210.00 | N | Alt body: 6x 1in plies. CNC 3D-surface inside and outside. |
| SOUNDBOARD-PADAUK-T | Padauk soundboard disc, 12.25 in OD, 0.25 in | V1+V3 | Travel 12in | 1 | each | 42.00 | 42.00 | Y | CNC-cut to OD. Slits routed before glue-up. |
| SOUNDBOARD-PADAUK-S | Padauk soundboard disc, 16.25 in OD, 0.375 in | V1+V3 | Standard 16in | 1 | each | 68.00 | 68.00 | Y | CNC-cut to OD. Slits routed before glue-up. Recommended first prototype. |
| SOUNDBOARD-PADAUK-F | Padauk soundboard disc, 20.25 in OD, 0.5 in | V1+V3 | Floor Pouf 20in | 1 | each | 98.00 | 98.00 | Y | CNC-cut to OD. Slits routed before glue-up. Consider Cedar substitute for D3 fit margin. |
| SOUNDBOARD-CEDAR-F-ALT | Western Red Cedar soundboard disc, 20.25 in OD, 0.5 in | V1+V3 alt | Floor Pouf 20in | 1 | each | 55.00 | 55.00 | N | Alternate to Padauk for tight D3 ding fit (K=29013 shortens tongues) |
| DOMEBLANK-PADAUK-T | Padauk dome glue-up blank, 13x13 in, 1.5 in thick (3 plies x 0.5) | V2+V4 | Travel 12in | 1 | each | 75.00 | 75.00 | Y | 3D-surface 0.5 in dome rise on CNC; +2.5% tongue length correction |
| DOMEBLANK-PADAUK-S | Padauk dome glue-up blank, 17x17 in, 1.5 in thick (3 plies x 0.5) | V2+V4 | Standard 16in | 1 | each | 125.00 | 125.00 | Y | 3D-surface 0.75 in dome rise on CNC; +2.5% tongue length correction |
| DOMEBLANK-PADAUK-F | Padauk dome glue-up blank, 21x21 in, 1.5 in thick (3 plies x 0.5) | V2+V4 | Floor Pouf 20in | 1 | each | 180.00 | 180.00 | Y | 3D-surface 1 in dome rise on CNC; +2.5% tongue length correction |
| DOMEBLANK-POPLAR-S | Poplar dome blank for prototype validation, 17x17 in, 1.5 in | V2+V4 proto | Standard 16in | 1 | each | 32.00 | 32.00 | N | Cheap test blank to dial in dome surfacing before Padauk |
| GUE-TITEBOND3 | Titebond III wood glue, 16oz | All | All | 2 | bottle | 18.00 | 36.00 | Y | Waterproof; 4000 psi shear. Rated for tongue-drum service. |
| RABBET-BIT-RBR | Rabbeting router bit set with bearing kit, 1/4 in shank | V1+V3 build | All | 1 | set | 42.00 | 42.00 | N | For shell rim rabbet. One-time tooling buy. |
| SLIT-BIT-UPCUT-1-8 | Solid carbide upcut spiral bit, 1/8 in, 1/4 in shank | All | All | 3 | each | 16.00 | 48.00 | Y | For tongue slits. Buy 3 (one breaks per shell). 1/4 in shank for CNC router collet. |
| BALLEND-3-4 | Ball-end mill, 3/4 in, 1/2 in shank | V2+V4 | All | 1 | each | 38.00 | 38.00 | Y | For dome 3D-surfacing on CNC |
| GU-STEPBIT-3 | Step drill bit, 1/4 to 3 in, 1/4 in increments | All | All | 1 | each | 28.00 | 28.00 | Y | For incremental gu-port enlargement during Helmholtz tuning |
| ORING-RUBBER-25 | Rubber O-ring, 2.5 in ID, 1/8 in cross-section | V1+V3 | Standard 16in | 1 | each | 2.50 | 2.50 | N | Optional gu-port lining for cleaner tone (Hapi-style) |
| ORING-RUBBER-30 | Rubber O-ring, 3 in ID, 1/8 in cross-section | V1+V3 | Floor Pouf 20in | 1 | each | 3.00 | 3.00 | N | Optional gu-port lining |
| ORING-RUBBER-20 | Rubber O-ring, 2 in ID, 1/8 in cross-section | V1+V3 | Travel 12in | 1 | each | 2.00 | 2.00 | N | Optional gu-port lining |
| FELT-FOOT-PADS | Adhesive felt floor-protection pads, 1 in dia | All | All | 4 | each | 0.50 | 2.00 | N | Mount under bowl/cylinder bottom edge |
| HANDLE-ROPE-S | Hemp rope, 0.5 in, for carry handle | All | Standard 16in+ | 4 | ft | 2.50 | 10.00 | N | Pass through two 0.5 in holes drilled in bowl side; knot inside |
| FINISH-DANISH-OIL | Watco Danish Oil, natural, qt | All | All | 1 | each | 28.00 | 28.00 | N | 3 coats, 24h between |
| FINISH-WAX-CARNAUBA | Renaissance Wax, 65ml | All | All | 1 | each | 18.00 | 18.00 | N | Final coat on shell exterior |
| SANDPAPER-SET | Sandpaper assortment 80/120/220/320/400/600 grit | All | All | 1 | set | 32.00 | 32.00 | N |  |
| TUNER-KORG-OT120 | Korg OT-120 wide-range tuner | All | All | 1 | each | 180.00 | 180.00 | N | Shop tool. Already owned in Tony's shop. Listed for cost transparency. |
| MALLET-SET | Tongue drum mallets, soft rubber heads, pair | All | All | 1 | set | 18.00 | 18.00 | N | Player accessory, included with finished drum |

<div class="page-break"></div>

## sourcing.csv

Supplier/search tracker with specs, price/date fields, lead time, substitutes, and risks.

| part_id | supplier | supplier_url | sku_or_search | lead_time_days | moq | verified_price_date | price_volatility | required_spec | search_terms | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| SHELL-STAVE-WALNUT-S | Bell Forest Products | bellforestproducts.com | black walnut 4/4 S2S FAS | 5 | 1 BdFt | 2026-05-07 | low | 4/4 S2S FAS black walnut, edge-jointable | black walnut 4/4 turning blanks | Recommended supplier for shell stock |
| SHELL-STAVE-WALNUT-T | Bell Forest Products | bellforestproducts.com | black walnut 4/4 S2S FAS | 5 | 1 BdFt | 2026-05-07 | low | 4/4 S2S FAS black walnut | black walnut 4/4 |  |
| SHELL-STAVE-WALNUT-F | Bell Forest Products | bellforestproducts.com | black walnut 4/4 S2S FAS | 5 | 1 BdFt | 2026-05-07 | low | 4/4 S2S FAS black walnut | black walnut 4/4 |  |
| SHELL-SEG-WALNUT-S | Cook Woods | cookwoods.com | black walnut 4/4 turning blanks | 4 | 1 | 2026-05-07 | low | Bulk segment-grade walnut blanks | walnut turning blanks 4/4 | Alt source for segmented body |
| BOWL-SEG-WALNUT-S | Cook Woods | cookwoods.com | black walnut 4/4 turning blanks | 4 | 1 | 2026-05-07 | low | Graduated-diameter ring blanks | walnut turning blanks 4/4 |  |
| BOWL-BLANK-WALNUT-S | Cook Woods | cookwoods.com | black walnut 8/4 thick stock | 10 | 1 | 2026-05-07 | medium | 5x 1in plies for CNC bowl glue-up | walnut 8/4 thick | CNC bowl alt path; verify thickness availability |
| SOUNDBOARD-PADAUK-S | Bell Forest Products | bellforestproducts.com | padauk 3/8 figured S4S | 5 | 1 BdFt | 2026-05-07 | medium | Padauk 3/8 in thickness, FAS, edge-quartersawn preferred | padauk 4/4 S4S | Critical: thickness controls tongue length. Verify 3/8 in. Quartersawn improves bend stability. |
| SOUNDBOARD-PADAUK-T | Bell Forest Products | bellforestproducts.com | padauk 1/4 S4S | 5 | 1 BdFt | 2026-05-07 | medium | Padauk 1/4 in thickness, FAS | padauk thin stock |  |
| SOUNDBOARD-PADAUK-F | Bell Forest Products | bellforestproducts.com | padauk 1/2 S4S | 5 | 1 BdFt | 2026-05-07 | medium | Padauk 1/2 in thickness, FAS | padauk 1/2 in |  |
| SOUNDBOARD-CEDAR-F-ALT | Old Growth Music | oldgrowthmusic.com | western red cedar soundboard 1/2 quartersawn | 7 | 1 | 2026-05-07 | medium | WRC 1/2 in quartersawn, A grade | western red cedar soundboard 1/2 | Alt for D3 ding fit on Floor Pouf |
| DOMEBLANK-PADAUK-S | Bell Forest Products | bellforestproducts.com | padauk 4/4 boards (3 boards required) | 5 | 1 BdFt | 2026-05-07 | medium | 3x 1/2in boards, edge-jointable | padauk 4/4 S4S | Glue 3 plies to make dome blank thicker than 1.5 in |
| DOMEBLANK-POPLAR-S | Lowe's | lowes.com | poplar 1x12 board (3 boards) | 1 | 1 | 2026-05-07 | low | 3x poplar boards 1x12x18in | poplar 1x12 | Cheap test stock for dome surfacing rehearsal |
| GUE-TITEBOND3 | Rockler | rockler.com | Titebond III 16oz | 2 | 1 | 2026-05-07 | low | PVA wood glue, waterproof, 4000 psi shear | Titebond III |  |
| RABBET-BIT-RBR | Rockler | rockler.com | rabbeting router bit set with bearing kit | 2 | 1 | 2026-05-07 | low | 1/4 in shank, multi-bearing rabbet kit | rabbeting bit set |  |
| SLIT-BIT-UPCUT-1-8 | Amana Tool | amanatool.com | 46202 1/8in upcut spiral | 3 | 1 | 2026-05-07 | low | Solid carbide, 1/8 in, 1/4 in shank, upcut spiral | Amana 46202 1/8 upcut |  |
| BALLEND-3-4 | Amana Tool | amanatool.com | 46377 3/4 ball nose | 3 | 1 | 2026-05-07 | low | 3/4 in ball nose, 1/2 in shank, solid carbide | Amana 46377 3/4 ball nose |  |
| GU-STEPBIT-3 | Amazon | amazon.com | Irwin Unibit step drill 1/4 to 3 in | 2 | 1 | 2026-05-07 | low | Step bit covering 0.25 to 3 in in 1/4 in increments | step drill bit 1/4 to 3 in |  |
| ORING-RUBBER-25 | McMaster-Carr | mcmaster.com | 9452K42 Buna-N O-ring 2-1/2 ID 1/8 thick | 2 | 1 | 2026-05-07 | low | Buna-N O-ring 2.5 ID, 1/8 cross | O-ring 2.5 in ID 1/8 |  |
| ORING-RUBBER-20 | McMaster-Carr | mcmaster.com | 9452K38 Buna-N O-ring 2 ID 1/8 thick | 2 | 1 | 2026-05-07 | low | Buna-N O-ring 2 ID, 1/8 cross | O-ring 2 in ID 1/8 |  |
| ORING-RUBBER-30 | McMaster-Carr | mcmaster.com | 9452K46 Buna-N O-ring 3 ID 1/8 thick | 2 | 1 | 2026-05-07 | low | Buna-N O-ring 3 ID, 1/8 cross | O-ring 3 in ID 1/8 |  |
| HANDLE-ROPE-S | Knot and Rope Supply | knotandrope.com | hemp rope 1/2 in 25 ft hank | 3 | 1 | 2026-05-07 | low | Natural hemp rope, 1/2 in dia | hemp rope 1/2 in |  |
| FELT-FOOT-PADS | Hardware store | local | felt floor-protection pads | 1 | 1 | 2026-05-07 | low | Adhesive 1 in felt circles | felt furniture pads 1 in |  |
| FINISH-DANISH-OIL | Rockler | rockler.com | Watco Danish Oil natural quart | 2 | 1 | 2026-05-07 | low | Penetrating oil finish, natural color | Watco Danish Oil natural quart |  |
| FINISH-WAX-CARNAUBA | Rockler | rockler.com | Renaissance Wax 65ml | 2 | 1 | 2026-05-07 | low | Microcrystalline wax for final finish | Renaissance Wax |  |
| SANDPAPER-SET | Hardware store | local | sandpaper assortment 80-600 grit | 1 | 1 | 2026-05-07 | low | Mixed grits 80/120/220/320/400/600 | sandpaper assortment |  |
| MALLET-SET | Hapi Drum | hapidrum.com | silicone tongue drum mallet pair | 5 | 1 | 2026-05-07 | low | Soft rubber/silicone heads, 8 in shaft | tongue drum mallets pair |  |

<div class="page-break"></div>

## cut-list.csv

Rough/final stock sizes, material, grain/orientation, operations, yield, and offcuts.

| variant | size | operation_id | description | stock_id | qty | length_in | width_in | thickness_in | rough_dimensions_in | final_dimensions_in | total_bdft | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| V1+V2 | Standard 16in | S-STAVE-01 | Stave blank rough cut from 4/4 walnut | SHELL-STAVE-WALNUT-S | 16 | 9.5 | 3.5 | 0.875 | 9.5 x 3.5 x 0.875 | 9.0 x 3.25 x 0.625 | 3.06 | Allows trim to final 8 in shell + 1 in waste |
| V1+V2 | Travel 12in | T-STAVE-01 | Stave blank rough cut from 4/4 walnut | SHELL-STAVE-WALNUT-T | 16 | 6.5 | 2.7 | 0.875 | 6.5 x 2.7 x 0.875 | 6.0 x 2.45 x 0.625 | 1.62 | Allows trim to final 5 in shell + 1 in waste |
| V1+V2 | Floor Pouf 20in | F-STAVE-01 | Stave blank rough cut from 4/4 walnut | SHELL-STAVE-WALNUT-F | 16 | 11.5 | 4.4 | 0.875 | 11.5 x 4.4 x 0.875 | 11.0 x 4.1 x 0.625 | 4.50 | Allows trim to final 10 in shell + 1 in waste |
| V1+V2 | All | STAVE-EDGE | Stave miter bevel both edges 11.25 deg | N/A | 16 | N/A | N/A | N/A | N/A | N/A | N/A | Tilting-arbor jig referenced off stave centerline. 11.25 deg per edge. |
| V1+V3 | Standard 16in | S-DISC-01 | Padauk soundboard disc CNC cut | SOUNDBOARD-PADAUK-S | 1 | 16.25 | 16.25 | 0.375 | 16.25 x 16.25 x 0.375 | 16.00 dia x 0.375 | 0.69 | Disc dia = shell OD. Rabbet edge 1/4 deep x 3/8 wide on inside face. CRITICAL: cut slits BEFORE rabbet. |
| V1+V3 | Travel 12in | T-DISC-01 | Padauk soundboard disc CNC cut | SOUNDBOARD-PADAUK-T | 1 | 12.25 | 12.25 | 0.25 | 12.25 x 12.25 x 0.25 | 12.00 dia x 0.25 | 0.34 |  |
| V1+V3 | Floor Pouf 20in | F-DISC-01 | Padauk soundboard disc CNC cut | SOUNDBOARD-PADAUK-F | 1 | 20.25 | 20.25 | 0.5 | 20.25 x 20.25 x 0.5 | 20.00 dia x 0.5 | 1.41 | Consider Cedar substitute for D3 fit margin |
| V2+V4 | Standard 16in | S-DOME-BLANK | Padauk dome blank glue-up 3 plies | DOMEBLANK-PADAUK-S | 3 | 17 | 17 | 0.5 | 17 x 17 x 1.5 (after glue-up) | 17 x 17 x 1.5 | 6.02 | Glue 3 plies. Cure 24 h. Flatten on jointer/planer to 1.5 in true. |
| V2+V4 | Standard 16in | S-DOME-CNC | 3D-surface dome rise 0.75 in | N/A | 1 | N/A | N/A | N/A | 17x17 blank | 16.0 dia x 1.5 max thickness, 0.75 in dome rise | N/A | 3/4 in ball-end, 0.05 in stepover. Convex top + concave underside in flip-jig. 32 microinch finish. |
| V2+V4 | Standard 16in | S-DOME-CNC-PROTO | 3D-surface dome on POPLAR test blank first | DOMEBLANK-POPLAR-S | 1 | 17 | 17 | 1.5 | 17x17x1.5 | 16.0 dia, 0.75 dome rise | N/A | De-risk dome surfacing on cheap stock before Padauk |
| V3+V4 | Standard 16in | S-BOWL-RING-01 | Hemisphere bowl ring 1 (largest, foot) | BOWL-SEG-WALNUT-S | 12 | 2.5 | 1.7 | 0.875 | 2.5 x 1.7 x 0.875 | stack height 0.75 | N/A | 15 deg miter, 12 segments per ring. Outer dia 16 in. |
| V3+V4 | Standard 16in | S-BOWL-RING-02 | Hemisphere bowl ring 2 | BOWL-SEG-WALNUT-S | 12 | 2.4 | 1.7 | 0.875 | 2.4 x 1.7 x 0.875 | stack height 0.75 cumulative 1.5 | N/A | Outer dia ~14.7 in |
| V3+V4 | Standard 16in | S-BOWL-RING-03 | Hemisphere bowl ring 3 | BOWL-SEG-WALNUT-S | 12 | 2.3 | 1.7 | 0.875 | 2.3 x 1.7 x 0.875 | stack height 0.75 cumulative 2.25 | N/A | Outer dia ~13.0 in |
| V3+V4 | Standard 16in | S-BOWL-RING-04 | Hemisphere bowl ring 4 | BOWL-SEG-WALNUT-S | 12 | 2.0 | 1.7 | 0.875 | 2.0 x 1.7 x 0.875 | stack height 0.75 cumulative 3.0 | N/A | Outer dia ~11.0 in |
| V3+V4 | Standard 16in | S-BOWL-RING-05 | Hemisphere bowl ring 5 | BOWL-SEG-WALNUT-S | 12 | 1.7 | 1.7 | 0.875 | 1.7 x 1.7 x 0.875 | stack height 0.75 cumulative 3.75 | N/A | Outer dia ~9.0 in |
| V3+V4 | Standard 16in | S-BOWL-RING-06 | Hemisphere bowl ring 6 | BOWL-SEG-WALNUT-S | 12 | 1.4 | 1.4 | 0.875 | 1.4 x 1.4 x 0.875 | stack height 0.75 cumulative 4.5 | N/A | Outer dia ~7.0 in |
| V3+V4 | Standard 16in | S-BOWL-RING-07 | Hemisphere bowl ring 7 | BOWL-SEG-WALNUT-S | 12 | 1.1 | 1.1 | 0.875 | 1.1 x 1.1 x 0.875 | stack height 0.75 cumulative 5.25 | N/A | Outer dia ~5.0 in |
| V3+V4 | Standard 16in | S-BOWL-RING-08 | Hemisphere bowl ring 8 (apex) | BOWL-SEG-WALNUT-S | 12 | 0.8 | 0.8 | 0.875 | 0.8 x 0.8 x 0.875 | stack height 0.75 cumulative 6.0 | N/A | Outer dia ~3.0 in. Cap with single disc if preferred. |
| V3+V4 | Standard 16in | S-BOWL-BASE | Hemisphere bowl base disc (alternative apex) | BOWL-SEG-WALNUT-S | 1 | 3 | 3 | 0.875 | 3 x 3 x 0.875 | 2.75 dia x 0.875 | N/A | Substitutes for ring 8 if desired |
| V1+V2 | Standard 16in | S-SHELL-LATHE | Lathe true OD/ID after stave glue-up | N/A | 1 | N/A | N/A | N/A | OD 16.5 ID 14.5 | OD 16.0 ID 14.75 | N/A | Wall thickness 0.625 in finished. Plus 1/4 deep rabbet at top rim. |
| V1+V3 | Standard 16in | S-SLITS-CNC | CNC tongue slits in soundboard | N/A | 11 | N/A | N/A | N/A | see drawing-brief | 11 slits per radial layout, 1/8 kerf | N/A | Cut from inside face of disc. Tongue lengths from design.md s4 schedule. Cut LONG by 0.030 in for tuning margin. |
| V2+V4 | Standard 16in | S-SLITS-DOME | CNC tongue slits in domed soundboard | N/A | 11 | N/A | N/A | N/A | see drawing-brief | 11 slits, 1/8 kerf | N/A | Slits cut AFTER 3D surfacing. B-axis sled OR flatten dome on sacrificial fixture. +2.5% length correction. |
| All | All | GU-PORT | Drill gu port through bowl/shell bottom | GU-STEPBIT-3 | 1 | N/A | N/A | N/A | start 0.25 in pilot | step up 0.25 in increments to 2.0/2.5/3.0 (per size) | N/A | Tune Helmholtz f_H to ~0.88 of ding f. Take f_H measurement at each step. |
| All | All | SAND | Progressive sand 80-600 grit | SANDPAPER-SET | 1 | N/A | N/A | N/A | N/A | N/A | N/A | Inside and outside. Critical: do not break tongue slit edges (chip damage = pitch shift) |
| All | All | FINISH-OIL | Apply Watco Danish Oil | FINISH-DANISH-OIL | 3 | N/A | N/A | N/A | N/A | N/A | N/A | 3 coats, 24 h between. Soundboard top only. Inside cavity unfinished (kills bass to seal). |
| All | Standard 16in+ | HANDLE-DRILL | Drill handle holes | N/A | 2 | N/A | N/A | N/A | 0.5 in dia | 0.5 in through-holes, 4 in apart | N/A | Optional. Skip on Travel size. |

<div class="page-break"></div>

## drawing-brief.md

Manufacturing drawing and technical product sketch brief.

# Drawing Brief — Wood Shell Tongue Drum

The `drawings/` folder ships dimensioned SVGs for the matrix. Each SVG follows Heifer Zephyr's standard title block (lower-right) with: drawing name, sheet number, scale, units, project (Wood Shell Tongue Drum), date, revision, drafter (Tony Koop). All dimensions in inches unless noted; metric equivalents in brackets where helpful.

## Required drawings

| File                                  | Sheet | Title                                                         | Notes                                                                     |
|---------------------------------------|-------|---------------------------------------------------------------|---------------------------------------------------------------------------|
| `01-variant-matrix.svg`               | 1/9   | Variant Matrix V1–V4 × Three Sizes (top-down + side profiles) | Twelve-cell layout matching `concepts/round-body-variants_concept-sheet.png` with overlaid critical dims |
| `02-v1-standard-side-section.svg`     | 2/9   | V1 Standard 16″ — Side Section A-A                             | Recommended first prototype. Shell, soundboard, rabbet joint, cavity, gu port |
| `03-v1-standard-tongue-layout.svg`    | 3/9   | V1 Standard 16″ — Tongue Field (A Kurd 11-note)                | Top-down soundboard view. Slit centerlines, lengths, position numbering   |
| `04-shell-stave-template.svg`         | 4/9   | Stave Template — All Sizes (full-size cutting layout)          | One stave per size; bevel callouts at 11.25°; centerline marked            |
| `05-shell-segment-template.svg`       | 5/9   | Segment Template — All Sizes (alt body construction)           | 15° miter, 12-per-ring; 8 rings on Std, 6 on Travel, 10 on Floor          |
| `06-rabbet-joint-detail.svg`          | 6/9   | Bowl-Top Rabbet Joint — Section B-B (3× scale)                | ¼″ × ⅜″ rabbet; soundboard slip-fit; glue line; air-seal callout          |
| `07-dome-toolpath.svg`                | 7/9   | V2/V4 Dome Surfacing — CNC Toolpath Schematic                  | Convex top + concave bottom; 0.05″ stepover; flip-jig datum pins           |
| `08-bowl-segment-stack.svg`           | 8/9   | V3/V4 Hemisphere Bowl — Ring Stack Section                     | 8 rings of decreasing dia; lathe-true profile overlay                     |
| `09-gu-port-tuning-progression.svg`   | 9/9   | Gu Port Tuning — Step-Drill Progression                        | 0.25″ pilot → step increments → final size; f_H expected at each step      |

## Drawing conventions

- **Datums:** shell bottom plane = primary horizontal datum (Z=0); axis of revolution = primary vertical datum.
- **Tolerances:** ± 0.020″ default; tighter where called out (rim flatness ± 0.005″, slit kerf width ± 0.005″, miter angle ± 0.1°).
- **Cross-section hatching:** oak-grain pattern at 45° for wood; cross-hatch at 90° for void/cavity.
- **Title block size:** 4″ × 1.5″ at 1:1 scale.
- **Critical dimensions:** bold, with leader lines pointing to the dimensioned feature. Helmholtz-driving dimensions (cavity volume parameters) are double-boxed.
- **Material color cues** (when polychrome): Walnut = warm brown fill, Maple = pale cream, Cherry = pink-brown, Padauk = orange-red. Used in sheet 5 segment-stack diagrams for the diamond pattern.

## Critical dimensions (must appear on the drawings)

| Dimension                          | Drawing | Value (Standard 16″ V1) | Tolerance        |
|------------------------------------|---------|--------------------------|------------------|
| Shell OD                           | 02      | 16.000″                  | ± 0.020″         |
| Shell ID                           | 02      | 14.750″                  | ± 0.030″         |
| Shell wall thickness               | 02      | 0.625″                   | ± 0.030″         |
| Shell height                       | 02      | 8.000″                   | ± 0.030″         |
| Soundboard OD                      | 02, 03  | 16.000″                  | ± 0.010″         |
| Soundboard thickness               | 02, 03  | 0.375″                   | ± 0.005″         |
| Rabbet depth                       | 02, 06  | 0.250″                   | ± 0.005″         |
| Rabbet width                       | 02, 06  | 0.375″                   | ± 0.005″         |
| Tongue length (ding A3)            | 03      | 6.454″                   | + 0.030″ initial |
| Tongue width                       | 03      | 1.250″                   | ± 0.020″         |
| Slit kerf width                    | 03      | 0.125″                   | ± 0.005″         |
| Gu port diameter (final)           | 02, 09  | 2.500″ nominal           | tuned in shop    |
| Stave miter angle                  | 04      | 11.25°                   | ± 0.1°           |

## Sheet 03 — tongue layout details

The 11-tongue A Kurd field uses a **zigzag-ascending** pattern: ding centered, then tongues 1, 2, 3, … alternating left and right at progressively greater radii from the ding. This matches steel-tongue-drum convention and gives the player an ergonomic two-handed reach.

Position grid (radial coords, ding = origin):

| #    | Note | r (in from ding centerline) | θ (deg) | length (in) |
|------|------|------------------------------|---------|-------------|
| Ding | A3   | 0                            | —       | 6.454       |
| 1    | E4   | 4.0                          | 60      | 5.273       |
| 2    | F4   | 4.0                          | -60     | 5.123       |
| 3    | G4   | 5.5                          | 90      | 4.835       |
| 4    | A4   | 5.5                          | -90     | 4.564       |
| 5    | B4   | 6.5                          | 120     | 4.308       |
| 6    | C5   | 6.5                          | -120    | 4.185       |
| 7    | D5   | 6.0                          | 30      | 3.950       |
| 8    | E5   | 6.0                          | -30     | 3.728       |
| 9    | G5   | 6.5                          | 150     | 3.419       |
| 10   | A5   | 6.5                          | -150    | 3.227       |

(These radial coords are derived estimates for the layout drawing; SolidWorks parametric placement against shell radius will refine them. The radii are kept ≤ 6.5″ to leave wall clearance ≥ 1.0″ on the 16″ shell.)

## Status

These SVG files are listed in this brief as the *intended* drawing set. The repo currently ships the brief and the source workbook; SVGs are emitted by `scripts/generate_drawings.py` (in the parent `instrument-maker` skill) reading the workbook as its parametric source. Per the v4 deliverable list, drawings are auto-generated and refreshed when the workbook changes — they are not hand-drawn artifacts.

A placeholder hero drawing — `drawings/00-hero-v1-standard.svg` — ships in this repo at first commit so cross-references resolve. It is replaced in production by sheet 02 above.

<div class="page-break"></div>

## assembly-manual.md

Shop-facing sequence, tools, fixtures, safety, tuning, finishing, and maintenance notes.

# Wood Shell Tongue Drum — Assembly Manual

Covers all four manufacturing variants (V1, V2, V3, V4) across three sizes (Travel 12″, Standard 16″, Floor Pouf 20″). Steps shared across variants are written once with branching notes where they diverge. Read `design.md` first — this manual assumes you have the parametric workbook open for size-specific dimensions and the recommended first prototype is **V1 Cylinder + Flat Top, Standard 16″, A Kurd**.

---

## Phase 0 — Shop preparation

1. Acclimate stock 2 weeks in the shop (60–70 °F, 40–55 % RH). Padauk and Black Walnut both move with seasonal humidity; soundboard cup or warp will scrap a tongue field that was previously in tune.
2. Joint and plane stock to nominal dimensions ± 0.005″.
3. Verify your saw kerf width with a test cut. The cut-list assumes a known kerf — measure yours before sizing rough stock.
4. Check the lathe — main spindle runout < 0.003″ TIR, tailstock alignment within 0.005″. A round shell amplifies any mounting wobble.
5. Verify CNC router calibration: a stock-thickness probe and tool-length probe both within ± 0.002″. Tongue slits depend on consistent depth.

---

## Phase 1A — Cylinder shell (V1, V2)

The cylinder is the *recommended* body for the first prototype. Two construction paths share Phases 1A.4 onward.

### 1A.1 Stave path (preferred for first build)

1. Rough-cut 16 staves to outline + 1/8″ on each side. Stock dimensions per `cut-list.csv` (Standard 16″: 9.5″ × 3.5″ × 0.875″).
2. Bevel both edges to 11.25° using a tilting-arbor jig referenced off the stave centerline (NOT off either edge — the stave is symmetric only when freshly ripped). Test on a sacrificial board first; verify the assembled circle closes by dry-clamping 4 staves and checking the included angle.
3. Sand the inside face to 220 grit. The inside is permanent and not turnable after glue-up.

### 1A.2 Segmented path (alternative for polychrome aesthetic)

1. Rough-cut 96 segments (8 rings × 12 segments) at 15° miter on a table-saw miter sled.
2. Stack rings on a lazy-susan jig for sequential glue-up. Each ring closes independently before stacking.
3. Diamond / 5-10-5 species patterns (Walnut + Maple + Cherry) read beautifully on 16″ Ottoman size — see `drawing-brief.md` §08 for layout templates.

### 1A.3 Stave glue-up (path A)

1. Lay all 16 staves flat on a tarp, edges touching, in their final order. Tape across all joints with strong masking tape.
2. Roll the assembly into a tube. Apply a thin even bead of Titebond III to every edge.
3. Re-roll, close to a full cylinder.
4. Wrap with three nylon ratchet straps OR run two large hose clamps. Do not over-tighten — squeeze-out should bead, not gush.
5. Stand the tube on a flat plate (¾″ MDF works) and check for end-square with a framing square. Adjust strap tension to pull any out-of-round into round.
6. Cure 24 hours.

### 1A.4 Lathe truing (both paths converge)

1. Mount a faceplate to a 3″ waste block. Glue the waste block to a ¼″ ply disk slightly larger than the shell ID.
2. Slide the shell over the disk; insert a soft-rubber expansion plug at the open end with the tailstock for support.
3. Turn the OD true to the design diameter (e.g., 16.00″ for Standard). Wall thickness target: 0.625″ finished.
4. Reverse-mount and turn the rim end. The rim must be planar (± 0.005″ TIR) — this is the airtight bond surface for the soundboard.
5. Cut a ¼″-deep × ⅜″-wide rabbet in the inside of the rim, sized to receive the soundboard disc (see `cut-list.csv` row S-DISC-01 for the disc dimensions).

---

## Phase 1B — Hemisphere bowl (V3, V4)

Pick one of two construction paths. Segmented is recommended for the first hemisphere build.

### 1B.1 Segmented bowl path

1. Rough-cut graduated rings per `cut-list.csv` rows S-BOWL-RING-01 through S-BOWL-RING-08 (Standard 16″: 8 rings of decreasing diameter from 16″ at the rim to ~3″ at the apex).
2. Glue each ring closed on the lazy-susan jig before stacking.
3. Stack rings with a centering jig (a vertical dowel through ring centers) and glue with Titebond III. Cure 24 h between layers.
4. Mount the assembled bowl on a faceplate with a thick waste block.
5. Lathe-true the outside to a parabolic profile (within 1/16″ of true sphere is acceptable — the lathe finishes any micro-step). Lathe-true the rim flat (± 0.005″ TIR).

### 1B.2 CNC-carved bowl path (alternative; high material waste)

1. Glue up a thick blank: 5 plies of 1″ Black Walnut for Standard 16″.
2. CNC 3D-surface the outside convex profile with a ¾″ ball-end bit; 0.05″ stepover for ≤ 32 µin surface finish.
3. Flip-jig the blank with datum pins; 3D-surface the inside concave profile.
4. Trim rim flat on a router table or lathe; verify ± 0.005″ TIR.

---

## Phase 2 — Soundboard (variant-dependent)

### 2A — Flat soundboard (V1, V3)

1. Cut Padauk disc to OD per `cut-list.csv` (Standard 16″: 16.25″ rough → 16.00″ final).
2. Mark the tongue layout on the *inside* face of the disc. Use the layout template in `cnc/README.md`.
3. CNC-route the tongue slits with a 1/8″ upcut spiral. Cut from inside face. Tongue lengths from `design.md` §4 — cut LONG by 0.030″ for tuning margin.
4. Sand the soundboard to 320 grit. **Do not break the slit edges** — chip damage causes pitch shifts that are difficult to recover.
5. Apply Watco Danish Oil to the *outside* face only. Three coats, 24 h between. Inside cavity stays unfinished (sealing the cavity damps the bass).

### 2B — Domed soundboard (V2, V4)

1. Glue up a 3-ply blank per `cut-list.csv` row S-DOME-BLANK (Standard 16″: 3 × 0.5″ Padauk = 1.5″ thick × 17″ × 17″).
2. **Rehearse on poplar first.** Cut a poplar test blank with the same dome profile (S-DOME-CNC-PROTO). Verify the toolpath produces a clean parabolic surface with no scallop steps before committing the Padauk blank.
3. 3D-surface the convex top with a ¾″ ball-end bit, 0.05″ stepover. Dome rise per size preset (Standard: 0.75″).
4. Flip the blank into a flip-jig with datum pins. 3D-surface the concave underside (matches OD rim for clean rabbet seat).
5. **Validate the curved cantilever multiplier.** Cut ONE tongue at the predicted length × 1.025 multiplier. Tap-test, measure pitch with a Korg OT-120. Back-solve the actual multiplier (`L_measured² × f / (K × t)` returns the new multiplier). Apply this measured multiplier to the remaining 10 tongue layouts before any further cutting.
6. Cut the remaining 10 tongues with the validated multiplier. Cut LONG by 0.030″ for tuning margin.
7. Sand and finish per Phase 2A steps 4–5.

---

## Phase 3 — Bowl-top assembly

The bowl-to-soundboard joint is **acoustically critical**: an air leak here destroys the Helmholtz Q. Any of three joint geometries can work; the rabbet is the working assumption.

### 3.1 Rabbet joint (preferred)

1. Verify the shell rim rabbet (cut in Phase 1A.4 / 1B): ¼″ deep × ⅜″ wide, ± 0.005″.
2. Verify the soundboard slip-fits into the rabbet with 0.005″ clearance — tight enough for a PVA bond, loose enough that you don't pry the rim apart on insertion.
3. Apply a uniform thin bead of Titebond III in the rabbet. Drop the soundboard in flush.
4. Apply two cauls (top and bottom) with band clamps OR a vacuum bag. Cure 24 h.

### 3.2 Lap step joint (backup)

If the rabbet leaks under puff-test (Phase 6), step-lap a thin (1/16″) Padauk veneer overlapping the rabbet seam from inside. Glue with Titebond III.

### 3.3 Cork gasket (last-resort backup)

If both rabbet and lap-step leak, install a 1/16″ cork ring in the rabbet under the soundboard. Compresses for an airtight seal but adds compliance that may damp the Helmholtz Q.

---

## Phase 4 — Gu-port tuning

The gu port is your primary Helmholtz tuning knob. It is drilled **last** and **deliberately undersized**, then opened up incrementally while measuring `f_H`.

1. Drill a ¼″ pilot hole through the shell/bowl bottom, centered (verify ± 0.025″).
2. Place a small microphone above the port. Puff gently across the port edge (like blowing across a bottle top). Record the resonance frequency in REW or Spectroid.
3. Use a step-drill to enlarge the port in ¼″ increments. Re-measure `f_H` at each step. Stop when `f_H ≈ 0.88 × f_ding` (Standard 16″ V1: target ≈ 195 Hz).
4. **If the cavity is over-coupled** (ratio > 1.2 at any port size including 0.25″): the cavity is leaking elsewhere — re-test for rim seal before enlarging further.
5. **If the cavity is under-coupled** (ratio < 0.8 even at the maximum port preset): the cavity volume is too large — this is a design problem, not a tuning problem. Document and re-evaluate.

Optional: install a Buna-N O-ring in the finished port (BOM rows ORING-RUBBER-*) for a Hapi-style cleaner tone. Not required.

---

## Phase 5 — Tongue tuning

Tongues are cut LONG. Each one is tuned by filing the tongue tip (which shortens the effective length, *raising* the pitch). You cannot lower a tongue's pitch by filing — if a tongue measures sharp of target by more than 50 cents at first cut, that tongue is scrap.

1. Set up the drum on a soft surface (foam, blanket).
2. Strike each tongue at its tip with a soft mallet. Record pitch with a Korg OT-120 (or a phone tuner with cents resolution).
3. Compare to `validation.csv` predicted column.
4. For tongues > 5 cents flat: do nothing yet (let the tongue settle for 48 h after cutting before tuning).
5. For tongues > 5 cents sharp: file the tongue tip with a flat sanding bar (320 grit). Test pitch every 3–4 strokes. Each 0.030″ removed from the tip raises pitch by ~10–15 cents.
6. For tongues > 30 cents flat after 48 h settling: file the *underside* of the tongue at the base (thinning the cantilever lowers stiffness, which lowers pitch). This is a recovery move; ideally tongues are cut long enough to never need it.
7. Final tuning: ± 5 cents of target on all 11 tongues.
8. Document final measurements in `validation.csv`.

---

## Phase 6 — Validation and acceptance

Run the full validation loop before declaring the build complete:

| Check                          | Tool                  | Acceptance band                  |
|--------------------------------|------------------------|----------------------------------|
| All 11 tongues to target       | Korg OT-120            | ± 5 cents per tongue             |
| Helmholtz coupling ratio       | mic + spectrum         | 0.80 ≤ f_H/f_ding ≤ 1.20         |
| Bowl-top airtight seal         | smoke or vacuum test   | no visible leakage at rabbet     |
| Bearing-edge planarity         | dial indicator         | ± 0.005″ TIR                    |
| Wall thickness uniformity      | calipers, 8 points     | ± 0.030″ from nominal           |
| Soundboard thickness uniformity| calipers, 9-pt grid    | ± 0.005″                        |
| Slit kerf width                | feeler gauge, 5-pt     | 0.125″ ± 0.005″                 |
| Sustain T60                    | REW software           | 1.5 s ≤ T60 ≤ 4.0 s             |
| A4 = 440.0 Hz sanity           | tongue 4 measurement   | within 5 cents of 440 Hz        |

Record measured values in `validation.csv`. If A4 measures off > 5 cents, back-compute the actual K-constant of your specific stock (`K_actual = f × L² / t`) and update the per-family corrections database.

---

## Phase 7 — Finish and presentation

1. Apply 3 coats Watco Danish Oil to the shell exterior (24 h between coats).
2. Apply Renaissance Wax to the shell exterior (final coat, buffed).
3. Apply 3 coats Watco Danish Oil to the soundboard *outside* face only.
4. Adhere felt foot pads to the shell bottom (4 pads at 90° spacing).
5. Optional: install hemp carry handle (Standard size and above).
6. Photograph per `photo-shotlist.md`.
7. Tag the drum with maker plate (interior) and update the catalog entry in the master workbook.

---

## Branching summary

| Phase | V1 (Cyl + Flat) | V2 (Cyl + Dome) | V3 (Hemi + Flat) | V4 (Hemi + Dome) |
|-------|-----------------|-----------------|------------------|------------------|
| 1     | 1A — cylinder   | 1A — cylinder   | 1B — bowl        | 1B — bowl        |
| 2     | 2A — flat       | 2B — dome       | 2A — flat        | 2B — dome        |
| 3     | 3.1 rabbet      | 3.1 rabbet      | 3.1 rabbet       | 3.1 rabbet       |
| 4     | 2.5″ port       | < 1.5″ port (under-coup correction) | 2.5″ port | < 1.5″ port (under-coup correction) |
| 5     | flat tuning     | flat + dome correction | flat tuning | flat + dome correction |
| 6     | full validation | full validation + dome multiplier check | full validation | full validation + dome multiplier check |
| 7     | standard finish | standard finish | standard finish  | standard finish  |

<div class="page-break"></div>

## validation.csv

Target/measured values, tolerance, environment, result, and tuning/build action log.

| size | variant | target | parameter | predicted_value | measured_value | unit | cents_error | measurement_date | instrument | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Standard 16in | V1 | ding fundamental | frequency | 220.00 |  | Hz |  |  | Korg OT-120 | A3 ding (MIDI 57). Tunable band A3 +/- 30 cents. Recommended first prototype. |
| Standard 16in | V1 | tongue 1 (E4) | frequency | 329.63 |  | Hz |  |  | Korg OT-120 | E4 tongue. Cut 0.030 in long; file to pitch. |
| Standard 16in | V1 | tongue 2 (F4) | frequency | 349.23 |  | Hz |  |  | Korg OT-120 |  |
| Standard 16in | V1 | tongue 3 (G4) | frequency | 392.00 |  | Hz |  |  | Korg OT-120 |  |
| Standard 16in | V1 | tongue 4 (A4) | frequency | 440.00 |  | Hz |  |  | Korg OT-120 | Reference pitch — should land dead-on without filing |
| Standard 16in | V1 | tongue 5 (B4) | frequency | 493.88 |  | Hz |  |  | Korg OT-120 |  |
| Standard 16in | V1 | tongue 6 (C5) | frequency | 523.25 |  | Hz |  |  | Korg OT-120 |  |
| Standard 16in | V1 | tongue 7 (D5) | frequency | 587.33 |  | Hz |  |  | Korg OT-120 |  |
| Standard 16in | V1 | tongue 8 (E5) | frequency | 659.26 |  | Hz |  |  | Korg OT-120 |  |
| Standard 16in | V1 | tongue 9 (G5) | frequency | 783.99 |  | Hz |  |  | Korg OT-120 |  |
| Standard 16in | V1 | tongue 10 (A5) | frequency | 880.00 |  | Hz |  |  | Korg OT-120 |  |
| Standard 16in | V1 | Helmholtz cavity | frequency | 194.57 |  | Hz |  |  | microphone + spectrum | Cavity port puff test. Target 0.88 x ding. If measures > 230 Hz, port too large; < 175 Hz, port too small. |
| Standard 16in | V1 | coupling ratio | f_H/f_ding | 0.88 |  | ratio |  |  | computed | Acceptance band 0.80-1.20 for coupled regime |
| Standard 16in | V1 | sustain T60 | RT decay -60dB | 2.5 |  | seconds |  |  | REW software | Acceptance 1.5-4.0 s. Wood tongue drums typically more sustained than rectangular due to Helmholtz. |
| Standard 16in | V1 | bearing-edge planarity | TIR | 0.005 |  | inches |  |  | dial indicator | Lathe-tested. Acceptance +/- 0.005 in. |
| Standard 16in | V1 | wall thickness uniformity | 8 points around shell | 0.625 |  | inches |  |  | calipers | +/- 0.030 in acceptance. Wedge-shaped wall = asymmetric cavity = killed bass. |
| Standard 16in | V1 | soundboard thickness uniformity | 9-pt grid | 0.375 |  | inches |  |  | calipers | +/- 0.005 in acceptance. Affects tongue pitch via sqrt(t). |
| Standard 16in | V1 | slit kerf width | 5-point sample | 0.125 |  | inches |  |  | feeler gauge | +/- 0.005 in. Wider kerfs = lower Q. |
| Standard 16in | V1 | gu-port concentricity | distance from bowl center | 0 |  | inches |  |  | calipers | +/- 0.025 in. Off-center port shifts effective neck length. |
| Standard 16in | V1 | bowl-top airtight seal | pressurization test | pass |  | pass/fail |  |  | vacuum test or smoke | No air leakage at the rabbet joint. Critical for Helmholtz Q. |
| Standard 16in | V1 | glue-line shear (24h cure) | destructive sample test | 4000 |  | psi |  |  | test fixture | Titebond III rated 4000 psi. Test on a sacrificial sample stave joint, not the drum itself. |
| Travel 12in | V1 | ding fundamental | frequency | 293.66 |  | Hz |  |  | Korg OT-120 | D4 ding (MIDI 62). Build last after Standard is dialed in. |
| Travel 12in | V1 | Helmholtz cavity | frequency | 321.53 |  | Hz |  |  | microphone + spectrum | Predicted ratio 1.09 — at upper edge of coupled band. May need to shrink port to 1.75 in to lift below ding. |
| Travel 12in | V1 | coupling ratio | f_H/f_ding | 1.09 |  | ratio |  |  | computed | Tight; acceptance 0.80-1.20. Watch the Helmholtz tuning carefully. |
| Floor Pouf 20in | V1 | ding fundamental | frequency | 146.83 |  | Hz |  |  | Korg OT-120 | D3 ding. WARNING: ding tongue length (9.12 in) exceeds 9 in cap by 0.12 in. Use Cedar (8.34 in fits) or raise ding to D#3. |
| Floor Pouf 20in | V1 | Helmholtz cavity | frequency | 144.69 |  | Hz |  |  | microphone + spectrum | Predicted ratio 0.99 — perfectly coupled. |
| Floor Pouf 20in | V1 | coupling ratio | f_H/f_ding | 0.99 |  | ratio |  |  | computed | Sweet spot. |
| Standard 16in | V2 | ding fundamental | frequency | 220.00 |  | Hz |  |  | Korg OT-120 | A3 ding. Domed top requires +2.5% tongue length correction. |
| Standard 16in | V2 | curved-cantilever correction | measured/predicted ratio | 1.025 |  | multiplier |  |  | Korg OT-120 | VALIDATE EMPIRICALLY: tap one tongue at L = sqrt(K*t/f)*1.025, measure pitch, back-solve actual factor before cutting all 11. |
| Standard 16in | V2 | Helmholtz cavity | frequency | 133.48 |  | Hz |  |  | microphone + spectrum | Predicted ratio 0.61 — UNDER-COUPLED. Likely need to shrink port from 2.5 in to ~1.5 in to lift f_H to coupled regime. |
| Standard 16in | V3 | ding fundamental | frequency | 220.00 |  | Hz |  |  | Korg OT-120 | A3 ding, hemisphere bowl, flat top. |
| Standard 16in | V3 | Helmholtz cavity | frequency | 238.30 |  | Hz |  |  | microphone + spectrum | Predicted ratio 1.08 — coupled. Hemisphere has smaller volume than cylinder so f_H higher. |
| Standard 16in | V3 | coupling ratio | f_H/f_ding | 1.08 |  | ratio |  |  | computed | Coupled. |
| Standard 16in | V4 | ding fundamental | frequency | 220.00 |  | Hz |  |  | Korg OT-120 |  |
| Standard 16in | V4 | Helmholtz cavity | frequency | 161.12 |  | Hz |  |  | microphone + spectrum | Predicted ratio 0.73 — UNDER-COUPLED. Combine V2 + V3 effects. |
| All | All | A4 = 440 Hz sanity | reference pitch | 440.00 |  | Hz |  |  | Korg OT-120 | Sanity check: tongue 4 (A4) is reference pitch — should land dead-on. If off > 5 cents, K-constant of stock differs from library. |
| All | All | Padauk K calibration | measured K constant | 24438 |  | K imperial |  |  | back-computed from tongue measurement | After tuning, back-compute K = f * L^2 / t. Update library if measured value differs > 5% from 24438. |
| All | V2+V4 | curved cantilever K-effective | measured/predicted ratio | 1.025 |  | multiplier |  |  | first dome prototype | Per-family corrections database entry. Will propagate to V2/V4 sibling packets. |

<div class="page-break"></div>

## supplier-rfq.md

Supplier email/request-for-quote starter.

# Supplier RFQ — Wood Shell Tongue Drum (Q2 2026 batch)

Heifer Zephyr Instruments is producing a wood shell tongue drum series across four manufacturing variants (V1–V4) and three sizes (Travel 12″, Standard 16″, Floor Pouf 20″). The recommended first prototype is **V1 Cylinder + Flat Top, Standard 16″** — that build is the priority for this RFQ. Variants V2–V4 are queued for sequential phases and should be quoted alongside but not necessarily shipped together.

Verified pricing date for all line items: **2026-05-07**. All prices are starting-point estimates; supplier confirmation requested before commit.

## Lumber

| Need                                        | Quantity (per drum)        | Specification                                               |
|---------------------------------------------|----------------------------|-------------------------------------------------------------|
| Black Walnut, 4/4, S2S, FAS                 | ~3 BdFt (Standard 16″)     | Edge-jointable for stave glue-up; clear grain               |
| Black Walnut, 4/4, S2S, FAS                 | ~5 BdFt (segmented bowl)   | Bulk segment grade; 12-segment ring stack                    |
| Padauk, 4/4 or 1/2, S4S                     | ~1 BdFt                    | Soundboard thickness controls tongue length — hold 3/8″ ± 1/64″ on Standard. Quartersawn preferred for bend stability. |
| Padauk, 4/4 boards (3 ea, glue-up)          | ~3 BdFt (V2/V4 dome only)  | For glue-laminated dome blank; 1.5″ total thickness         |
| Western Red Cedar, 1/2 quartersawn          | ~1 BdFt (Floor Pouf alt)   | Soundboard alternate for D3 ding fit on Floor Pouf 20″      |
| Poplar, 1× boards                           | ~3 BdFt (V2/V4 prototype)  | Cheap test stock for dome surfacing rehearsal                |

**Preferred suppliers:** Bell Forest Products (primary), Cook Woods (segment blanks). Local pickup acceptable if equivalent grade.

## Tooling

For shop and CNC tooling. Most are one-time buys; the 1/8″ upcut spirals are consumables (one breaks per shell).

| Item                                                     | Qty | Source                              |
|----------------------------------------------------------|-----|-------------------------------------|
| Solid carbide upcut spiral 1/8″ × 1/4″ shank             | 3   | Amana 46202 (preferred)             |
| Ball-end mill 3/4″ × 1/2″ shank (V2/V4 dome surfacing)   | 1   | Amana 46377                         |
| Rabbeting bit set with bearing kit, 1/4″ shank           | 1   | Rockler                             |
| Step drill bit, 1/4″–3″ in 1/4″ increments               | 1   | Irwin Unibit (Amazon)               |

## Hardware and consumables

| Item                                      | Qty (per drum) | Notes                                        |
|-------------------------------------------|----------------|----------------------------------------------|
| Titebond III wood glue, 16 oz             | 1 (shared 2 drums) | Waterproof; 4000 psi shear                |
| Watco Danish Oil, natural, qt             | 1 (shared 4 drums) | 3-coat finish                            |
| Renaissance Wax, 65 ml                    | 1 (shared 4 drums) | Final shell finish                       |
| Sandpaper assortment 80/120/220/320/400/600 grit | 1 set    | Local hardware store                       |
| Buna-N O-ring (sized to gu port)          | 1              | Optional Hapi-style port lining             |
| Adhesive felt floor-protection pads, 1″ dia | 4            | Local hardware                              |
| Hemp rope, 1/2″, 4 ft                     | 1 (Std/Floor)  | Optional carry handle                       |

## Skin/heads

**N/A** — this is a slit-tongue idiophone, not a membrane drum. No skins required. (Distinguishes this design from the conga and ashiko families which use mule or LP heads.)

## Acoustic test gear (one-time shop equipment)

These are workshop instruments, not per-drum consumables. Listed for budget transparency.

| Item                                       | Qty | Notes                                |
|--------------------------------------------|-----|--------------------------------------|
| Korg OT-120 wide-range chromatic tuner     | 1   | Already owned                        |
| Microphone + REW software for Helmholtz    | 1   | Phone + free Spectroid app acceptable |

## Lead-time summary

| Category               | Typical lead time      |
|------------------------|------------------------|
| Lumber (Bell Forest)   | 5 days                 |
| Lumber (Cook Woods)    | 4 days                 |
| Tooling (Amana, Rockler)| 2–3 days              |
| Hardware (McMaster)    | 2 days                 |
| Local hardware         | same-day               |

Critical path for first prototype: lumber + slit bits. Order both at start of Phase 1; tooling can be ordered immediately on project kickoff.

## Quote request

Please confirm:

1. Current per-board-foot price on Black Walnut 4/4 FAS (we want clear, edge-jointable stock — figured grade is *not* required for this design and adds cost without acoustic benefit).
2. Padauk availability in 3/8″ thickness *as a stock item*. If only 4/4 is stocked, we will glue / resaw — quote both options.
3. Lead-time guarantees for Q2 2026.
4. Volume-discount thresholds — we may run multiple drums (V1 first, V2 reuses the same shell) over the next 12 months.

Heifer Zephyr Instruments
Tony Koop
[github.com/tonykoop/wood-shell-tongue-drum](https://github.com/tonykoop/wood-shell-tongue-drum)

<div class="page-break"></div>

## visual-bom-brief.md

Art direction for an image-forward visual BOM.

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

<div class="page-break"></div>

## wolfram-starter.wl

Wolfram starter for physics, optimization, visualization, and validation.

```wolfram
(* ::Package:: *)

(* Wood Shell Tongue Drum — Acoustic Physics Starter
   Heifer Zephyr Instruments — Tony Koop
   Open in Wolfram Desktop or Wolfram Cloud.

   This notebook implements the 3-DOF coupled-oscillator picture for a
   slit-tongue idiophone with an enclosed Helmholtz cavity. The three
   oscillators are:

     1. The tongue (flat or curved cantilever, Euler-Bernoulli).
     2. The shell wall (cylindrical or hemispherical).
     3. The enclosed air cavity (Helmholtz resonator).

   The tongue couples to the shell through the rabbet boundary; the
   shell couples to the air cavity through wall compliance; the air
   cavity couples back to the tongue through pressure on the
   underside of the slit field. The eigenvalue split predicts how much
   the wood shell adds sustain compared to a rigid-walled tongue drum.
*)

(* === 1. Inputs (edit me) === *)

(* All dimensions in inches; conversions to SI happen below. *)

(* Recommended first prototype: V1 Standard 16in *)
shellOD       = 16.0;          (* shell outer diameter *)
shellHeight   = 8.0;           (* cylinder body height *)
shellThk      = 0.625;         (* wall thickness, finished *)
sbThk         = 0.375;         (* soundboard thickness (Padauk) *)
sbWood        = "Padauk";      (* one of Padauk, Cherry, Walnut, Maple, Cedar *)
shellWood     = "BlackWalnut"; (* shell material *)
guPortDia     = 2.5;           (* gu port diameter, initial preset *)
domeRise      = 0.0;           (* 0 for flat top, 0.75 for V2 Std *)

dingMidi      = 57;            (* A3 *)
nTongues      = 11;
tongueWidth   = 1.25;
slitKerf      = 0.125;

(* Material library — cantilever K (imperial composite) and elastic
   moduli. Cross-references the workbook material library, rows 19-25. *)
materials = <|
  "Padauk"       -> <|"K" -> 24438., "E" -> 11.0*^9, "rho" -> 745.|>,
  "Wenge"        -> <|"K" -> 27103., "E" -> 15.8*^9, "rho" -> 870.|>,
  "Cherry"       -> <|"K" -> 27275., "E" -> 10.3*^9, "rho" -> 560.|>,
  "BlackWalnut"  -> <|"K" -> 27734., "E" -> 11.6*^9, "rho" -> 610.|>,
  "HardMaple"    -> <|"K" -> 26887., "E" -> 12.6*^9, "rho" -> 705.|>,
  "Mahogany"     -> <|"K" -> 26314., "E" -> 10.1*^9, "rho" -> 590.|>,
  "WesternRedCedar" -> <|"K" -> 29013., "E" -> 7.7*^9, "rho" -> 370.|>
|>;

(* === 2. Constants === *)

cAir = 13552.;     (* speed of sound in inches/sec *)
mPerIn = 0.0254;   (* unit conversion *)

(* MIDI -> Hz *)
fFromMidi[m_] := 440. * 2.^((m - 69)/12.);

(* === 3. Tongue cantilever (DOF 1) === *)

(* Flat cantilever Euler-Bernoulli: f = K * t / L^2  =>  L = sqrt(K * t / f) *)

LFlat[K_, t_, f_]    := Sqrt[K * t / f];
LCurved[K_, t_, f_, mult_:1.025] := mult * Sqrt[K * t / f];

(* Predicted ding tongue length, V1 vs V2 *)
KSb = materials[sbWood, "K"];
fDing = fFromMidi[dingMidi];

LDingFlat   = LFlat[KSb, sbThk, fDing];
LDingCurved = LCurved[KSb, sbThk, fDing];

(* Print *)
Print["Predicted tongue lengths for ", sbWood,
      " soundboard, ", sbThk, " in thick:"];
Print["  Ding (MIDI ", dingMidi, ", ", NumberForm[fDing, 5], " Hz):"];
Print["    flat   = ", NumberForm[LDingFlat, 4], " in"];
Print["    curved = ", NumberForm[LDingCurved, 4], " in (multiplier 1.025)"];

(* === 4. Helmholtz cavity (DOF 3) === *)

(* fH = (c / 2 pi) * sqrt(A / (V * Lneck)) *)

fHelmholtz[V_, A_, Lneck_] := (cAir / (2 Pi)) * Sqrt[A / (V * Lneck)];

(* Volume formulas per variant (in cubic inches) *)
volV1 = Pi * (shellOD/2)^2 * shellHeight;                          (* cyl flat *)
volV2 = volV1 + (2/3)*Pi*(shellOD/2)^2 * domeRise;                 (* cyl + dome *)
volV3 = (2/3) * Pi * (shellOD/2)^3;                                (* hemi flat *)
volV4 = volV3 + (2/3)*Pi*(shellOD/2)^2 * domeRise;                 (* hemi + dome *)

portArea = Pi * (guPortDia/2)^2;
neckFlat   = sbThk;
neckDomed  = sbThk + domeRise/2;

fHV1 = fHelmholtz[volV1, portArea, neckFlat];
fHV2 = fHelmholtz[volV2, portArea, neckDomed];
fHV3 = fHelmholtz[volV3, portArea, neckFlat];
fHV4 = fHelmholtz[volV4, portArea, neckDomed];

Print[];
Print["Helmholtz frequencies (current preset, gu port = ", guPortDia, " in):"];
Print["  V1 (cyl + flat)  : ", NumberForm[fHV1, 5], " Hz, ratio ",
      NumberForm[fHV1/fDing, 3]];
Print["  V2 (cyl + dome)  : ", NumberForm[fHV2, 5], " Hz, ratio ",
      NumberForm[fHV2/fDing, 3]];
Print["  V3 (hemi + flat) : ", NumberForm[fHV3, 5], " Hz, ratio ",
      NumberForm[fHV3/fDing, 3]];
Print["  V4 (hemi + dome) : ", NumberForm[fHV4, 5], " Hz, ratio ",
      NumberForm[fHV4/fDing, 3]];
Print["  Coupled regime: 0.80 <= ratio <= 1.20"];

(* === 5. 3-DOF coupled-oscillator model === *)

(*
   Reduced model: tongue (m1, k1), shell wall (m2, k2), air (m3, k3)
   coupled by k12 (rabbet stiffness) and k23 (wall-air compliance).
   Solving the 3x3 mass-spring system yields three eigenfrequencies;
   the lower two are dominated by tongue and Helmholtz, the highest
   by the shell wall mode. The split between the tongue eigenfreq
   and the lone-tongue freq quantifies the shell's contribution to
   sustain.

   The values below are starting estimates -- they are NOT measured.
   Treat the model as a structural starting point; the per-family
   corrections database holds the calibrated numbers once measurements
   exist.
*)

(* Effective masses (kg) and stiffnesses (N/m) -- order-of-magnitude *)
(* Tongue: half-beam approximation, treat as single-DOF cantilever *)
m1 = 0.020;            (* ~20 g effective tongue mass *)
k1 = (2 Pi fDing)^2 * m1;

(* Shell wall: ring-mode mass, large stiffness *)
m2 = 0.5;              (* ~500 g effective wall mass *)
k2 = (2 Pi 800.)^2 * m2;   (* assumed ring mode ~800 Hz *)

(* Air cavity: lumped Helmholtz oscillator *)
m3 = 0.01;             (* effective air-plug mass at port *)
k3 = (2 Pi fHV1)^2 * m3;

(* Coupling stiffnesses *)
k12 = 0.10 * k1;       (* 10% of tongue stiffness through rabbet *)
k23 = 0.05 * k3;       (* 5% wall-air through compliance *)

KMat = {
  {k1 + k12,   -k12,   0.0  },
  {-k12,       k2 + k12 + k23, -k23},
  {0.0,        -k23,   k3 + k23}
};
MMat = DiagonalMatrix[{m1, m2, m3}];

eigSystem = Eigensystem[N[Inverse[MMat] . KMat]];
omegas = Sqrt[eigSystem[[1]]];
freqs  = Sort[omegas / (2 Pi)];

Print[];
Print["3-DOF coupled-oscillator eigenfrequencies (V1 preset):"];
Print["  Lone tongue     : ", NumberForm[fDing, 5], " Hz"];
Print["  Coupled f1      : ", NumberForm[freqs[[1]], 5], " Hz (Helmholtz-dominated)"];
Print["  Coupled f2      : ", NumberForm[freqs[[2]], 5], " Hz (tongue-dominated)"];
Print["  Coupled f3      : ", NumberForm[freqs[[3]], 5], " Hz (wall-mode-dominated)"];
Print["Sustain hint: closer f1 and f2 -> stronger bass/mid coupling."];

(* === 6. Manipulate: tune the cavity in real time === *)

(*
   Open this in Wolfram Desktop. Drag gu port size; watch the
   Helmholtz / ding ratio cross the coupled band.
*)

manipulateCell = Manipulate[
  Module[{A, V, Lneck, fH, ratio},
    A = Pi (gu/2)^2;
    V = If[variant == "V1", Pi (shellOD/2)^2 hh,
        If[variant == "V2", Pi (shellOD/2)^2 hh + (2/3) Pi (shellOD/2)^2 dr,
        If[variant == "V3", (2/3) Pi (shellOD/2)^3,
                            (2/3) Pi (shellOD/2)^3 + (2/3) Pi (shellOD/2)^2 dr]]];
    Lneck = If[variant == "V1" || variant == "V3", sbThk, sbThk + dr/2];
    fH = (cAir/(2 Pi)) Sqrt[A/(V Lneck)];
    ratio = fH / fFromMidi[ding];
    Column[{
      Row[{"Helmholtz f_H = ", NumberForm[fH, 5], " Hz"}],
      Row[{"Ding         = ", NumberForm[fFromMidi[ding], 5], " Hz"}],
      Row[{"Ratio        = ", NumberForm[ratio, 3],
           If[0.80 <= ratio <= 1.20, " <- coupled", " <- mistuned"]}]
    }]
  ],
  {{variant, "V1"}, {"V1", "V2", "V3", "V4"}, ControlType -> RadioButtonBar},
  {{ding, 57, "ding MIDI"}, 50, 70, 1},
  {{gu, 2.5, "gu port (in)"}, 0.5, 4.0, 0.05},
  {{hh, 8.0, "shell height (in)"}, 4.0, 12.0, 0.1},
  {{dr, 0.75, "dome rise (in)"}, 0.0, 1.5, 0.05}
];

(* manipulateCell *)  (* uncomment to display *)

(* === 7. Audio synthesis (preview) === *)

(* AudioGenerator can render the predicted tongue field; useful for
   pre-build pitch-target previews. *)

scaleAKurd = {220.00, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25,
              587.33, 659.26, 783.99, 880.00};

(* tonguePulse[freq] returns a short attack-decay envelope over a sine
   approximation of the tongue's first mode *)
tonguePulse[freq_, dur_:0.6] :=
  Sound[SoundNote["", dur, "FluteSection", SoundVolume -> 0.6, freq]];

(* Uncomment to play the predicted A Kurd scale: *)
(* AudioPlay[Sound[Table[tonguePulse[f], {f, scaleAKurd}]]] *)

(* === 8. Notes for the per-family corrections database === *)

(*
   When the first prototype is tuned, run scripts/record_measurement.py
   from the parent instrument-maker skill. Each measurement updates:

     - K_constant for sbWood (per stock batch)
     - curved-cantilever multiplier (V2/V4 only, per dome rise)
     - end-correction term for Helmholtz neck length (per shell type)

   These propagate to every sibling packet in the wood-shell-tongue-drum
   family on next packet generation.
*)
```

<div class="page-break"></div>

## README.md

Project artifact.

# Wood Shell Tongue Drum

Slit-tongue idiophone with an enclosed wooden resonator. A round-body counterpart to the rectangular-prism wood tongue drum, with **Helmholtz cavity coupling** absent from open designs. Four geometric variants × three size envelopes, all parametric and traceable to a single design table.

Part of the [tonykoop/instrument-maker](https://github.com/tonykoop/instrument-maker) catalogue.

![V1 Standard 16″ side section A-A](drawings/00-hero-v1-standard.svg)

*V1 Cylinder + Flat Top, Standard 16″ — recommended first prototype. Black Walnut staves, Padauk soundboard, A Kurd 11-tongue field, gu port for Helmholtz tuning. Computed `f_H = 194.6 Hz` sits at 0.88 × the A3 ding (220 Hz) — inside the coupled regime by design.*

## What's new in this design

A round-body wood tongue drum with an enclosed cavity is not a commercial category at this depth. Three things distinguish it:

1. **Round body, not rectangular.** Tony's existing rectangular-prism wood tongue drum is the precursor; this design moves the same flat-cantilever physics onto a turned cylinder or hemisphere bowl.
2. **Enclosed Helmholtz cavity.** Open rectangular tongue drums waste cavity volume out the open ends. Closing the bowl puts a Helmholtz resonator under the tongue field — bass extension below the lowest tongue, tunable in the shop via the gu port.
3. **Premium tonewoods, manufacturable scope.** Padauk soundboard for the A4 reference; Black Walnut shell for the bowl. Four variants × three sizes laid out as a coordinated portfolio family rather than four bespoke pieces.

## The matrix

Four geometric variants × three size envelopes = twelve cells. Each cell carries its own chamber volume, Helmholtz frequency, tongue-fit verdict, and risk grade.

| Variant | Body                          | Top                  | Risk    | Notes                                              |
|---------|-------------------------------|----------------------|---------|----------------------------------------------------|
| V1      | Cylinder (ottoman silhouette) | Flat soundboard      | ★★      | Lowest piece-count, most predictable tuning. **Start here.** |
| V2      | Cylinder                      | Shallow CNC-domed    | ★★★     | Steel-tongue-drum aesthetic on a wooden body       |
| V3      | Hemisphere bowl               | Flat soundboard      | ★★      | Tagine / Moroccan-pouf silhouette                  |
| V4      | Hemisphere bowl               | Domed top            | ★★★★    | Most steel-tongue-drum-adjacent silhouette in wood |

**Sizes:** Travel 12″ Ø · Standard 16″ Ø (Moroccan-ottoman scale) · Floor Pouf 20″ Ø.

The full Helmholtz/ding ratio matrix is in [`design.md`](design.md) §2.4. Three cells sit cleanly in the coupled regime (V1 Standard, V1 Floor Pouf, V3 Standard); V2 cells need a smaller-than-preset gu port to reach coupling; V1 Travel sits right at the upper edge of the band.

## Recommended first prototype

**V1 Cylinder + Flat Top, Standard 16″, A Kurd, A3 ding (220 Hz), 11 tongues.** Justification:

- Acoustic predictability — flat-cantilever physics has < 1 % empirical detuning on Tony's prior rectangular drums.
- Helmholtz coupled out-of-the-box at `f_H/f_ding = 0.88`.
- All 11 A Kurd tongues fit within the 7″ radial cap with 8 % margin.
- Lowest piece-count: 16 staves + 1 disc = 17 wood pieces.
- Dual body-construction paths (stave or segmented) — pick the aesthetic, the physics is the same.
- Validated workflow components — stave glue-up, lathe truing, CNC slit routing — exercised on Tony's existing ashiko, conga, and tongue-drum repos.

Detailed prototype spec (dimensions, tongue length schedule, joint tolerances) in [`design.md`](design.md) §4.

## Acoustic model in one paragraph

The wood shell tongue drum is a 2-DOF coupled oscillator: the cantilever tongue is one resonator, the enclosed air cavity is another, and they share a common boundary (the soundboard). Tongues follow flat-cantilever Euler-Bernoulli `f = K · t / L²`, with `K ≈ 24,438` for Padauk. Domed tongues add a +2.5 % length correction (a starting estimate to be calibrated empirically on the first V2 build). The cavity follows the Helmholtz formula `f_H = (c/2π) · √(A_port / (V · L_neck))`; the gu port is the primary tuning knob — drilled last and step-bored in the shop while measuring `f_H`. Target: `f_H/f_ding ∈ [0.80, 1.20]`. See [`design.md`](design.md) §2 for the full derivation.

## Repo contents

| File / folder                                  | Purpose                                                   |
|------------------------------------------------|-----------------------------------------------------------|
| [`design.md`](design.md)                       | Governing model, variant blocks, recommended prototype    |
| [`wood-shell-tongue-drum-design-table.xlsx`](wood-shell-tongue-drum-design-table.xlsx) | Parametric workbook (190 formulas, 1 sheet)               |
| [`bom.csv`](bom.csv) / [`sourcing.csv`](sourcing.csv) / [`cut-list.csv`](cut-list.csv) / [`validation.csv`](validation.csv) | Manufacturing CSVs                                        |
| [`assembly-manual.md`](assembly-manual.md)     | 7-phase build instructions                                |
| [`supplier-rfq.md`](supplier-rfq.md)           | Q2 2026 batch supplier RFQ                                |
| [`drawing-brief.md`](drawing-brief.md) / [`drawings/`](drawings/) | 9-sheet drawing spec + hero SVG                           |
| [`visual-bom-brief.md`](visual-bom-brief.md) / [`photo-shotlist.md`](photo-shotlist.md) | Photography briefs                                        |
| [`risks.md`](risks.md)                         | Red-team pass with verification tests attached            |
| [`wolfram-starter.wl`](wolfram-starter.wl)     | 3-DOF coupled-oscillator notebook starter                 |
| [`capstone-deck.md`](capstone-deck.md) / [`print-packet.md`](print-packet.md) | Recruiter-facing deck + shop-floor printable packet       |
| [`cad/`](cad/) / [`cnc/`](cnc/)                | Toolpath plans (G-code/SolidWorks files staged)          |
| [`site/index.html`](site/index.html)           | Build-log static site                                     |
| [`concepts/`](concepts/)                       | Original concept sheet (ideation, not manufacturable)     |

## Build status

- ✅ Parametric design table (workbook + `design.md` packet)
- ✅ BOM, sourcing, cut list, validation CSVs
- ✅ Assembly manual, supplier RFQ, drawing brief, visual BOM brief, photo shot list
- ✅ Risks register (16 entries across acoustic, structural, ergonomic, supply, fit/finish)
- ✅ Wolfram notebook starter (3-DOF coupled oscillator)
- ✅ Build-log site (`site/index.html`)
- ✅ Hero side-section drawing (`drawings/00-hero-v1-standard.svg`)
- ⏳ Phase 1 prototype: V1 Cylinder · Flat at 16″ Standard
- ⏳ SolidWorks CAD assembly (deferred until first-prototype calibration)
- ⏳ Auto-generated SVG sheets 01–09 from `scripts/generate_drawings.py`
- ⏳ Capstone .pptx and print-packet .pdf (Markdown sources ship; binary outputs build from them)

## Highest-risk unknowns

To be retired by Phase 1 measurements:

1. Curved-cantilever multiplier for our specific dome rise (V2/V4 only; +2.5 % is a starting estimate).
2. Helmholtz end-correction term for slit ports vs circular ports (all variants).
3. Padauk K-constant for our specific stock vs the library value (24,438).
4. Bowl-top rabbet joint long-term durability under seasonal humidity cycling.
5. Player ergonomics on Floor Pouf 20″ (new size class for Tony's catalog).

Full risk register with mitigations and verification tests in [`risks.md`](risks.md).

## Sister repos

- [`tonykoop/tongue-drum`](https://github.com/tonykoop/tongue-drum) — rectangular-prism precursor, validates flat-cantilever physics
- [`tonykoop/steel-tongue-drum`](https://github.com/tonykoop/steel-tongue-drum) — steel cantilever cousin
- [`tonykoop/ceramic-tongue-drum`](https://github.com/tonykoop/ceramic-tongue-drum) — slip-cast cousin
- [`tonykoop/ashiko-drum-workshop`](https://github.com/tonykoop/ashiko-drum-workshop) — segmented bowl reference
- [`tonykoop/conga`](https://github.com/tonykoop/conga) — stave & segmented shell reference
- [`tonykoop/instrument-maker`](https://github.com/tonykoop/instrument-maker) — orchestrating skill, Master Catalog, validate_packet.py

## License

[CC BY 4.0](LICENSE) — see LICENSE for details. The design (workbook, drawings, narrative) is shared under CC BY 4.0; the maker should still apply their own judgment to material selection and shop safety.

<div class="page-break"></div>

## photo-shotlist.md

Project artifact.

# Photo Shot List — Wood Shell Tongue Drum

Generated: 2026-05-07

This shot list feeds the build-log site (`site/index.html`), the printable shop packet, and any future capstone-deck refresh. Real photographs replace SVG placeholders as builds complete. Until prototypes exist, the SVG drawings carry the visual weight of the documentation.

## Required hero and overview

| Shot ID  | Subject                                                          | Purpose                              | Status |
|----------|------------------------------------------------------------------|--------------------------------------|--------|
| HERO-001 | V1 Standard 16″ finished, 3/4 angle, on neutral backdrop         | README hero, build-log site cover    | Needed |
| HERO-002 | All four variants (V1–V4) at Standard 16″ in a row, soundboards facing camera | Family lineup; print packet cover    | Needed (after Phase 4) |
| HERO-003 | Three-size ladder (Travel + Standard + Floor Pouf) of V1 only    | Size-progression catalog shot        | Needed (after Phase 5) |
| HERO-004 | V1 Standard in-hand with mallets, top-down                       | Scale and ergonomics                 | Needed |

## Construction process — V1 Standard (recommended first prototype)

| Shot ID    | Subject                                                                  | Purpose                                                  | Status |
|------------|--------------------------------------------------------------------------|----------------------------------------------------------|--------|
| BUILD-101  | 16 stave blanks rough-cut, fanned out                                    | Stock prep                                               | Needed |
| BUILD-102  | Stave on tilting-arbor jig with 11.25° bevel cut                         | Miter setup                                              | Needed |
| BUILD-103  | Staves taped flat, edges glued, ready to roll into cylinder              | Stave glue-up Phase 1A.3                                 | Needed |
| BUILD-104  | Cylinder under three ratchet straps, squeeze-out beading                 | Glue-up clamp                                            | Needed |
| BUILD-105  | Shell mounted on lathe, OD truing pass                                   | Phase 1A.4                                               | Needed |
| BUILD-106  | Rim rabbet detail, ¼″ × ⅜″, dial indicator showing TIR                  | Critical-tolerance shot                                  | Needed |
| BUILD-107  | Padauk soundboard disc on CNC, 1/8″ upcut spiral routing tongue slits    | Phase 2A; cite slit kerf 0.125″                         | Needed |
| BUILD-108  | Slit field complete on soundboard, top-down                              | Tongue layout reference                                  | Needed |
| BUILD-109  | Rabbet joint dry-fit, soundboard half-engaged                            | Air-seal demonstration                                   | Needed |
| BUILD-110  | Rabbet joint glued and clamped with cauls                                | Phase 3.1                                                | Needed |
| BUILD-111  | Gu-port step-drilling with mic + Korg in frame                           | Phase 4 — Helmholtz tuning                               | Needed |
| BUILD-112  | Tongue tuning with sanding bar, Korg OT-120 reading                      | Phase 5 — final tuning                                   | Needed |

## Domed-top variant (V2 Standard) — additional shots

| Shot ID    | Subject                                                            | Purpose                                  | Status |
|------------|--------------------------------------------------------------------|------------------------------------------|--------|
| DOME-201   | Poplar test blank with dome surfacing complete                     | De-risk shot                             | Needed |
| DOME-202   | Padauk dome blank in flip-jig, datum pins visible                  | CNC workholding                          | Needed |
| DOME-203   | Domed Padauk top, raking light to show 0.75″ rise                  | Profile reference                        | Needed |
| DOME-204   | First-tongue calibration cut, single tongue, before mass-cutting   | Curved-cantilever validation             | Needed |
| DOME-205   | Korg + tap test on the calibration tongue                          | Multiplier measurement                   | Needed |

## Hemisphere-bowl variants (V3, V4) — additional shots

| Shot ID    | Subject                                                              | Purpose                                  | Status |
|------------|----------------------------------------------------------------------|------------------------------------------|--------|
| BOWL-301   | Graduated rings stacked but unglued, showing decreasing-dia profile  | Segmented bowl construction              | Needed |
| BOWL-302   | Single ring closed and glued on lazy-susan jig                       | Per-ring closure                         | Needed |
| BOWL-303   | Stacked bowl on lathe, profile-truing pass                           | Lathe-truing the spherical exterior      | Needed |
| BOWL-304   | Finished bowl rim with planar TIR check                              | Rim flatness verification                | Needed |

## Detail and material shots

| Shot ID    | Subject                                                            | Purpose                                  | Status |
|------------|--------------------------------------------------------------------|------------------------------------------|--------|
| DETAIL-401 | Stave miter close-up against digital protractor                    | 11.25° angle reference                   | Needed |
| DETAIL-402 | Tongue slit terminus geometry, extreme close-up                    | Slit corner relief                       | Needed |
| DETAIL-403 | Padauk grain detail on finished soundboard                         | Material identification                  | Needed |
| DETAIL-404 | Black Walnut shell exterior with Watco Danish Oil finish, raking   | Finish quality                           | Needed |
| DETAIL-405 | Buna-N O-ring installed in finished gu port                        | Optional Hapi-style detail               | Needed |

## Ergonomic / play context

| Shot ID    | Subject                                                            | Purpose                                  | Status |
|------------|--------------------------------------------------------------------|------------------------------------------|--------|
| PLAY-501   | Player seated, V1 Standard on lap, two-mallet position             | Lap-play ergonomics                      | Needed |
| PLAY-502   | Player at floor with Floor Pouf, both hands striking outer tongues | Floor-play reach                         | Needed |
| PLAY-503   | Side-by-side: player hands on Standard vs Floor Pouf               | Size comparison for ergonomics           | Needed |

## Audio reference

Not photo, but live audio recordings should accompany the build-log site:

| Track ID  | Subject                                              | Purpose                              | Status |
|-----------|------------------------------------------------------|--------------------------------------|--------|
| AUDIO-001 | Single ding strike, decay to silence                  | Sustain T60 measurement              | Needed |
| AUDIO-002 | Full A Kurd scale played up                          | Tuning verification                  | Needed |
| AUDIO-003 | A vs B vs C vs D — same scale, four variants         | Variant tonal comparison             | Needed (after Phase 4) |
| AUDIO-004 | Cavity puff test recording with visible f_H peak      | Helmholtz validation evidence        | Needed |

## Status legend

- **Needed** — not yet captured; SVG or sketch placeholder until then.
- **Captured** — file path replaces this entry; image embedded in `site/index.html`.
- **Reshoot** — captured but rejected on quality / framing; queued.

## Photography conventions

- **Backdrop:** kraft butcher paper or off-white seamless for hero shots; raw shop bench OK for build-process shots.
- **Lighting:** one diffused softbox 45° camera-left for hero/detail; ambient shop light + tripod-stable shutter for process.
- **Format:** all photographs landscape 3:2 unless explicitly portrait. Hero is portrait 4:5.
- **Resolution:** 4000 × 6000 minimum at capture; export 2000 × 3000 web JPEG for the site.
- **Naming:** `images/<SHOT_ID>_<short-slug>.jpg` (e.g., `images/HERO-001_v1-std-finished.jpg`).

<div class="page-break"></div>

## risks.md

Project artifact.

# Risks — Wood Shell Tongue Drum

Red-team pass over the design. Each risk has a category, severity, mitigation, and an attached verification test that is mirrored into `validation.csv` so the empirical-learning loop closes around it once the prototype exists.

This is a *new* design — no commercial wood-shell tongue drums exist in the round-body × dome-top × premium-tonewood format at this depth — so the risk surface is broader than for a refinement of an established pattern. The first physical prototype's measurements will retire most of the acoustic risk; structural and ergonomic risks need pre-prototype mitigation.

---

## Acoustic

### A1 — Curved-cantilever +2.5 % multiplier is unmeasured for our specific dome rise (V2, V4)

**Severity:** high (V2, V4 only)
**Description:** The tongue length correction `L_curved = L_flat × 1.025` is a starting estimate from cylinder-shell theory for shallow domes. The actual factor for our specific dome rise (0.75″ on Standard, 4.7 % of OD) is not measured. If the actual factor is, say, 1.04, every tongue cut at 1.025-multiplier length will sit ~30 cents flat across the field.
**Mitigation:** before cutting all 11 tongues on a V2/V4 build, cut ONE tongue at the predicted length, measure pitch with a Korg OT-120, back-solve the actual multiplier (`m_actual = sqrt(f_meas / f_predicted)` adjusted for the cut geometry), and apply the corrected multiplier to the remaining 10. The first dome build is also the first measurement entry into the per-family corrections database.
**Verification test:** "first-tongue calibration" entry in `validation.csv` for V2/V4 only — measured/predicted ratio with acceptance band 0.95–1.10.

### A2 — Helmholtz under-coupling on V2 and V4 with preset gu port

**Severity:** medium
**Description:** V2 and V4 ratios on Standard 16″ are 0.61 and 0.73 respectively — under-coupled. The cavity's Helmholtz resonance sits well below the ding and won't reinforce it. The drum will sound fine but not gain the bass extension the design promises.
**Mitigation:** the gu port preset (2.5″ on Standard) is intentionally generous so the in-shop step-drill protocol can land the right size. For V2/V4 builds, start the port at 1.0″ (not 2.5″) and step up only until the ratio enters the 0.80–1.20 band. The smaller port raises `f_H`. Document the final port size in the per-variant validation.csv row.
**Verification test:** Helmholtz cavity row in `validation.csv` per variant; pass = `f_H/f_ding` ∈ [0.80, 1.20].

### A3 — Floor Pouf D3 ding tongue exceeds radial fit cap

**Severity:** high (Floor Pouf only)
**Description:** Computed flat-cantilever D3 ding length on 0.5″ Padauk = 9.122″. Fit cap (radius − 1″ clearance) = 9.0″. Tongue overhangs by 0.12″ — does not fit.
**Mitigation:** three options, ordered by preference:
  1. **Cedar substitute** for the Floor Pouf soundboard (K = 29,013). Computed length 8.34″ — fits with 0.66″ margin. Tonal trade: brighter, more guitar-like, less bass.
  2. **Thin the soundboard** from 0.5″ to 0.4375″. Computed length 8.53″ — fits with 0.47″ margin. Trade: stiffness across a 20″ span drops; risk of soundboard sag.
  3. **Raise ding to D♯3** (one semitone, MIDI 51, 155.6 Hz). Computed length 8.86″ at 0.5″ Padauk — fits with 0.14″ margin. Trade: scale shift; player must learn the new key.
**Verification test:** ding tongue length measurement vs cap before slit cuts; abort cut if margin < 0.10″.

### A4 — Soundboard rabbet leaks → Helmholtz Q drops

**Severity:** medium
**Description:** Helmholtz resonators need an airtight cavity to sustain bass. A leaky rabbet joint will let the cavity bleed pressure on each tongue strike, killing the bass extension.
**Mitigation:** lathe-trued rim (± 0.005″ TIR), slip-fit rabbet (0.005″ clearance), uniform Titebond III bead, two-caul clamp. Smoke or vacuum test before finishing.
**Verification test:** "bowl-top airtight seal" row in `validation.csv` — pass/fail vacuum or smoke test post-glue, pre-finish.

### A5 — End-correction error in Helmholtz formula

**Severity:** low
**Description:** The Helmholtz formula uses `L_neck = soundboard_thickness` for flat tops. The actual oscillating air column extends slightly above and below the soundboard plane (the "end correction" of an open pipe). For tongue-drum kerfs (slit, not circular) this is small but nonzero.
**Mitigation:** the design currently absorbs the error in the 0.88-ratio safety margin (so even if the actual `f_H` runs 5–10 % low, it stays in the coupled band). If first-prototype `f_H` measures > 10 % below predicted, add an empirical end-correction term to the workbook formula and update the per-family corrections database.
**Verification test:** "Helmholtz cavity" row in `validation.csv`; if `(predicted - measured) / predicted > 0.10`, file an empirical-correction update.

### A6 — A4 ≠ 440 Hz on the prototype

**Severity:** low (failure mode, not a design risk — but the catch is structural)
**Description:** Tongue 4 on the recommended prototype is A4 (440 Hz). If the measured A4 is off > 5 cents, the K-constant of our specific Padauk stock differs from the library value (24,438). All other tongue lengths will be proportionally wrong.
**Mitigation:** cut tongue 4 first as a calibration tongue; measure A4; back-compute `K_actual = f_measured × L² / t`; update the workbook K-cell; recompute all 10 remaining tongue lengths before cutting.
**Verification test:** "A4 = 440 Hz sanity" row in `validation.csv`.

---

## Structural

### S1 — Soundboard slit-area exceeds 50 % limit causes rim-zone failure

**Severity:** medium
**Description:** Removing too much material from the soundboard (slits + perimeter rabbet relief) leaves the rim zone too weak; under cantilever loading from the tongues plus rim constraint from the rabbet, the rim could chip or split, especially in Padauk's straight-grain regions.
**Mitigation:** total slit kerf + rabbet area held at ~30 % of soundboard area on V1 Standard (verified against the 11-tongue layout). Stay-zones at least 0.75″ wide between adjacent tongue slits.
**Verification test:** measure slit-area fraction during CAD/CNC programming; reject layouts > 45 %.

### S2 — Stave glue-line failure under thermal/humidity cycling

**Severity:** low-medium
**Description:** Black Walnut staves have axial grain and tangential growth. Seasonal humidity cycling could open glue lines (especially if the shell finishes too soon after glue-up).
**Mitigation:** Titebond III is rated 4000 psi shear (waterproof PVA), well above structural minimum. Cure full 24 h before lathe-truing. Acclimate stock 2 weeks pre-glue. Apply finish to *exterior* only — leave the interior unfinished so the wood can equalize humidity through one face.
**Verification test:** glue-line shear sample test (one sacrificial joint per glue batch); reject batch if test joint fails < 3000 psi.

### S3 — Soundboard cup or warp during finish drying

**Severity:** medium
**Description:** Finishing only one face of a soundboard (Watco on top, unfinished underside) creates a moisture gradient. If finish is applied too thick or too fast, the disc cups, lifting tongue tips off neutral and detuning the field.
**Mitigation:** thin coats (3 light coats vs 1 heavy), 24 h between coats, finish in same humidity environment as glue-up. Hold the disc flat on cauls for the first cure.
**Verification test:** post-finish flatness check across diagonal — disc should be flat within 1/64″ over 16″ span.

### S4 — Bowl ring-stack delamination at lathe truing (V3, V4)

**Severity:** medium (V3, V4)
**Description:** A segmented bowl with 8+ rings stacked has many glue joints under shear during lathe truing. A weak joint shows up as a "spinning piece flying off" — both a build hazard and a quality failure.
**Mitigation:** glue each ring closed BEFORE stacking; cure 24 h between layers; verify each ring's closure with a feeler gauge (< 0.005″ at glue lines) before adding the next. Lathe at moderate speed (800–1200 rpm) with sharp tools to minimize cutting forces.
**Verification test:** feeler-gauge check per glue line during stack-up; reject ring if any joint > 0.005″.

---

## Ergonomic / playability

### E1 — Standard 16″ too heavy for lap play

**Severity:** low
**Description:** Estimated weight 6–7 lb for V1 Standard 16″ — heavier than a lap-played Hapi steel tongue drum (~4 lb). Player fatigue on extended sessions.
**Mitigation:** acceptable trade for the wood acoustic benefit. Optional carry handle (`HANDLE-ROPE-S` in BOM) makes the drum portable. Floor Pouf 20″ is explicitly intended for floor placement, not lap.
**Verification test:** finished-drum weight measurement; document in catalog row but don't gate on this.

### E2 — Tongue layout reach for 5th-percentile player hand

**Severity:** low
**Description:** Tongues at radius 6.5″ from ding centerline require a ~13″ hand-span reach (across the ding). A 5th-percentile adult female hand-span is ~7″, so the maximum-radius tongues are at the edge of comfortable reach.
**Mitigation:** the radial coords are estimates and will be tightened during SolidWorks parametric placement against the actual shell radius. Recommended max radius from ding centerline: 6.0″ on Standard 16″, with the 7-tongue ergonomic envelope inside 5.0″.
**Verification test:** ergonomic photo with two-hand reach over the finished drum; note any tongue requiring a player to lean to strike.

---

## Supply / material

### SUP1 — Padauk 3/8″ thickness availability

**Severity:** low
**Description:** Padauk is commonly stocked in 4/4 (rough 1″, S2S 13/16″) but 3/8″ is non-standard. Suppliers may resaw to spec but with no guarantee of edge straightness or grain orientation match.
**Mitigation:** order 4/4 stock and resaw + plane to 3/8″ in-shop. Adds 1 h labor per soundboard but guarantees control over thickness uniformity.
**Verification test:** confirm 3/8″ stock at order time; if not available, switch to 4/4 + resaw plan.

### SUP2 — Mule hide / drum-skin substitution attempts

**Severity:** low (filed for awareness)
**Description:** A reviewer or supplier might confuse this design with a membrane drum (conga, ashiko) and try to ship drum heads. This is a slit-tongue idiophone — no skins.
**Mitigation:** explicit "N/A — no skins required" in the supplier RFQ and BOM.

---

## Fit / finish

### F1 — Slit edges chipped during sanding

**Severity:** medium
**Description:** A chipped slit edge changes the tongue's effective length and shifts pitch by tens of cents. Sanding past 320 grit near the slits is risky.
**Mitigation:** sand the soundboard *before* CNC slit routing for any work that requires aggressive grits. Post-slit, hand-sand only with light pressure, 320–600 grit, parallel to slit length, never across.
**Verification test:** visual inspection under raking light; reject any chip > 0.020″.

### F2 — Finish bleeds into slits and stiffens tongue base

**Severity:** low-medium
**Description:** Watco Danish Oil applied to the soundboard top can wick into the slit kerfs and accumulate at the tongue-base radius, locally stiffening the cantilever and shifting pitch ~5–15 cents sharp per tongue.
**Mitigation:** apply finish *before* slit cutting if the finish workflow allows. Otherwise, use a thinned finish (1:1 with mineral spirits) on the soundboard top, wipe excess immediately, and never flood the slits.
**Verification test:** post-finish A4 measurement; if A4 has shifted > 5 cents from pre-finish, document as a finish-bleed effect and quantify for the next build.

---

## Risk summary table

| ID  | Category    | Severity | Variants affected | Mitigation in place | Verification gate            |
|-----|-------------|----------|--------------------|---------------------|------------------------------|
| A1  | Acoustic    | High     | V2, V4             | Yes (first-tongue calib) | first-tongue cal in validation.csv |
| A2  | Acoustic    | Medium   | V2, V4             | Yes (smaller port)  | f_H/f_ding ratio band       |
| A3  | Acoustic    | High     | Floor Pouf only    | Yes (Cedar / D♯3)   | ding length vs cap           |
| A4  | Acoustic    | Medium   | All                | Yes (rim TIR + smoke test) | bowl-top airtight seal       |
| A5  | Acoustic    | Low      | All                | Yes (safety margin) | f_H deviation > 10 %         |
| A6  | Acoustic    | Low      | All                | Yes (calibration tongue) | A4 sanity row                |
| S1  | Structural  | Medium   | All                | Yes (slit-area cap) | slit-area fraction ≤ 45 %    |
| S2  | Structural  | Low-Med  | All (stave path)   | Yes (Titebond III)  | glue-line sample shear test  |
| S3  | Structural  | Medium   | All                | Yes (thin coats)    | post-finish flatness         |
| S4  | Structural  | Medium   | V3, V4             | Yes (per-ring cure) | feeler gauge per joint       |
| E1  | Ergonomic   | Low      | All                | Optional handle     | weight measurement (no gate) |
| E2  | Ergonomic   | Low      | All                | Yes (radius cap)    | reach photo on prototype     |
| SUP1| Supply      | Low      | All                | Yes (resaw plan)    | order-time confirm           |
| SUP2| Supply      | Low      | All                | Yes (RFQ note)      | N/A                          |
| F1  | Fit/Finish  | Medium   | All                | Yes (sand sequence) | edge inspection              |
| F2  | Fit/Finish  | Low-Med  | All                | Yes (thin finish)   | A4 shift post-finish         |

---

## Highest-risk unknowns (to be retired by Phase 1 measurements)

1. **Curved-cantilever multiplier for our specific dome rise.** Will be measured on the first V2 build; until then, V2/V4 cuts are conditional on calibration.
2. **Helmholtz end-correction term.** Will be measured on the first V1 build; the design currently absorbs the uncertainty in the safety margin but the workbook formula may need an empirical update.
3. **Padauk K-constant for our specific stock.** The library value 24,438 is from textbook E and ρ; the actual stock may vary 2–5 %. A4 calibration on Phase 1 catches this.
4. **Bowl-top joint long-term durability.** Rabbet + Titebond III is the working assumption; 12+ months of seasonal cycling will reveal whether the joint holds.
5. **Player ergonomics on Floor Pouf.** A 20″-OD drum with the largest tongue at 9″+ length is a new size class for Tony's catalog. First-prototype reach photos will inform whether the radial layout needs revision.
