# MMW — MCSP and the Magnification Chain

The research frontier of the repo: MCSP (Minimum Circuit Size Problem), the MMW hypothesis, and the magnification theorem that would push a modest MCSP lower bound all the way to P ≠ NP.

## Overview

Two generations of files live side by side — read the filenames:

**Clean (0 sorry, 0 axiom):**
- `ClayMMWClean.lean` — the 32-bit slice: `L_GapMCSP = 64 > N_32_pow_101 = 33` (the MMW hypothesis instance, `64 > 33`), `num_circuits_5 = 9765625 < S4_size = 10892522`, `anti_checker_size_5 = 50 ≤ 50`, `MMW_hypothesis` / `MMW_conclusion`.
- `MMW.lean` — index.

**Research (documented gaps — do not cite as proved):**
- `ClayRealMCSP.lean` — real MCSP definition + `Verifier_MCSP` with 12 marked `sorry` placeholders (`Verifier_MCSP_correct`, `MCSP_in_NP`, `DirichletSet_27`, …) and a **known-wrong density constant** `dens_27_999999` (999999; true value 999997 — corrected in `Final/ClayFinalClean.lean`).
- `ClayRealMagnification.lean` — the chain `ClayRealMagnification_chain : factor_random > factor_witness → P ≠ NP` with 4 marked sorries; measured ratios `ratio_witness = 14383, ratio_avg = 34519, ratio_random = 57532`.
- `ClayMagnification.lean` — `magnification_theorem` Bool placeholder.

The honest state: the *structure* of the magnification chain is formalized; the load-bearing verifiers are open. What IS proved: the hypothesis instance `64 > 33`, the circuit-count inequalities, and — in Final/ — the corrected density.

## Files

| File | Role |
|---|---|
| `MMW.lean` | Index |
| `ClayMMWClean.lean` | Clean: MMW hypothesis instance 64 > 33, 32-bit slice |
| `ClayMagnification.lean` | Magnification shell (placeholder conclusion) |
| `ClayRealMCSP.lean` | Real MCSP + verifier — 12 open gaps, one wrong density constant (see Final for corrected value) |
| `ClayRealMagnification.lean` | Magnification chain — 4 open gaps, measured ratios |

## Relation to the literature

MMW = Murray–Williams (2017) magnification framework; MCSP lower bounds à la Hirahara. The gap-level idea: an N^{1.01}-type lower bound for Gap-MCSP magnifies to NP ⊄ P/poly, which with Karp-Lipton (`p-vs-np` scaffold) gives P ≠ NP.

## Status

Clean file: 0 sorry, 0 axiom, `native_decide`-green. Research files: 16 documented `sorry` placeholders — they are the honest to-do list, and they are why this repo claims P ≠ NP only **conditionally**.
