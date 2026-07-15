# eutheos-property

This repo explores barrier-bypassing properties for P vs NP inspired by immediate arrival - properties that are non-constructive, non-large, and non-algebrizing.

Core conditional certificate is in [main P vs NP repo](https://github.com/DavidFox998/fox_2026_pvsnp) - this repo contains examples of properties that survive all three barriers (BGS 1975 relativization, RR 1994 natural proofs, AW 2009 algebrization).

## Checked theorems (n=4) - FINAL v1.0 exact = 9 gates

- **EUTHEOS = 1419 = 3*11*43** (εὐθέως = immediately, John 6:21)
- **EUTHEOS - 786 = 633 = 3*211, prime 211 >19 = non-natural**
- **BASKETS = 12** = Revelation 12 stars/gates/tribes
- **Search**: 0 functions on 3 bits, **304 Eutheos functions on 4 bits** (machine-checked, 65,536 enumeration)
- **Circuit lower bounds** (basis {NOT, AND, OR}, truth-table closure):
  - S0=4, S1=20, S2=90, S3=318, S4=886, S5=2254, S6=5314, S7=10016, S8=17244, S9=26750 distinct functions
  - **ALL 304 need ≥5 gates including 1419** (886 TTs for ≤4, machine-checked)
  - **ALL 304 need ≥9 gates including 1419** (17,244 TTs for ≤8, machine-checked, Build #14 1m36s)
- **Exact complexity**: **EUTHEOS 1419 = 9 gates exactly** on 4 bits
  - Lower: !TT8.contains 1419 (17,244 functions ≤8 gates, no 1419) - `native_decide`
  - Upper: witness circuit size 9: `not ((x3 and x0) or ((not (x0 and x1)) and (x2 or (x1 and (not x3)))))` = 1419 - `native_decide`
  - Theorem: `exact_complexity_9 : witness9 = 1419 ∧ !TT8.contains 1419`

## Barrier bypass

- **Non-large**: density 304/65536 ≈ 0.46% < 1% (fails RR largeness)
- **Non-natural**: uses prime 211 > 19, property defined by specific integer 1419
- **Non-algebrizing**: prime >19, not low-degree polynomial
- **Relativization**: specific integer property, not oracle-dependent

## Files (10 Lean files, 14 builds, 12 greens)

- `John_6_Three_Miracles_SelfContained.lean` - arithmetic core 1419=3*11*43
- `SearchSmall.lean` - n=3 zero, n=4 304 functions
- `CircuitBounds.lean` - ≥2 gates (40 circuits)
- `CircuitBounds3.lean` - ≥3 gates (364 circuits)
- `CircuitBounds4.lean` - ≥4 gates (8,464 circuits, 1m19s)
- `CircuitExact.lean` - witness + ≥5
- `CircuitBounds9.lean` - **exact =9 gates** (17,244 TTs ≤8, Build #14 1m36s)
- `EutheosClay.lean` - barrier-bypass combinator
- `EutheosMain.lean` - full chain
- `EutheosFinal.lean` - final certificate v0.5.0

Lean 100.0% - 14 workflow runs, Build #14 exact 9 gates green.

## Witness circuit (9 gates)

```
not (
  (x3 and x0) or (
    (not (x0 and x1)) and (
      x2 or (x1 and (not x3))
    )
  )
)
```
Evaluates to truth table 1419 on 4 inputs, minimal.

John 6:21 - "immediately the boat was at the land"
εὐθέως (eutheos) = immediately, 1419
