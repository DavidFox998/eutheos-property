# Ppoly — P vs P/poly, Concretely

The circuit-lower-bound end of the chain: P ⊆ P/poly by an explicit Turing-machine tableau, not an abstract argument.

## Overview

`ClayPSubPpolyClean.lean` gives the clean certificate for the trivial-but-often-hand-waved inclusion: a polynomial-time decider yields polynomial-size circuits, via a concrete TM tableau — explicit tape alphabet, explicit time bound, explicit circuit family extracted from the tableau.

## Files

| File | Role |
|---|---|
| `Ppoly.lean` | Index |
| `ClayPSubPpolyClean.lean` | Concrete P ⊆ P/poly via TM tableau — clean |

## Results

- `P ⊆ P/poly` concrete — clean: 0 sorry, 0 axiom

## Consumers

`Final/ClayFinalClean.lean` and the magnification chain in `MMW/` — the direction that matters for separation is the *strictness* of P ⊂ P/poly (Karp-Lipton territory, formalized in the [p-vs-np](https://github.com/DavidFox998/p-vs-np) scaffold as `Cert_KL_AdviceStep` / `karp_lipton_main`).
