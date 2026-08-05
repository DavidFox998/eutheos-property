import Mathlib.Data.Finset.Sort
import Mathlib.Data.Nat.Fib.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Data.Irrational
import Family.Brothers1419

namespace Eutheos

open Finset

/-!
# Family.WeylGolden

Two-part certification of the 35 brothers of 1419 under the golden-ratio Weyl map.

## Part A  (rational α_rat = 610/987, native_decide, < 1 min)

Certifies by kernel evaluation:
* There are exactly 35 sixteen-bit naturals with popcount = 6 and T ≡ 153 mod 211.
* Their Weyl phase offsets under α_rat = 610/987 span {0,...,986} with exactly
  three distinct gap sizes 13, 21, 34 = F₇, F₈, F₉ (consecutive Fibonacci numbers).
* The gaps sum to 987 = F₁₆ (full circle).

## Part B  (irrational α₀ = 299 + π/10, Mathlib analysis, ~ 3 min)

Proves:
* π is irrational  ⟹  α₀ = 299 + π/10 is irrational.
* Weyl equidistribution placeholder (activate once WeylCriterion import resolves).
-/

-- ───────────────────────────────────────────────────────────────────
-- Part A: Rational golden ratio  (all native_decide)
-- ───────────────────────────────────────────────────────────────────

/-- Numerator of the Fibonacci convergent 1/φ ≈ 610/987 -/
def α_rat_num : ℕ := 610

/-- Denominator: 987 = F₁₆ -/
def α_rat_den : ℕ := 987

/-- Integer Weyl phase: ⌊p · 610/987 · 987⌋ mod 987 = (p * 610) mod 987 -/
def frac_num (p : ℕ) : ℕ := (p * α_rat_num) % α_rat_den

/-- The 35 brothers sorted in ascending order -/
def brothers_list_sorted : List ℕ := brothers_of_1419.sort (· ≤ ·)

/-- Their Weyl phases under α_rat, sorted -/
def phases_sorted : List ℕ :=
  (brothers_list_sorted.map frac_num).mergeSort (· ≤ ·)

/-- Consecutive gaps on the 987-point circle, including the wrap-around gap -/
def gaps_35 : List ℕ :=
  let sorted := phases_sorted
  let rec go : List ℕ → List ℕ
    | []           => []
    | [_]          => []
    | a :: b :: t  => (b - a) :: go (b :: t)
  go sorted ++ [α_rat_den - phases_sorted.getLastD 0 + phases_sorted.headD 0]

-- ── Certified theorems ────────────────────────────────────────────

/-- There are exactly 35 brothers of 1419. -/
theorem brothers_count_is_35 : brothers_of_1419.card = 35 := by native_decide

/-- 1419 itself belongs to the family. -/
theorem mem_1419 : 1419 ∈ brothers_of_1419 := by native_decide

/-- The three distinct gap sizes are exactly 13, 21, 34. -/
theorem gaps_are_Fib_triplet :
    gaps_35.eraseDups.mergeSort = [13, 21, 34] := by native_decide

/-- 13 = F₇, 21 = F₈, 34 = F₉ — consecutive Fibonacci numbers. -/
theorem gaps_are_consecutive_Fib :
    gaps_35.eraseDups.mergeSort = [Nat.fib 7, Nat.fib 8, Nat.fib 9] := by native_decide

/-- The 35 gaps tile the full circle of 987 points. -/
theorem gaps_sum_987 : gaps_35.sum = 987 := by native_decide

/-- Single compound sentence suitable for patent/paper footnote. -/
theorem certified_sentence :
    brothers_of_1419.card = 35 ∧
    gaps_35.eraseDups.mergeSort = [13, 21, 34] ∧
    gaps_35.sum = 987 :=
  ⟨by native_decide, by native_decide, by native_decide⟩

-- ───────────────────────────────────────────────────────────────────
-- Part B: Irrational α₀ = 299 + π/10  (Mathlib analysis)
-- ───────────────────────────────────────────────────────────────────

/-- True golden-ratio anchor: α₀ = 299 + π/10.
    Transcendental (hence irrational) because π is transcendental. -/
noncomputable def α₀ : ℝ := 299 + Real.pi / 10

/-- π is irrational (Mathlib: `Real.pi_irrational`), so α₀ = 299 + π/10 is irrational.

    Proof sketch:
      Suppose α₀ = q ∈ ℚ.  Then π = 10·(q - 299) ∈ ℚ, contradicting π_irrational.
-/
theorem α₀_irrational : Irrational α₀ := by
  unfold α₀
  -- π/10 is irrational: if π/10 = q then π = 10q ∈ ℚ, contradicting Real.pi_irrational
  have hπ : Irrational Real.pi := Real.pi_irrational
  have h10 : (10 : ℝ) ≠ 0 := by norm_num
  have hπ10 : Irrational (Real.pi / 10) := by
    intro ⟨q, hq⟩
    apply hπ
    exact ⟨q * 10, by field_simp at hq ⊢; linarith [hq.symm]⟩
  -- 299 + (irrational) is irrational
  intro ⟨q, hq⟩
  apply hπ10
  exact ⟨q - 299, by push_cast at hq ⊢; linarith⟩

/-
-- ── Weyl equidistribution (activate once import resolves) ─────────
-- import Mathlib.NumberTheory.Equidistribution.WeylCriterion
--
-- theorem weyl_α₀_equidistributed :
--     Equidistributed (fun n : ℕ => Int.fract (↑n * α₀)) :=
--   WeylEquidistribution.irrational α₀_irrational
--
-- theorem dirichlet_density_tends_to_one :
--     ∀ ε > 0, ∃ N, ∀ n ≥ N,
--       (brothers_of_1419.card : ℝ) / 310 > 1 - ε := by
--   sorry  -- follows from weyl_α₀_equidistributed + measure calculation
-/

end Eutheos
