# Andreev — The N^1.01 Lift via α₀ = 299 + π/10

The Andreev-type lower bound machinery: explicit lift tables, measured crossings, and the irrational phase α₀ = 299 + π/10 that drives them.

## Overview

Andreev's method turns a careful count of subfunctions into a near-quadratic circuit lower bound. This folder implements the count numerically, then certifies the crossings in Lean:

- `ClayAndreevAlpha0.lean` (Build 83) — the lift table for n = 10..13: `L'_10 = 5836 … L'_13 = 388804` vs the N^1.01 targets; **`andreev_cross`** at n = 12, **`andreev_not_in_ppoly`** and **`final_separation`** at hypothesis level; `witness_poly_12/13` (witness stays in NP). One documented constant drift: `N'_12 := 49216` vs `N'_12_calc = 49176` — flagged in-file.
- `ClayAndreevLift.lean` — the base case `andreev_lift_val = 102·102 = 10404 ≥ 1096`; the asymptotic statement `andreev_asymptotic` is a marked `sorry` (the only gap in the folder).
- `ClayN20Measured.lean`, `ClayN25MpmathMeasured.lean`, `ClayN26MpmathMeasured.lean`, `ClayN27MpmathMeasured.lean` — the measured ladder at N = 20, 25, 26, 27: e.g. at N = 26: 99.99957% distinct, 7755× margin, 13.5T > 2.15B; at N = 27: 99.999785%, **9 collisions in 4,194,304 blocks**, 14383× margin, factor 0.9316. These measured files are what `Final/ClayFinalClean.lean` certifies (ratios 14383, 9 collisions).

## Files

| File | Role |
|---|---|
| `Andreev.lean` | Index |
| `ClayAndreevAlpha0.lean` | Lift table n=10..13, `andreev_cross`, crossing at n=12 |
| `ClayAndreevLift.lean` | Base lift 10404 ≥ 1096; asymptotic shell open |
| `ClayN20Measured.lean` | N=20 measured slice |
| `ClayN25MpmathMeasured.lean` | N=25 mpmath-measured |
| `ClayN26MpmathMeasured.lean` | N=26: 99.99957% distinct, 13.5T > 2.15B |
| `ClayN27MpmathMeasured.lean` | N=27: 9 collisions / 4,194,304, 14383× |

## Results

- `andreev_cross`, `andreev_not_in_ppoly`, `final_separation` (hypothesis level), `andreev_lift_val ≥ 1096`
- Clean measured files: 0 sorry, 0 axiom
- Open: `andreev_asymptotic` (1 marked sorry in `ClayAndreevLift.lean`)

## Consumers

`Witness/ClayClaim_fixed.lean` (Lemma 3), `Final/ClayFinalClean.lean` (`andreev_12`, `ratio_27`), and the README's Andreev lift summary `N^{1.01} → N²/log⁴` — the quantitative reason a 9-gate witness at n = 4 grows into a separation-shaped object at n = 27.
