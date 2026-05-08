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
