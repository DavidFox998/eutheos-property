# Final — The Clean Conjunctions

Where the whole repo is folded into two single-theorem certificates: a 9-way and a 10-way conjunction of every green clause.

## Overview

- `ClayFinalClean.lean` — **`Final_green_thm`**, a 9-way conjunction, one clause per load-bearing result:
  - `blocks_no_dup` — 32 Weyl blocks distinct
  - `andreev_12 : Lp_12(101376) > Np101_12(62000)` — Andreev lift crossing at n = 12
  - `ratio_27 : Lp_27 / Np_27 = 14383` — the witness magnification ratio
  - `L_GapMCSP(64) > 33` — MMW hypothesis instance
  - `num_circuits_lt_S4` — circuit count below the S4 size
  - `coll_9 : 4194304 − 4194295 = 9` — collision count
  - `dens_999997` — the **corrected** density (999997, superseding the 999999 bug in `MMW/` and `Archive/`)
  - `bound = 82829` — the Dirichlet window bound (= 733·113 = 733·(Q5/2))
  - `Q6 = 165689 = a6·Q5 + 31` with `a6 = 733, Q5 = 226`
- `ClayFinalUnifiedClean.lean` — the 10-way version: adds the Tseitin clause `tableau_bound 32 1 ≤ 32^4` from `CookLevin/`.

`Final.lean` is the folder index.

## Files

| File | Role |
|---|---|
| `Final.lean` | Index (Build 93) |
| `ClayFinalClean.lean` | 9-way `Final_green_thm` — the certified summary |
| `ClayFinalUnifiedClean.lean` | 10-way unified certificate |

## Results

Both files: 0 sorry, 0 axiom, every clause `native_decide`/`decide`-green. If you verify one file in this repo, verify `ClayFinalUnifiedClean.lean`.

## Consumers

`CLAY_FINAL_PROOF.md` / `CLAY_SUBMISSION_FINAL.md` at repo root reference these clauses. Upstream: the clauses are exactly the data the [p-vs-np](https://github.com/DavidFox998/p-vs-np) barrier framework consumes; downstream: the family clauses are re-certified in [brothers-desert-proof](https://github.com/DavidFox998/brothers-desert-proof).
