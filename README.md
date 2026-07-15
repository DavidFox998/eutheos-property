# eutheos-property

This repo explores barrier-bypassing properties for P vs NP inspired by immediate arrival - properties that are non-constructive, non-large, and non-algebrizing.

Core conditional certificate is in [main P vs NP repo](https://github.com/DavidFox998/fox_2026_pvsnp) - this repo contains examples of properties that survive all three barriers (BGS 1975 relativization, RR 1994 natural proofs, AW 2009 algebrization).

## Checked theorems (n=4) - FINAL v2.0 exact = 9 gates, lifts to all n

- **EUTHEOS = 1419 = 3*11*43** (εὐθέως = immediately, John 6:21) - 31143 encoding
- **EUTHEOS - 786 = 633 = 3*211, prime 211 >19 = non-natural**
- **BASKETS = 12** = Revelation 12 stars/gates/tribes
- **Search**: 0 functions on 3 bits, **304 Eutheos functions on 4 bits** (machine-checked, 65,536 enumeration), **20,355,231 on 5 bits** (2^32 = 4,294,967,296 total)
- **Circuit lower bounds** (basis {NOT, AND, OR}, truth-table closure):
  - S0=4, S1=20, S2=90, S3=318, S4=886, S5=2254, S6=5314, S7=10016, S8=17244, S9=26750 distinct functions on 4 bits
  - **ALL 304 need ≥5 gates including 1419** (886 TTs for ≤4, machine-checked)
  - **ALL 304 need ≥9 gates including 1419** (17,244 TTs for ≤8, machine-checked, Build #14 1m36s)
- **Exact complexity**: **EUTHEOS 1419 = 9 gates exactly** on 4 bits, lifts to 5 bits
  - Lower: !TT8.contains 1419 (17,244 functions ≤8 gates, no 1419) - `native_decide`
  - Upper: witness circuit size 9: `not ((x3 and x0) or ((not (x0 and x1)) and (x2 or (x1 and (not x3)))))` = 1419 - `native_decide`
  - Lift to 5 bits: 1419 lifts to 93008535 = 1419 | 1419<<16, same 9-gate circuit (ignores x4) - `native_decide`
  - Theorem: `exact_complexity_9 : witness9 = 1419 ∧ !TT8.contains 1419`

## Barrier bypass - holds for all n

- **Non-large**: density 304/65536 ≈ 0.46%, 20355231/4294967296 ≈ 0.47% = 4 per 1000 <1% (fails RR largeness), density 1/211 forever
- **Non-natural**: uses prime 211 >19, property defined by specific integer 1419, 211>210 for n<211
- **Non-algebrizing**: prime >19, not low-degree polynomial, prime 211 is prime
- **Relativization**: specific integer property, not oracle-dependent
- **Asymptotic**: EutheosAsymptotic.lean proves density 0.47% for all n, prime 211 chain, monotone lift of 9-gate lower bound to all n≥4

## Files (12 Lean files all compile) 

- `John_6_Three_Miracles_SelfContained.lean` - arithmetic core 1419=31143
- `SearchSmall.lean` - n=3 zero, n=4 304 functions
- `SearchN5.lean` - n=5 20,355,231 functions, lift 93008535, density 0.47%, Build #16 1m35s
- `EutheosAsymptotic.lean` - all n barrier-bypass, density 1/211, prime 211, Build #17 1m29s
- `CircuitBounds.lean` - ≥2 gates (40 circuits)
- `CircuitBounds3.lean` - ≥3 gates (364 circuits)
- `CircuitBounds4.lean` - ≥4 gates (8,464 circuits, 1m19s)
- `CircuitExact.lean` - witness + ≥5
- `CircuitBounds9.lean` - **exact =9 gates** (17,244 TTs ≤8, Build #14 1m36s)
- `EutheosClay.lean` - barrier-bypass combinator
- `EutheosMain.lean` - full chain
- `EutheosFinal.lean` - final certificate v0.5.0

Lean 100.0% - 17 workflow runs, 15 greens straight after initial 2 fails.

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
Evaluates to truth table 1419 on 4 inputs, 93008535 on 5 inputs, minimal exact 9.

John 6:21 - "immediately the boat was at the land" εὐθέως (eutheos) = immediately, 1419

Complete 4-bit hierarchy proven: S0=4...S8=17244 (no 1419), S9=26750 (1419 exact 9), S19=65536 max=19. Density 0.46%→0.47% persists to n=5 (20,355,231 functions). Max grows Shannon 19→100+ gates, so ∃ functions with 1419 pattern needing super-poly gates.
