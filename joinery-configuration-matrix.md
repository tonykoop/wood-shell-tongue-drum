# Joinery Configuration Matrix

Practical joinery comparison for tongue-drum shells and shell-to-top interfaces. This is a focused planning document for `tonykoop/instrument-maker#118`, using the wood-shell tongue drum family as the most relevant testbed.

## Scope

Tongue drums ask two different joinery questions:

1. How should the shell body itself be built?
2. How should the vibrating top or soundboard be captured without killing the acoustic seal or making service impossible?

The table below compares joinery types against those two jobs, not just generic woodworking aesthetics.

## Matrix

| Joint | Best fit in tongue-drum work | Tooling level | Strength | Airtight-seal potential | Serviceability | Curve / shell compatibility | Recommended use in this family | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Butt joint | Fast rectangular box shells, temporary prototypes, internal-block builds | low | low by itself | low unless backed up | medium | poor for curved shells | only for quick box-drone or sacrificial test bodies | Too dependent on fasteners or internal cleats to be a public-ready main shell strategy. |
| Rabbeted butt joint | Box shells, end-cap capture, shell-to-top seat | low to medium | medium | high when fit is controlled | medium | good for top capture, weak for curved wall segmentation | **primary top-capture strategy** for `wood-shell-tongue-drum` | Best balance of manufacturability and airtight seal for the soundboard interface. |
| Finger / box joint | Rectangular wooden tongue drums, laser/CNC flat-pack bodies | medium | high | medium | low | poor for round shells | best for `tongue-drum`, not for the round-body shell here | Excellent for orthogonal box bodies; awkward and visually noisy on stave cylinders. |
| Through dovetail | Premium rectangular shells, heirloom box builds | high | high | medium | low | poor for curved shells | showcase-only option for rectilinear tongue-drum variants | Strong and beautiful, but slower and less parameter-friendly than finger joints for repeated packet builds. |
| Sliding dovetail | Captured divider, rail, or removable ring in a straight-walled body | high | high | medium | medium | poor to medium | niche use for internal baffle or rail, not main shell closure | More relevant if a tongue drum gains an internal removable shelf or rail system. |
| Splined miter | Premium polygon shells, decorative rectangular shells, clean external corners | medium to high | medium to high | medium | low | medium for segmented polygon shells | secondary option for segmented shell experiments | Better visual polish than finger joints, but less forgiving than staves for a first round-body prototype. |
| Dowel / Domino / floating-tenon reinforced butt joint | Panel shells, ring laminations, hidden reinforcement in box or polygon bodies | medium | medium to high | medium | low | medium | useful reinforcement path for polygonal or faceted experimental shells | Good when you want cleaner exterior lines than finger joints but easier setup than dovetails. |
| Tongue-and-groove panel capture | Capturing a backer, removable panel, or floating non-vibrating panel | medium | medium | medium to high | high if designed removable | medium | useful for service panels, not the vibrating top in this family | Better for removable access or non-primary panels than for a tuned soundboard. |

## Read by shell type

| Shell type | Best joinery candidates | Why |
| --- | --- | --- |
| Rectangular wood tongue drum | finger / box joint, rabbeted butt, splined miter | Orthogonal panels reward repeatable edge joinery and easy clamping. |
| Stave cylinder | edge-beveled stave glue-up plus rabbeted top capture | The wall is really a many-sided coopered shell; the top joint is the separate load-bearing question. |
| Segmented bowl / hemisphere | ring stack or segmented shell plus rabbeted top capture | Bowl geometry wants ring/segment logic; the top still benefits from an airtight captured seat. |
| Experimental polygon shell | splined miter or floating-tenon reinforced butt | Clean external faces with moderate repeatability, if the maker wants a more faceted look. |

## Recommendation for `wood-shell-tongue-drum`

For the current family, keep the shell and top decisions separate:

- Shell body: stave cylinder for V1 and V2, segmented bowl or ring-stack for V3 and V4.
- Vibrating top capture: rabbeted butt-style seat at the rim remains the first-prototype default.

That split is why the packet keeps returning to the rabbet joint. The top joint has to do more than hold parts together; it has to preserve cavity seal, locate the soundboard repeatably, and survive tuning vibrations without adding a complicated service burden.

## Practical shortlist

If Tony wants one joinery path per tongue-drum family for first builds:

- `tongue-drum` rectangular family: finger / box joint
- `wood-shell-tongue-drum` round-body family: stave or segmented shell plus rabbeted top capture
- premium later experiment: splined-miter polygon shell or hidden floating-tenon shell
