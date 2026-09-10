# Archive — Superseded Drafts

Historical drafts, kept for provenance. **Nothing in this folder is part of the certified claim** — the Clean set lives in `Bounds/`, `Final/`, `CookLevin/`, `Ppoly/`, `MMW/ClayMMWClean.lean`, and `Witness/`.

## Overview

~45 files tracing the repo's evolution: early circuit bounds (`CircuitBounds`, `CircuitBounds3/4`), first Clay drafts (`ClayMain`, `ClayFinal`, `ClayFinalFormal`), the Real chain drafts (`ClayReal*`), and the original `PneqNP.lean` whose integer-division density lemma (`density_5 … = 1`) was **superseded** by `Bounds/ClayBridge5_10.lean` (strict `<`, gap 13,555).

Known artifacts preserved on purpose:

- `PneqNP.lean` — flawed density lemma (integer division); see `Bounds/ClayBridge5_10.lean` for the correction
- `ClayRealNoBool.lean` — carries the same 999999 density constant that was corrected to 999997 in `Final/ClayFinalClean.lean`
- `ClayBeyond.lean`, `ClayNechiporuk.lean`, `ClayKarpLipton.lean` — exploratory sketches
- `ClayFinalFormal (1).lean` — duplicate-named draft

## Rule of the house

If a result survives, it has a home outside this folder. If you find a claim here that contradicts `Final/`, the Archive copy is the wrong one.
