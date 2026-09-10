# python/ — Generators and Counters Behind the Measured Constants

Python companions to `../` — the scripts that **measured** the constants the Lean files certify by `native_decide`. Lean verifies; these scripts discovered.

## Overview

- **Witness generators** — `T_star_alpha0.py` (mpmath generator: `frac(p·α₀)·2³²`, α₀ = 299 + π/10) and `T_star_1024.py` (the 1024-bit witness `T_star`, low word `W = 0x9257058b`).
- **Circuit counters** — `closure_4bit.py` (source of the exact ladder `S8 = 17244`, `S19 = 65536`), `closure_5bit_k10.py`, `closure_6bit_k8.py`, `closure_7bit_k20.py` (closure sizes ≥ 5 / 9 / 19 gates), `exact_S4_lookup.py` (`S4 = 10892522`), `next_exact_cc.py`, `next_subfunctions.py`, `5gates.py`.
- **Density and gap analysis** — `rare_density.py`, `counting_gap.py`, `threshold_analysis.py`, `hard_5bit.py`, `explicit_language.py`, `clay_asymptotic.py`.
- **Orchestration** — `overnight.py` (batch runs), `analysis.py` (summary tables).

## Role in the pipeline

1. Python measures (exhaustive enumeration where feasible, mpmath where not) → constants recorded in comments and Lean literals.
2. Lean re-proves each constant by `native_decide` — the Python numbers are checked, never trusted.
3. Anything Lean cannot yet re-prove stays a documented measurement, not a theorem.

## Files

18 scripts, self-contained, standard library + `mpmath` where noted. No build step — run individually with `python3 <script>.py`.

## Status

Support code — not part of the Lean build, not under the 0-sorry discipline. Listed here because every "measured" number in `Family/*.lean` traces back to one of these scripts.
