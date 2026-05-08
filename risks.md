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
**Mitigation:** the gu port preset (2.5″ on Standard) is a reviewable starting point, not a fixed feature. For V2/V4 builds, start with a pilot hole, step up in 0.25″ increments, and expect a larger effective port than V1 because larger port area raises `f_H`. The Standard 16″ V2 lower coupled edge is estimated near 3.3″; if that is structurally or aesthetically too large, switch to a port sleeve / neck-length experiment and record the revised model.
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
| A2  | Acoustic    | Medium   | V2, V4             | Yes (larger effective port or port-sleeve model) | f_H/f_ding ratio band       |
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
