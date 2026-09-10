# Family — The 35 Brothers and the Irrational Scaffold

The heart of the repo. This is where one witness, 1419, becomes a 35-element family, and where the family is connected to the golden ratio, Fibonacci gaps, the H4 600-cell, and the irrational phase α₀ = 299 + π/10.

## Overview

Three layers live here:

1. **The brothers themselves.** `Brothers1419.lean` defines `brothers_35 : List Nat` — 35 numbers, all `≡ 153 mod 211`, all popcount 6, leader `1419 = 3×11×43` (the Morningstar, `leader_is_morningstar`). Certified: `all_brothers_residue_153`, `brothers_Nodup`, `brothers_card_35`, `all_brothers_popcount_6`. Extensions: `Brothers61.lean` (popcount-8 slice, 61 members), `Brothers188.lean` (20-bit extension, 188 members).
2. **Circuit placement.** The S-ladder sizes `S5=2374, S6=6110, S7=12228, S8=17244, S9=26750`; exactly 2 brothers sit in S6 (`brothers_in_S6 = [51848, 52481]`), 4 in S7, and **31 need ≥ 8 gates** (`brothers_not_in_S7`) — which is what forces the exact 9-gate count downstream in `Bounds/CircuitBounds9.lean`.
3. **The irrational structure.** Weyl gaps, Fibonacci chains, H4 throat, Dirichlet jitter:
   - `WeylGolden.lean` — `α_rat = 610/987` (ratio of Fibonacci numbers), Weyl gaps `[13, 21, 34]`
   - `FibonacciChain.lean` — chain 14→22→35→56→90→146 with gaps descending through consecutive Fibonacci triples; `fib_chain_35_is_Fib`
   - `H4Throat.lean` — `φ² = φ+1`, golden-ratio convergent error bounds (600-cell / H4 Coxeter symmetry)
   - `PrimesInPi.lean` / `PiIrrational.lean` / `IrrationalVsRational.lean` — α₀ = π/10 scaffold `alpha0_num = 3141592653 / alpha0_den = 10^10` (error < 6·10⁻¹¹), `alpha0_irrational`
   - `DirichletGolden.lean` — `Q5 = 226`, `bound_Q5 = 82829 = 733·113 = 733·(Q5/2)`, Dirichlet window min gap 13
   - `DirichletJitterTime.lean` — jitter no-collision (`all_jitters_Nodup_1419`), EMI reduction > 30 dB, `MAX_COMPUTE_MS = 228`, `MAX_MORNINGSTAR_MS = 1419`
   - `ExceptionalPrimes.lean` — `exceptional_4 = [2,3,19,191]` (S₄), `desert_product = 21774`, `wormhole_product = 46189`, mod-191 injectivity
   - `GapHamming.lean` / `TwinPrimes.lean` — distinct residues mod 191 and mod 36863 = 191×193, pairwise Hamming distance ≥ 2 (`hamming_ge_2`), twin-prime avoidance
   - `Eutheos2113.lean` / `AIZ.lean` / `HilbertRoute.lean` / `AlphaBridge.lean` / `H4Tower.lean` / `EutheosAsymptotic.lean` — 2113 ghost (2113 mod 35 = 13), self-symmetry `W1·W2 = 46189 ∧ W3 = 36863`, Hilbert-space route picture, asymptotic density

Every file carries a sync-lock header: the canonical source is **[eutheos-property/Family](https://github.com/DavidFox998/eutheos-property)** (this folder); **[brothers-desert-proof/Family](https://github.com/DavidFox998/brothers-desert-proof)** inlines these files for Route D.

## Files

| File | Role |
|---|---|
| `Family.lean` | Index — build files individually, shared top-level definitions |
| `Brothers1419.lean` | **The answer** — `brothers_35`, residue/popcount/cardinality/density certificates, conductor constants (p5 = 3993746143633, N = 143, φ = 120, g = 13, h = 10) |
| `Brothers61.lean` | Popcount-8 slice: `brothers_of_153_pop8.card = 61` |
| `Brothers188.lean` | 20-bit extension: 188 brothers ≤ 951552 |
| `BrothersAnalysis.lean` | 3 prime brothers `[5639, 9859, 44041]`, `leader_is_morningstar : 3*11*43 = 1419` |
| `ClayBrothersClean.lean` | Union bounds: collision rate 9/4194304; 31 brothers ≥ 8 gates; `L_GapMCSP_35_beats_threshold : 64*35 = 2240 > 33` |
| `WeylGolden.lean` | α_rat = 610/987, Weyl phase and gaps for N=35 |
| `FibonacciChain.lean` | Fibonacci gap chain 14→22→35→56→90→146 |
| `H4Throat.lean` | Golden ratio, 600-cell throat, convergent error bounds |
| `H4Tower.lean` | H4 tower levels 35 → 56 |
| `ClayFamilyAlpha0.lean` | Family vs α₀ window; S14 measured |
| `Eutheos2113.lean` | The 2113 ghost — gate arithmetic 2113 mod 35 = 13 |
| `EutheosAsymptotic.lean` | Asymptotic density of the property |
| `DirichletGolden.lean` | Q5 = 226, bound = 82829, Dirichlet window |
| `DirichletJitterTime.lean` | Jitter no-collision, EMI reduction, compute-time budget |
| `ExceptionalPrimes.lean` | S₄ = [2,3,19,191], desert/wormhole products, mod coverage |
| `GapHamming.lean` | Min gap 191/36863, pairwise Hamming ≥ 2 |
| `TwinPrimes.lean` | Twin-prime divisibility avoidance, mod-191 injectivity |
| `PrimesInPi.lean` | α₀ = π/10 rational scaffold, `desert_192_1000_empty` |
| `PiIrrational.lean` | `pi_irrational_certified := irrational_pi` |
| `IrrationalVsRational.lean` | Rational scaffold vs real α₀ — both give the same desert |
| `HilbertRoute.lean` | Complex gate `Complex.exp (I * θ)`, unitary route |
| `AlphaBridge.lean` | `alpha0_rat_close : |π/10 − α_rat| < 6e-11`, self-symmetry W1·W2/W3 |
| `AIZ.lean` | Auxiliary invariant slice |
| `python/` | Generators and counters behind the measured constants (see `python/README.md`) |

## Results — headline

- `brothers_card_35`, `all_brothers_residue_153`, `all_brothers_popcount_6`, `brothers_Nodup` — all `native_decide`
- `density_35_lt_one_fifth` (35/211 < 1/5), `density_35_in_slice` (35/C(16,6) = 35/8008 < 0.01)
- `leader_is_morningstar : 3 * 11 * 43 = 1419`
- `brothers_not_in_S7` (31 brothers need ≥ 8 gates)
- `hamming_ge_2`, `mod_191_Nodup`, `desert_192_1000_empty`
- `alpha0_irrational`, `fib_chain_35_is_Fib`, `self_symmetry : W1*W2 = 46189 ∧ W3 = 36863`

## Status

Family core (`Brothers1419`, `Brothers61`, `Brothers188`, `BrothersAnalysis`, `ClayBrothersClean`, `GapHamming`, `TwinPrimes`, `ExceptionalPrimes`, `PrimesInPi`, `WeylGolden`, `FibonacciChain`, `H4Throat`, `H4Tower`): 0 sorry, 0 axiom, measured constants `native_decide`-green. Research files (`ClayFamilyAlpha0`, `EutheosAsymptotic`) carry documented measurement notes.

## Downstream

These 35 numbers are the discrete self-symmetry lattice of **Route D** in [brothers-desert-proof](https://github.com/DavidFox998/brothers-desert-proof) — distinct residues mod 191 and 36863, empty desert 192..1000, functional duality s ↔ 1−s.
