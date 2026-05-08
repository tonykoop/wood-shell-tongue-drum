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
