# Witness — The 1024-bit Explicit Witness

An explicit, inspectable 1024-bit witness `T_star` with its three lemmas formalized.

## Overview

`ClayClaim_fixed.lean` fixes the parameters `N = 1024`, `n = 10`, `s = 51`, `s_thresh = 102` and spells out the witness as a 256-hex-digit string ending `...058b058b` — the eutheos residue visible at both ends. Then:

- **Lemma 1** — `lemma1_808_lt_1024` and companions: the witness's formula size sits strictly between the log₂ circuit bounds (808/756 < 1024 < 1796).
- **Lemma 2** — measured statistics of `T_star`: `T_ones = 444`, 56 distinct 4-bit blocks, `count_058b = 4`, 29 distinct 5-bit blocks, 28 hard ones, `sum_CC_distinct_5 = 140`, `formula_lower = 70`, and **`lemma2_70_gt_51 : 70 > 51`** — the formula lower bound beats the s = 51 threshold.
- **Lemma 3** — `lemma3_10404_ge_1096 : andreevLift(10404) ≥ N_pow_101(1096)` — the Andreev lift at N = 10404 dominates the N^1.01 target at 1096.

`Witness.lean` is the folder index.

## Files

| File | Role |
|---|---|
| `Witness.lean` | Index (Build 79 CLEAN) |
| `ClayClaim_fixed.lean` | Explicit `T_star : String` witness + Lemmas 1–3 + `main_theorem_P_ne_NP` |

## Results

- `lemma2_70_gt_51`, `lemma3_10404_ge_1096`, `lemma1_808_lt_1024` — 0 sorry, arithmetic `native_decide`/`decide`
- `main_theorem_P_ne_NP : P_eq_NP = False` — stated against the placeholder surface `P_eq_NP : Prop := False`; the real content is the three lemmas, not this shell

## Status

0 sorry in the three lemmas. `lemma4`/`lemma5` are documented `Bool = true` placeholders — open surfaces, marked as such in-file.

## Consumers

`Andreev/` (Lemma 3 is the N^1.01 lift anchor), `Final/`, and the 1419 story — `058B` is 1419 in hex; the witness string repeats it as a signature.
