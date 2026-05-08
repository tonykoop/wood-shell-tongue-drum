# Wood Shell Tongue Drum Capstone
- Public-ready design packet for a round-body wooden slit-tongue idiophone
- Repo: `wood-shell-tongue-drum`
- Refreshed: 2026-05-08

---

# Project Intent
- Build a reviewable public repo for a wood-shell tongue drum family before the first physical prototype.
- Stress idiophone tuning, Helmholtz coupling, CNC/laser planning, jig decisions, and measured validation.
- Recommended first build: V1 Cylinder + Flat Top, Standard 16 in, A Kurd, A3 ding.

---

# Why This Is A Strong Candidate
- It extends Tony's rectangular `tongue-drum` work into a round enclosed resonator.
- The first prototype is practical: 16 walnut staves, one Padauk soundboard disc, CNC tongue slits, step-drilled gu port.
- The later V2/V4 dome variants create a visible portfolio story after V1 calibrates the physics.

---

# Governing Model
- Tongues: fixed-free cantilever, `f = K * t / L^2`.
- Default soundboard: Padauk, `K = 24438`, 0.375 in thick on the Standard 16 in build.
- Cavity: Helmholtz resonator, `f_H = (c / 2pi) * sqrt(A_port / (V * L_neck))`.
- Target coupling: `0.80 <= f_H/f_ding <= 1.20`.

---

# Prototype Tuning
- Scale: A Kurd, 11 tongues from A3 through A5.
- A4 is the sanity check: if measured A4 misses by more than 5 cents, back-solve the actual Padauk K constant.
- Tongues are cut 0.030 in long, then tuned by tip filing while logging cents error.
- Success target: all tongues within +/- 5 cents after settling and finish.

---

# Helmholtz Coupling
- V1 Standard predicts `f_H = 194.6 Hz`, or `0.88 * A3 ding`.
- Opening the gu port raises `f_H`; a restrictor/liner or longer neck lowers it.
- V2 Standard is under-coupled at the 2.5 in preset, so its validation build treats port size as a measured variable.
- Every port diameter step gets logged in `validation.csv`.

---

# CNC And Laser Plan
- CNC: 1/8 in upcut spiral for tongue slits; 1/4 in compression for OD profile; 3/4 in ball-end for later dome surfacing.
- Laser templates: tongue overlay, vacuum/tape clearance map, stave labels, gu-port log card.
- Public review artifact: `cnc/jig-and-template-plan.md` explains fixture choices before G-code exists.
- G-code is intentionally deferred until V1 measurements calibrate the workbook and hold-down strategy.

---

# Jig Decisions
- Shell: 16-stave walnut cylinder with 11.25 degree bevels.
- Glue-up: MDF cylinder caul plus band clamp.
- Lathe: waste-block faceplate plus soft expansion plug.
- Soundboard: MDF spoilboard, laser-cut hold-down clearance template, CNC center datum.
- Dome variants: three-pin flip jig only after V1 validates the flat model.

---

# Manufacturing Packet
- `design.md`: model, variant matrix, recommended prototype, tongue schedule.
- `bom.csv`, `sourcing.csv`, `cut-list.csv`: materials, suppliers, rough/final stock.
- `assembly-manual.md`: seven-phase build sequence and tuning loop.
- `drawing-brief.md`: nine-sheet drawing target, including gu-port tuning progression.

---

# Validation Plan
- Pitch: Korg OT-120 or cents-resolution tuner for every tongue.
- Cavity: microphone + REW/Spectroid puff test at each gu-port step.
- Geometry: rim TIR, wall thickness, soundboard thickness, kerf width, port concentricity.
- Finish drift: re-measure A4 after oil/wax to catch finish bleed into kerfs.

---

# Risk Register
- Acoustic: domed-tongue multiplier and Helmholtz end correction are unmeasured.
- Structural: stave miter drift, rim leaks, and seasonal soundboard movement can reduce sustain.
- Ergonomic: Floor Pouf 20 in is a floor instrument, not a lap instrument.
- Fit/finish: chipped slit edges and oil bleed can move pitch by audible cents.

---

# Public Repo Readiness
- README, design sheet, CSVs, assembly manual, RFQ, risks, Wolfram starter, and site are present.
- Print packet PDF has been regenerated from the current sources.
- `validation-report.md` records the public-readiness pass and remaining human-owned work.
- Remaining blocker for full portfolio polish: physical prototype photos/audio and refreshed PPTX export when python-pptx is available.

---

# Next Build Step
- Cut the V1 Standard soundboard test in poplar or MDF.
- Measure kerf width and A4 predicted pitch behavior.
- Build the walnut shell, seal-test the rim, and step-drill the gu port while logging `f_H`.
- Feed measurements back into `validation.csv` before generating final CAD/G-code.
