(* ::Package:: *)

(* Wolfram QA 2026-05-30: estimate - pending measurement, not fabrication authority.
   Variables and associations with Estimate suffix are planning values only unless
   later replaced by measured validation data or reviewed design-table authority. *)

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
shellODEstimate       = 16.0;          (* shell outer diameter *)
shellHeightEstimate   = 8.0;           (* cylinder body height *)
shellThkEstimate      = 0.625;         (* wall thickness, finished *)
sbThkEstimate         = 0.375;         (* soundboard thickness (Padauk) *)
sbWood        = "Padauk";      (* one of Padauk, Cherry, Walnut, Maple, Cedar *)
shellWood     = "BlackWalnut"; (* shell material *)
guPortDiaEstimate     = 2.5;           (* gu port diameter, initial preset *)
domeRiseEstimate      = 0.0;           (* 0 for flat top, 0.75 for V2 Std *)

dingMidiEstimate      = 57;            (* A3 *)
nTonguesEstimate      = 11;
tongueWidthEstimate   = 1.25;
slitKerfEstimate      = 0.125;

(* Material library — cantilever K (imperial composite) and elastic
   moduli. Cross-references the workbook material library, rows 19-25. *)
materialsEstimate = <|
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
KSb = materialsEstimate[sbWood, "K"];
fDing = fFromMidi[dingMidiEstimate];

LDingFlat   = LFlat[KSb, sbThkEstimate, fDing];
LDingCurved = LCurved[KSb, sbThkEstimate, fDing];

(* Print *)
Print["Predicted tongue lengths for ", sbWood,
      " soundboard, ", sbThkEstimate, " in thick:"];
Print["  Ding (MIDI ", dingMidiEstimate, ", ", NumberForm[fDing, 5], " Hz):"];
Print["    flat   = ", NumberForm[LDingFlat, 4], " in"];
Print["    curved = ", NumberForm[LDingCurved, 4], " in (multiplier 1.025)"];

(* === 4. Helmholtz cavity (DOF 3) === *)

(* fH = (c / 2 pi) * sqrt(A / (V * Lneck)) *)

fHelmholtz[V_, A_, Lneck_] := (cAir / (2 Pi)) * Sqrt[A / (V * Lneck)];

(* Volume formulas per variant (in cubic inches) *)
volV1 = Pi * (shellODEstimate/2)^2 * shellHeightEstimate;                          (* cyl flat *)
volV2 = volV1 + (2/3)*Pi*(shellODEstimate/2)^2 * domeRiseEstimate;                 (* cyl + dome *)
volV3 = (2/3) * Pi * (shellODEstimate/2)^3;                                (* hemi flat *)
volV4 = volV3 + (2/3)*Pi*(shellODEstimate/2)^2 * domeRiseEstimate;                 (* hemi + dome *)

portArea = Pi * (guPortDiaEstimate/2)^2;
neckFlat   = sbThkEstimate;
neckDomed  = sbThkEstimate + domeRiseEstimate/2;

fHV1 = fHelmholtz[volV1, portArea, neckFlat];
fHV2 = fHelmholtz[volV2, portArea, neckDomed];
fHV3 = fHelmholtz[volV3, portArea, neckFlat];
fHV4 = fHelmholtz[volV4, portArea, neckDomed];

Print[];
Print["Helmholtz frequencies (current preset, gu port = ", guPortDiaEstimate, " in):"];
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
   Reduced model: tongue (m1Estimate, k1), shell wall (m2Estimate, k2), air (m3Estimate, k3)
   coupled by k12Estimate (rabbet stiffness) and k23Estimate (wall-air compliance).
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
m1Estimate = 0.020;            (* ~20 g effective tongue mass *)
k1 = (2 Pi fDing)^2 * m1Estimate;

(* Shell wall: ring-mode mass, large stiffness *)
m2Estimate = 0.5;              (* ~500 g effective wall mass *)
k2 = (2 Pi 800.)^2 * m2Estimate;   (* assumed ring mode ~800 Hz *)

(* Air cavity: lumped Helmholtz oscillator *)
m3Estimate = 0.01;             (* effective air-plug mass at port *)
k3 = (2 Pi fHV1)^2 * m3Estimate;

(* Coupling stiffnesses *)
k12Estimate = 0.10 * k1;       (* 10% of tongue stiffness through rabbet *)
k23Estimate = 0.05 * k3;       (* 5% wall-air through compliance *)

KMat = {
  {k1 + k12Estimate,   -k12Estimate,   0.0  },
  {-k12Estimate,       k2 + k12Estimate + k23Estimate, -k23Estimate},
  {0.0,        -k23Estimate,   k3 + k23Estimate}
};
MMat = DiagonalMatrix[{m1Estimate, m2Estimate, m3Estimate}];

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
    V = If[variant == "V1", Pi (shellODEstimate/2)^2 hh,
        If[variant == "V2", Pi (shellODEstimate/2)^2 hh + (2/3) Pi (shellODEstimate/2)^2 dr,
        If[variant == "V3", (2/3) Pi (shellODEstimate/2)^3,
                            (2/3) Pi (shellODEstimate/2)^3 + (2/3) Pi (shellODEstimate/2)^2 dr]]];
    Lneck = If[variant == "V1" || variant == "V3", sbThkEstimate, sbThkEstimate + dr/2];
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

scaleAKurdEstimate = {220.00, 329.63, 349.23, 392.00, 440.00, 493.88, 523.25,
              587.33, 659.26, 783.99, 880.00};

(* tonguePulse[freq] returns a short attack-decay envelope over a sine
   approximation of the tongue's first mode *)
tonguePulse[freq_, dur_:0.6] :=
  Sound[SoundNote["", dur, "FluteSection", SoundVolume -> 0.6, freq]];

(* Uncomment to play the predicted A Kurd scale: *)
(* AudioPlay[Sound[Table[tonguePulse[f], {f, scaleAKurdEstimate}]]] *)

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
