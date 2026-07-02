// Wood Shell Tongue Drum parametric master — V1 Cylinder + Flat Top,
// Standard 16" envelope: shell + soundboard + tongue LAYOUT reference marks.
//
// Authority: pending_measurement. NOT fabrication authority until reviewed
// against a measured prototype (see visual-output-register.csv CAD-001 and
// cad/mcp-session-log.md). This is a planning envelope: cad/README.md
// explains CAD is deliberately deferred until Phase 1 measurements are
// folded back into the workbook.
//
// SCOPE BOUNDARY (per instrument-maker skill "hand-refined, tuning-sensitive
// regions" rule): this models the shell/soundboard ENVELOPE and the tongue
// POSITION/LENGTH layout (thin reference marks on the soundboard) from the
// design.md position grid. It does NOT model the actual slit-routing cut
// geometry (kerf path, tongue-base relief pocket, U-shaped slot) — that is
// explicitly out of scope until CNC pocketing geometry is reviewed
// (drawing-brief.md Sheet 03, cnc/README.md). The gu port is a documented
// parameter only; design.md does not give a (r, theta) position for it in
// the schedule, so it is NOT placed geometrically here (would be an invented
// dimension) — see gu_port_dia_in comment below.
//
// Dimension sources (do not edit values without updating the source record):
//   - shell OD/height/wall thickness, soundboard thickness/diameter, gu port
//     diameter: design.md §4 "Recommended first prototype" build table
//   - tongue count/lengths, radial position grid (r, theta): design.md §4
//     tongue length schedule + drawing-brief.md Sheet 03 position grid
//     ("derived estimates for the layout drawing" per drawing-brief.md —
//     SolidWorks parametric placement against shell radius will refine them)
//   - tongue width, slit kerf width: design.md §4 build table
//
// Units: inches (packet's native shop unit for this build table).

/* [Shell] */
shell_od_in         = 16.00;  // design.md §4 "Shell OD"
shell_height_in     = 8.00;   // design.md §4 "Shell height"
wall_thickness_in   = 0.625;  // design.md §4 "Wall thickness" (finished, after lathe truing)
floor_thickness_in  = wall_thickness_in; // ASSUMPTION: bottom floor equals wall thickness; not
                                          // separately specified in design.md (stave + lathe-turned
                                          // closed bowl construction — "16 staves + 1 disc = 17 pieces").

/* [Soundboard] */
soundboard_dia_in   = 16.00;  // design.md §4 "Disc diameter" (= shell OD)
soundboard_thk_in   = 0.375;  // design.md §4 "Soundboard thk"
rabbet_depth_in     = 0.25;   // design.md §4 "rabbet ¼in deep"
rabbet_width_in     = 0.375;  // design.md §4 "× ⅜in wide"

/* [Gu port — parameter only, NOT placed: no (r,theta) in design table] */
gu_port_dia_in      = 2.5;    // design.md §4 "Gu port Ø" — initial; final size set by Helmholtz tuning in shop

/* [Tongue field — A Kurd, 11 tongues, zigzag-ascending] */
tongue_width_in     = 1.25;   // design.md §4 "Tongue width"

/* [Render quality] */
$fn = 96;

// ---------------------------------------------------------------------------
// Tongue position/length schedule — drawing-brief.md Sheet 03 position grid
// [id, note, r_in, theta_deg, length_in]
// theta measured from the ding centerline per drawing-brief.md; ding itself
// has no theta (r=0, centered) so it is handled as a special case below.
// ---------------------------------------------------------------------------

tongue_schedule = [
    ["Ding", "A3", 0.0,   0,   6.454],
    ["1",    "E4", 4.0,  60,   5.273],
    ["2",    "F4", 4.0, -60,   5.123],
    ["3",    "G4", 5.5,  90,   4.835],
    ["4",    "A4", 5.5, -90,   4.564],
    ["5",    "B4", 6.5, 120,   4.308],
    ["6",    "C5", 6.5,-120,   4.185],
    ["7",    "D5", 6.0,  30,   3.950],
    ["8",    "E5", 6.0, -30,   3.728],
    ["9",    "G5", 6.5, 150,   3.419],
    ["10",   "A5", 6.5,-150,   3.227],
];

// ---------------------------------------------------------------------------
// Derived geometry
// ---------------------------------------------------------------------------

shell_or_in   = shell_od_in / 2;
shell_ir_in   = shell_or_in - wall_thickness_in;
soundboard_r_in = soundboard_dia_in / 2;

// ---------------------------------------------------------------------------
// Shell — hollow stave cylinder, closed floor (lathe-turned bowl form)
// ---------------------------------------------------------------------------

module shell() {
    difference() {
        cylinder(h = shell_height_in, r = shell_or_in);
        translate([0, 0, floor_thickness_in])
            cylinder(h = shell_height_in, r = shell_ir_in); // open cavity above the floor
    }
}

// ---------------------------------------------------------------------------
// Soundboard — flat disc, rabbet-seated on the shell rim
// ---------------------------------------------------------------------------

module soundboard() {
    translate([0, 0, shell_height_in - rabbet_depth_in])
        cylinder(h = soundboard_thk_in, r = soundboard_r_in);
}

// ---------------------------------------------------------------------------
// Tongue layout reference marks — position + length ONLY, not cut geometry.
// Rendered as thin raised bars on top of the soundboard so the layout is
// visually distinct from the (unmodeled) actual routed slit.
// ---------------------------------------------------------------------------

marker_thickness_in = 0.03; // visual reference only, not a real dimension

module tongue_marker(r_in, theta_deg, length_in) {
    // Marker's near end sits at radius r_in from center, extending outward
    // along the radial (theta) direction by length_in.
    rotate([0, 0, theta_deg])
        translate([r_in, -tongue_width_in / 2, shell_height_in - rabbet_depth_in + soundboard_thk_in])
            cube([length_in, tongue_width_in, marker_thickness_in]);
}

module tongue_field() {
    for (t = tongue_schedule) {
        note = t[0];
        r_in = t[2];
        theta_deg = t[3];
        length_in = t[4];
        if (note == "Ding") {
            // Ding is centered at the soundboard origin; drawn along theta=0.
            translate([-length_in / 2, -tongue_width_in / 2, shell_height_in - rabbet_depth_in + soundboard_thk_in])
                cube([length_in, tongue_width_in, marker_thickness_in]);
        } else {
            tongue_marker(r_in, theta_deg, length_in);
        }
    }
}

// ---------------------------------------------------------------------------
// Top-level assembly
// ---------------------------------------------------------------------------

module wood_shell_tongue_drum_master() {
    shell();
    soundboard();
    tongue_field();
}

wood_shell_tongue_drum_master();
