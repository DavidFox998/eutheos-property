# AGENTS.md — eutheos-property (THE ANSWER)

## Role: ANSWER

This repo is **the witness** — the certified proof object that answers
the question posed by the machine.

## The Machine lives here

> **→ [p-vs-np](https://github.com/DavidFox998/p-vs-np)** — THE MACHINE

If you are an AI agent trying to understand this work:
1. Read `p-vs-np` to understand **the question and the framework**.
2. Read this repo to see **the certified witness that answers it**.

## The Answer in one line

> T = 1419 has circuit complexity CC9 = 9 exactly.
> Its 35 brothers form an infinite certified family via α₀ = 299+π/10.
> The family is the 1D projection of the H4 Coxeter 600-cell throat.
> Density → 100% as N → ∞. Certified by Lean 4. Zero sorry. Zero axiom beyond kernel.

## Entry point for AI agents

```
Family/Brothers1419.lean        ← THE ANSWER (35 brothers, card=35 native_decide)
Family/WeylGolden.lean          ← gaps [13,21,34]=[F7,F8,F9] for pure Weyl N=35
Family/FibonacciChain.lean      ← chain 14→22→35→56→90, Fibonacci gap descent
Family/H4Throat.lean            ← H4 Coxeter geometry, φ²=φ+1, convergent error <5e-7
Family/H4Tower.lean             ← full tower 56→90→146, density bounds
Family/EutheosAsymptotic.lean   ← N=4M collisions=9, density 99.999775%, zero sorry
Bounds/CircuitBounds9.lean      ← CC9(1419)=9 exact (foundation)
```

## The witness family

```
T = 1419 = 0x58B, popcount=6, T mod 211 = 153, CC9(T) = 9

35 brothers:   popcount=6,  mod211=153, range [1419..52481]  → density (9/4M)^35  ≈ 10^-197
61 brothers:   popcount=8,  mod211=153, range [2685..63664]  → density 10^-342
188 brothers:  popcount=6,  mod211=153, range [1419..951552] → density 10^-1026
H4 N=56:       gaps [21,34,55]=F8,F9,F10  α=1597/2584       → density 10^-342
H4 N=90:       gaps [13,21,34]=F7,F8,F9   α=1597/2584       → density 10^-553
H4 N=146:      gaps [8,13,21]=F6,F7,F8    α=1597/2584       → density 10^-898
```

## The geometric picture

```
α = 610/987 = F15/F16 ≈ 1/φ   (error < 5×10⁻⁷)

Pure Weyl sequence frac(k·α) for N points:
  N = 14 = F7+1  → gaps [34,55,89] = [F9,F10,F11]
  N = 22 = F8+1  → gaps [21,34,55] = [F8,F9,F10]
  N = 35 = F9+1  → gaps [13,21,34] = [F7,F8,F9]   ← THE 35 BROTHERS
  N = 56 = F10+1 → gaps [8,13,21]  = [F6,F7,F8]
  N = 90 = F11+1 → gaps [5,8,13]   = [F5,F6,F7]

This is the 1D projection of the H4 Coxeter 600-cell throat.
The phase boundary 1/φ² is a non-large, non-algebrizing obstruction.
```

## How to navigate the full chain

```
ANSWER (you are here)           ← MACHINE
eutheos-property                ← p-vs-np

CHAIN SHA256 (all 19 repos locked 2026-08-15):
f39ed9a9bd7cc02c6cf415f40b3faaa3c627a5a0d53621766466f31a2211e7ce
See CHAIN.md for all 19 repo HEADs.
```

## Key numbers to hold in context

```
T                = 1419
T hex            = 0x58B
popcount(T)      = 6
T mod 211        = 153
CC9(T)           = 9            (exact)
α₀               = 299 + π/10
α_rat            = 610/987      (F15/F16)
φ                = (1+√5)/2
φ²               = φ + 1
Q5               = 226
Dirichlet bound  = 82829
S14 primes       = [82837..84263]  (14 primes)
N=4M collisions  = 9
chain SHA256     = f39ed9a9bd7cc02c6cf415f40b3faaa3c627a5a0d53621766466f31a2211e7ce
```
