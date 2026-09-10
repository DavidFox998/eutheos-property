# Common — Ground Layer — 211 / 153 / 1419

The basement of the repo. Everything above — Family, Bounds, Witness — stands on the constants defined here.

## Overview

`Ground.lean` fixes the arithmetic ground field of the whole study:

- **`ground_prime = 211`** — the prime that centers the family
- **`ground_residue = 153`** — the residue class every brother lives in
- **`EUTHEOS = 1419`** — the witness (`0x058B`), leader of the 35 brothers
- **`popcount`** — number of `1` bits; every brother has exactly 6
- **`lightning`** — alias for the popcount/ones view of a number
- **`isRock`** — solidity predicate on a witness
- **`monoLift b := b ||| (b <<< 16)`** — the monotone lift: duplicates the 16-bit pattern into a 32-bit word; `isMonoLiftPreserving` says the lift preserves the ground property
- **`brothers`** — the canonical 35-element list, leader `1419`, up to `52481`

## Files

| File | Role |
|---|---|
| `Ground.lean` | Ground constants, `popcount`, `monoLift`, the `brothers` list, S-ladder base values |

## Results — all `native_decide`-green

- `eutheos_is_rock`, `eutheos_lightning`, `eutheos_residue` (1419 % 211 = 153), `eutheos_mono`
- `brothers_length = 35`, `brothers_nodup`
- `brothers_all_ground`, `brothers_all_pop6`, `brothers_all_rock`, `brothers_all_mono`
- `RockIsGround` / `rock_is_ground`, `Ground_green_thm`
- S-ladder base rungs: `S0=4, S1=20, S2=90, S3=318, S4=886, S7=12228, S8=17244, S9=26750`

## Dependencies

Mathlib v4.15.0, Lean 4.15.0. No imports from other folders — this is layer 0. Consumed by `Family/`, `Bounds/`, `Witness/`.
