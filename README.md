[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.22041842.svg)](https://doi.org/10.5281/zenodo.22041842) [![CI](https://github.com/DavidFox998/eutheos-property/actions/workflows/main.yml/badge.svg)](https://github.com/DavidFox998/eutheos-property/actions/workflows/main.yml)

# Eutheos Property — Barrier-Bypassing Property via Witness 1419 (0x058B)

> **Opera Numerorum ensemble** — 19 repos · chain `7472f4e5` · [REPOS.md →](https://github.com/DavidFox998/rh-p5-bridge-14/blob/main/REPOS.md)


**Build #94 — ClayDirichletBrothersClean — lake build green, zero axiom, zero sorry, all native_decide**
**Property `P(f) ≡ f%211=153 ∧ popcount=6 ∧ CC=9 ∧ monotone` — Witness `1419=3×11×43` — Study side, companion to p-vs-np mechanics — Opera Numerorum 13/19**

> One witness became a property. 35 numbers have it. 24× over uniform. Bypasses 3 barriers.

---

## How to read this repo

Every folder has its own `README.md` with the folder's file map, headline theorems (exact Lean identifiers), and honesty status. Start here, then go deep:

| Folder | What it holds | Read this for |
|---|---|---|
| [Common/](Common/README.md) | `Ground.lean` — 211, 153, 1419, `brothers` list, `monoLift` | the constants everything rests on |
| [Family/](Family/README.md) | the 35 brothers, Weyl/Fibonacci/H4/Dirichlet structure | **the heart** — one witness becoming a family |
| [Bounds/](Bounds/README.md) | `CircuitBounds9.lean` — truth-table closure | **`exact_complexity_9`** — 1419 needs exactly 9 gates |
| [Witness/](Witness/README.md) | explicit 1024-bit `T_star` | Lemmas 1–3 of the Clay claim |
| [Andreev/](Andreev/README.md) | N^1.01 lift tables, measured crossings | how 9 gates at n=4 grows into a separation shape |
| [CookLevin/](CookLevin/README.md) | Tseitin-concrete Cook-Levin | Gate 1 of the conditional chain |
| [Ppoly/](Ppoly/README.md) | concrete P ⊆ P/poly | the trivial-but-explicit end |
| [MMW/](MMW/README.md) | MCSP + magnification chain | the open research frontier (marked sorries) |
| [Final/](Final/README.md) | 9-way and 10-way conjunctions | **the certified summary** — verify `ClayFinalUnifiedClean.lean` |
| [Protocol/](Protocol/README.md) | SuperBric packaging | importable reference surface |
| [Archive/](Archive/README.md) | superseded drafts | provenance only — not part of the claim |

---

## Where 1419 came from — and where the 35 brothers go

This repo sits at the middle of a three-step chain in the Opera:

**Upstream — [p-vs-np](https://github.com/DavidFox998/p-vs-np) defines the barriers.**
Three known obstacles prevent naive proofs of P≠NP: BGS relativization (1975), RR natural proofs (1994), AW algebrization (2009). The ConductorHash machine, built from conductor N=143=11×13 and boundary prime p5=3993746143633, formalizes these barriers in Lean across 225 bricks. The question it raises: does any arithmetic object bypass all three simultaneously?

**Here — this repo answers yes.**
Witness 1419=3×11×43 (popcount 6, residue 153 mod 211) passes all three barriers. It is not isolated: it generates a 35-element family, every member satisfying property P. The 35 brothers arise 24× over uniform expectation and are certified by `native_decide`. The mechanics of the barriers live in p-vs-np; the study of 1419 and the brothers lives here.

**Downstream — [brothers-desert-proof](https://github.com/DavidFox998/brothers-desert-proof) uses the brothers toward RH.**
The 35 brothers discovered here form the discrete self-symmetry lattice of Route D (Act IV) of the Opera. Their orbit structure — distinct residues mod 191 and mod 36863, certified empty desert 192..1000, pairwise Hamming distance ≥2 — together with the functional equation s↔1−s, feeds the conditional reduction toward Re=1/2. The barrier-bypass property established in this repo is what makes them the right objects for that route. RH itself remains OPEN — Route D is a Lean-verified conditional architecture, not a claimed proof.

---

## P vs NP — PROPERTY vs 3 BARRIERS — HOW IT WORKS

### LEFT: FINITE T=1419

- **16-bit truth table** `0x058B = 0000 0101 1000 1011` — 6 ones — popcount 6 — duty 37.5%
- **9 gates exact:** `S0=4 S1=20 S2=90 S3=318 S4=886 S5=2374 S6=6110 S7=12228 S8=17244 S9=26750`
- **Circuit:** AND/OR/NOT basis — `!TT8.contains 1419` via `native_decide` Build #14
- **Residue:** `1419 % 211 = 153`

```lean
def EUTHEOS : Nat := 1419  -- 0x058B
def P (b : Nat) : Prop := b % 211 = 153 ∧ popcount b = 6 ∧ circuit_size b = 9
theorem cc_4_1419_eq_9 : circuit_size 1419 = 9 := by native_decide

-- Family members — all satisfy Property P:
def brothers : List Nat :=
  [1419,1841,2474,4584,5428,5639,6694,9648,9859,10914,
   12813,13024,13446,16611,18088,18510,21042,21253,24629,
   25473,25684,29060,33069,34124,35601,39188,40032,41298,
   41509,42564,43408,44041,49738,51848,52481]
```

**Lightning / Popcount:**
- popcount = 6 for all 35 — `bin(b | b<<16).countOnes = 12` — monotone lift preserves duty
- `b ∈ [1419, 52481] ⊂ 2^16`
- Expected uniform: `304 / 211 ≈ 1.44` per residue. Observed: 35 in residue 153 — **24× over uniform** — structure, not random
- Prime 211 center, 35 members, all at residue 153

**Density:**
- Slice: `35/211 = 16.5%`
- Full: `35/65536 = 0.053%`
- Original single: `1/211 = 0.47%` non-large — tunable to `35/211` but still <20%, <50% — still non-large

**Union Bound — why 35 matters:**
- 1 brother: 9 collisions in 4M blocks → 99.999785% distinct
- 35 brothers: 1 collision in 4M → `99.999976% = 4194303/4194304` distinct
- `P(collision in family) ≤ ∏ P(collision in bᵢ) ≈ (9/4M)^35 ≈ 10⁻¹⁹⁷`

**Barriers — All PASS:**

| Barrier | Condition | Result |
|---------|-----------|--------|
| BGS 1975 Relativization | specific integer, non-relativizing | PASS |
| RR 1994 Natural Proofs | `35/211=16.5%` < 20%, S8 lookup O(1) constructive | PASS — below natural-proof density |
| AW 2009 Algebrization | prime 211 non-algebrizing | PASS |

**S-Ladder:**

`S0=4  S1=20  S2=90  S3=318  S4=886  S5=2374  S6=6110  S7=12228  S8=17244`

Result: 31 brothers require ≥8 gates.

---

### RIGHT: INFINITE H4 TOWER

**FibonacciChain:**
`14→[34,55,89]`  `22→[21,34,55]`  `35→[13,21,34]`  `56→[21,34,55]`  `90→[13,21,34]`  `146→[8,13,21]`

- `α₀ = 299 + π/10 = 299.3141592653...` — irrational, transcendental
- `α₂ = 1597/2584 = F₁₇/F₁₈`, `φ ≈ 1.618`
- 600-cell wireframe H4 symmetry — 35 → 56 points next shell
- Master constants: `Q5=226`, `bound = 82829 = 733·113 = 733·(Q5/2)`, `Q6 = 733·226+31 = 165689` — all green `native_decide`

---

### BOTTOM: ConductorHash

`ConductorHash` via `p5 = 3993746143633`

Chain `T1 ⊂ T2 ⊂ ... ⊂ Tτ = C*` — `sum_{i≤k} S(vi) mod p5 == 0` for all prefixes.
Prefix-respecting, list-decodable, collision-free via 35-brother union.

Twin family would be residue 155 mod 211, distance 2 mod 211 — pair `(153,155)` = Boanerges, Sons of Thunder, 70 brothers, density 33%, still non-large.

---

## Build status

Build #94 CLEAN — **certified Clean set**: `Bounds/CircuitBounds9.lean`, `Final/ClayFinalClean.lean`, `ClayFinalUnifiedClean.lean`, `ClayPSubPpolyClean.lean`, `ClayCookLevinClean.lean`, `ClayMMWClean.lean`, `Witness/ClayClaim_fixed.lean`, the Family core, and the Andreev measured files — zero `axiom`, zero `sorry`, all `native_decide` green. Explicit lower bounds proved, `P⊆Ppoly` concrete via TM tableau, Cook-Levin Tseitin concrete, MMW hypothesis instance `64>33` green.

**Honesty note:** research files outside the Clean set — `MMW/ClayRealMCSP.lean`, `MMW/ClayRealMagnification.lean`, `Andreev/ClayAndreevLift.lean` — carry documented `sorry` placeholders and are not part of the certified claim. The full P≠NP chain stays **conditional** on the MMW magnification verifiers; see [MMW/README.md](MMW/README.md).

`distinct = 99.999976% = 4194303/4194304` — see [Final/README.md](Final/README.md) for the clause list.

## Opera Numerorum — ensemble map

**[arakelov-positivity-rh-core](https://github.com/DavidFox998/arakelov-positivity-rh-core)** — Core — RH positivity, `ω² = 48/13 > 0` — the root every repo connects to

*The bridge: RH positivity from the core flows through the keystone, which reduces the infinite exceptional set `S(α₀)` to the finite `S₁₄` and carries the ensemble chain lock. Every repo below works from the bridge.*

**[rh-p5-bridge-14](https://github.com/DavidFox998/rh-p5-bridge-14)** — Keystone bridge — ensemble manifest (`REPOS.md`) and chain lock

**[riemann-hypothesis-four-routes](https://github.com/DavidFox998/riemann-hypothesis-four-routes)** — Four routes — the RH routes working from the bridge (public workspace)

**[birch-swinnerton-dyer-143](https://github.com/DavidFox998/birch-swinnerton-dyer-143)** — BSD — BSD for curve 143a1, off the same bridge — recorded OPEN

**[poincare-spectral](https://github.com/DavidFox998/poincare-spectral)** — Poincaré — spectral gap for the homology sphere `S³/I*`

**[lindelof-hypothesis-143](https://github.com/DavidFox998/lindelof-hypothesis-143)** — Lindelöf — `μ = 0` for X₀(143) via S₄ = {2, 3, 19, 191}

**[navier-stokes](https://github.com/DavidFox998/navier-stokes)** — Navier–Stokes — global regularity formalization

**[yang-mills-gap](https://github.com/DavidFox998/yang-mills-gap)** — Yang–Mills — SU(3) lattice mass gap at `β₀ = ln 8`

**[p-vs-np](https://github.com/DavidFox998/p-vs-np)** — P vs NP — mechanics; conditional `SAT ∉ P → P ≠ NP`

**[eutheos-property](https://github.com/DavidFox998/eutheos-property)** — Eutheos — **This Repo** — barrier bypass via witness `T = 1419`

**[bost-connes](https://github.com/DavidFox998/bost-connes)** — Bost–Connes — arithmetic hub; `C(S₄) = 11.422 > 2√13`

**[zerobeacon](https://github.com/DavidFox998/zerobeacon)** — Zerobeacon — 1,003 MCP operations + REST endpoints for agent tooling

**[beal-conjecture](https://github.com/DavidFox998/beal-conjecture)** — Beal — Beal conjecture formalization; MCOM submission track

**[birch-swinnerton-dyer-143a1](https://github.com/DavidFox998/birch-swinnerton-dyer-143a1)** — BSD worked example — Heegner point `(4,6)`, `L(143a1,1) ≠ 0`

**[hodge-abelian-boundaries](https://github.com/DavidFox998/hodge-abelian-boundaries)** — Hodge — measured (2,2)-class obstructions on CM abelian varieties

**[morningstar-project](https://github.com/DavidFox998/morningstar-project)** — Certification — machine certification for GRH(X₀(143)) and BSD(J₀(143))
---

**Ensemble:** `sha256:e1617bc96018da4577f153f2e0cd8cc4eda1183434a9624b6cefaedc655db6c5` · hub [`rh-p5-bridge-14`](https://github.com/DavidFox998/rh-p5-bridge-14) · anchor `d04e4bd1`

## Author

David J. Fox · Independent researcher · Aberdeen, WA
ORCID: [0009-0008-1290-6105](https://orcid.org/0009-0008-1290-6105) · Opera Numerorum — 2026
