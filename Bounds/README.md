# Bounds — Exact Circuit Complexity of 1419

The quantitative core: proofs that the witness 1419 needs **exactly 9 gates** in the AND/OR/NOT basis, by exhaustive truth-table closure.

## Overview

`CircuitBounds9.lean` enumerates, for n = 4 input bits, all truth tables reachable with ≤ 8 gates (`TT1..TT8`) — 17,244 of them at the 8-gate level (`S8 = 17244`) — and proves the witness's truth table is not among them:

- **`eutheos_not_in_TT8 : ¬TT8.contains 1419`** — 1419 is not computable in ≤ 8 gates (`native_decide` over the closed enumeration)
- **`witness9_is_1419`** — 1419 *is* in the 9-gate set
- **`exact_complexity_9`** — together: circuit size exactly 9. This is the `CC = 9` clause of Property P.

`CircuitExact.lean` sharpens the exact-count picture; `ClayBridge5_10.lean` bridges the 5-bit to 10-bit levels and **supersedes** the flawed integer-division density lemma of `Archive/PneqNP.lean` (gap 13,555, strict `<` instead of `=`).

## Files

| File | Role |
|---|---|
| `Bounds.lean` | Index — build files individually, shared top-level definitions |
| `CircuitBounds9.lean` | **Headline** — TT1..TT8 truth-table closure, `exact_complexity_9` |
| `CircuitExact.lean` | Exact-count refinement |
| `ClayBridge5_10.lean` | 5→10 bit bridge, corrected density gap 13,555 |

## Results

- `exact_complexity_9` — circuit complexity of 1419 is exactly 9 gates — 0 sorry, `native_decide`
- `eutheos_not_in_TT8`, `witness9_is_1419`
- `ClayBridge5_10` gap: 13,555 (strict inequality)

## Status

All four files: 0 sorry, 0 axiom. `CircuitBounds9.lean` is the single most expensive computation in the repo (≈ 1m36s `native_decide` at build time).

## Consumers

`Final/ClayFinalClean.lean` (coll_9 clause), `Witness/ClayClaim_fixed.lean`, and — upstream — the barrier analysis in [p-vs-np](https://github.com/DavidFox998/p-vs-np) (a 9-gate exact-complexity witness is what the ConductorHash barrier framework was looking for).
