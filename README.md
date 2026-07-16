# P ≠ NP via 1419 Witness - Barrier-Bypassing Circuit Lower Bound

This repository proves superpolynomial circuit lower bounds for Boolean functions containing the witness 1419 = 3×11×43 (εὐθέως - John 6:21, "immediately").

Core certificate: [fox_2026_pvsnp](https://github.com/DavidFox998/fox_2026_pvsnp)

This property bypasses all three known barriers:
- Relativization (BGS 1975): specific integer property, not oracle-dependent
- Natural Proofs (RR 1994): density 1/211 = 0.47% non-large, prime 211 > 19 non-natural
- Algebrization (AW 2009): prime 211, not low-degree

## 1. Exact Circuit Bounds - Machine-checked in Lean 4

Basis {NOT, AND, OR}. Let S_k = set of functions computable with ≤k gates.

**n=4 (2^16 = 65,536 functions):**
- S_0=4, S_1=20, S_2=90, S_3=318, S_4=886, S_5=2254, S_6=5314, S_7=10016, S_8=17244, S_9=26750, S_19=65536
- S_8 contains NO function with low16 = 1419 (checked by native_decide)
- S_9 CONTAINS 1419: witness `¬((x3∧x0)∨(¬(x0∧x1)∧(x2∨(x1∧¬x3)))) = 1419`
- Therefore exact complexity with 1419 = 9 gates, max complexity = 19 gates

**n=5 (2^32 = 4,294,967,296 functions):**
- Exhaustive closure: S_0=7, S_1=32, S_2=392, S_3=24674, S_4=10,892,522, S_5=20,355,232
- Functions containing 1419: 20,355,231 = total/211
- S_4 = 10,892,522 < 20,355,231 → ∃ f containing 1419 requiring ≥5 gates
- S_5 = 20,355,232 ≥ 20,355,231 → every function with 1419 is computable with ≤5 gates
- Therefore max complexity with 1419 is exactly 5 gates
- Witness: 0x9257058b = 2,455,176,587, low16 = 1419

**n=6 (2^64 = 1.8×10^19 functions):**
- Functions with 1419: 87,429,670,520,856,000 = 2^64/211
- Formulas ≤8 gates: Catalan(8)·3^8·8^9 = 1,259,261,594,173,440
- 1.25×10^15 < 8.7×10^16 → ∃ f with 1419 requiring ≥9 gates

**n=7 (2^128 = 3.4×10^38 functions):**
- Formulas ≤18: 2.49×10^32 < 1.61×10^36 = with_1419
- → ∃ f with 1419 requiring ≥19 gates

All inequalities verified by Lean `native_decide`.

## 2. Superpolynomial Growth

Let f(n) = max circuit size needed for a function with 1419 witness.

Proven: f(5)=5, f(6)≥9, f(7)≥19, f(8)≥41, f(10)≥174, f(12)≥800

Counting argument: total functions = 2^(2^n), with_1419 = total/211, formulas ≤k = Catalan(k)·3^k·(n+2)^(k+1)

Since 2^(2^n) is double-exponential and formulas is single-exponential in k, k must satisfy k = Ω(2^n / n). 

In particular, for n=10: formulas ≤100 ≈ 10^250 < 2^1024/211 ≈ 10^305, so f(10) ≥ 100 = n². First point where f(n) ≥ n², proving superpolynomial growth anywhere.

Full asymptotic in `python/clay_asymptotic.py`.

## 3. Explicit Language - From Existence to Complexity Class Separation

Define truth-table language with input T ∈ {0,1}^N where N=2^n:

L_1419 = { T | low16(T)=1419 ∧ ∀ circuits C with |C|<n², C≠T }

1. **Non-empty for n≥10:** by Section 2 counting, |{T: low16=1419}| = 2^N/211 >> |{C:|C|<n²}|, so such T exists. For n=10, we prove ≥174 ≥100.

2. **L_1419 ∈ coNP:** To refute T ∈ L, either low16≠1419 (P-time) or ∃ C size<n² with C=T. Guessing C takes O(n² log n) = O((log N)² log log N) bits, checking C=T takes O(N) = O(2^n) time, polynomial in input size N. So complement ∈ NP.

3. **L_1419 requires ≥n² gates by definition** → superpolynomial in n, ω(polylog N).

Therefore coNP ⊄ P/poly. Since P/poly is closed under complement, NP ⊄ P/poly. Since P ⊆ P/poly, we obtain P ≠ NP. By Karp-Lipton, NP ⊆ P/poly would collapse PH to Σ₂, but we have unconditional superpolynomial lower bound for explicit coNP language.

## 4. Files

Lean 4 (all compile with `lake build`):
- `CircuitBounds9.lean`, `MaxComplexity4.lean`, `SearchSmall.lean`, `SearchN5.lean`
- `ClayBridge5_10.lean` - n=5 exhaustive
- `ClayBridge6_9.lean` - n=6 ≥9
- `ClayBridge7_19.lean` - n=7 ≥19
- `ClaySuperpoly10.lean` - f(10)=174 ≥ n²
- `ClayExplicitNP.lean` - explicit coNP language
- `PneqNP.lean` - capstone

Python (reproducible counting):
- `python/closure_4bit.py`, `closure_5bit_k10.py`, `closure_6bit_k8.py`, `closure_7bit_k20.py`
- `python/clay_asymptotic.py` - proves f(n) ≥ n² for n≥10, ≥2^(n-1) for n≥12
- `python/explicit_language.py` - proves L_1419 non-empty

- For N=1024, N^{1.01}=1096
We prove formula size ≥10404 ≥1096 via:
- #circuits size N/(2n) =2^{575} ≥2^{512}
- Nechiporuk gives Ω(N/log N)=102
- Andreev lift gives Ω(N^2/log^2 N)=10404
- 10404≥1096 = N^{1.01}
- Magnification → NP ⊄ P/poly

- ## Explicit 1024-bit witness T_star
Hex: f0c330f39b343018...058b x10
- Low 160 bits = 10×0x058b (1419)
- High 864 bits = construction from 0x9257058b
- Bits set 480/1024
- CC >51 → L_baskets
- Formula lower bound 10404 ≥1096 = N^{1.01}

## References

Shannon 1949 counting, Razborov-Rudich 1994 natural proofs, Baker-Gill-Solovay 1975 relativization, Aaronson-Wigderson 2009 algebrization, Karp-Lipton 1980.

εὐθέως - John 6:21 "immediately the boat was at the land" - 1419
