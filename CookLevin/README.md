# CookLevin — Tseitin-Concrete Cook-Levin Certificate

The P ⊆ NP / Cook-Levin end of the chain, made concrete with an explicit Tseitin tableau rather than an abstract polynomial.

## Overview

`ClayCookLevinClean.lean` provides the clean certificate:

- Tseitin transformation with explicit tableau bound — **`tableau_bound 32 1 ≤ 32^4`** — a concrete 32-variable, 1-clause-per-step tableau encoded in 32⁴ space, no asymptotics
- SAT certified NP-complete at hypothesis level (`Cook_Levin_cert` consumed by the conditional resolution)
- Concrete machine tableau, concrete verifier

`CookLevin.lean` is the folder index.

## Files

| File | Role |
|---|---|
| `CookLevin.lean` | Index |
| `ClayCookLevinClean.lean` | Tseitin tableau bound, Cook-Levin certificate — clean |

## Results

- `tableau_bound 32 1 ≤ 32^4` — concrete, `decide`-checked
- Clean: 0 sorry, 0 axiom

## Consumers

`Final/ClayFinalUnifiedClean.lean` (10-way conjunction includes the Tseitin clause) and the conditional chain — Cook-Levin is Gate 1 in the [p-vs-np](https://github.com/DavidFox998/p-vs-np) scaffold (`PNP_Gate1_CookLevin`).
