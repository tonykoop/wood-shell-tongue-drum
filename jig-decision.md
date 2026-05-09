# Jig Decision

## Decision

Use a staged jig package that matches the recommended first prototype:

1. A stave-bevel reference jig for the 16-stave cylinder shell.
2. A shell glue-up and lathe-truing support path that keeps the rim round and measurable.
3. A laser-cut tongue-layout overlay plus spoilboard hold-down template for the Padauk soundboard.
4. A gu-port logging card and optional three-pin dome flip jig for later V2/V4 work.

## Why

The first public-safe upgrade pass needs reviewable setup logic without pretending that finished CAM or calibrated CAD already exist. The jig set above keeps the V1 Standard build low-risk while still feeding measurements forward into the later dome and hemisphere variants.

## Required Fixtures

- Stave bevel jig referenced from the stave centerline so both bevels stay symmetric.
- MDF cylinder caul or equivalent glue-up support that keeps the shell round within the tolerance band in `validation.csv`.
- Soundboard spoilboard and hold-down clearance template that avoid tape or vacuum under moving tongues.
- Temporary measurement support that leaves the gu port and underside accessible during puff-test and tuning.

## Deferred Fixtures

- Three-pin dome flip jig becomes mandatory only after the V1 shell and flat-top tuning loop are measured.
- Hemisphere ring-stack centering fixtures are useful for V3/V4, but they are not the first blocker for close-ready packet quality.

## Rejected Options

- Publishing build-ready G-code before the first Padauk test cut and kerf check.
- Freehand port drilling without the measurement log card.
- Treating the dome multiplier as fixed before a single dome tongue is back-solved from measured pitch.
