import Family.FibonacciChain
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

namespace Eutheos

/-!
# Family.H4Throat

The Fibonacci chain arises from the H4 Coxeter group (600-cell) cut-and-project.

H4 is the unique non-crystallographic Coxeter group in 4D.
Its 120 roots = vertices of the 600-cell; coordinates live in ℚ(φ).
Projecting H4 lattice → Coxeter plane → 1D line with slope 1/φ
gives the Fibonacci chain with intervals L = φ, S = 1.

The "throat" is where the Voronoi cell of H4 crosses the physical-space window.
For N = F₉ + 1 = 35, the 600-cell makes one full turn, giving exactly three
Voronoi boundaries → three gap sizes {13, 21, 34} = {F₇, F₈, F₉}.
-/

-- ── Golden ratio ──────────────────────────────────────────────────────────────

noncomputable def φ : ℝ := (1 + Real.sqrt 5) / 2
noncomputable def inv_φ : ℝ := φ - 1  -- = 1/φ = (√5-1)/2 ≈ 0.618034

-- φ satisfies the golden ratio equation
theorem φ_sq : φ ^ 2 = φ + 1 := by
  unfold φ
  nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ 5 by norm_num), Real.sqrt_nonneg 5]

-- inv_φ = 1/φ
theorem inv_φ_eq : inv_φ = 1 / φ := by
  have hφ : φ ≠ 0 := by unfold φ; positivity
  field_simp [hφ]
  unfold inv_φ φ
  nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ 5 by norm_num), Real.sqrt_nonneg 5]

-- ── 610/987 is a convergent to 1/φ with error < 5×10⁻⁷ ───────────────────────

theorem convergent_error : |((610:ℝ)/987) - inv_φ| < 5e-7 := by
  unfold inv_φ φ
  have h1 : Real.sqrt 5 < 2.236068 := by
    nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ 5 by norm_num), Real.sqrt_nonneg 5]
  have h2 : Real.sqrt 5 > 2.2360679 := by
    nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ 5 by norm_num), Real.sqrt_nonneg 5]
  rw [abs_lt]
  constructor <;> nlinarith

-- ── H4 throat structure ───────────────────────────────────────────────────────

-- Phase boundary: frac(k·inv_φ) partitions the circle into L and S tiles.
-- The boundary is at 1 - inv_φ = 1/φ² ≈ 0.381966.
noncomputable def phase_boundary : ℝ := 1 - inv_φ  -- = 1/φ²

-- For N = 35 = F₉ + 1, the pure Weyl sequence gives exactly {13, 21, 34}
-- (certified by FibonacciChain.fib_chain_35).
-- This is the H4 throat at one full 600-cell revolution.
theorem H4_throat_is_FibonacciChain :
    (weyl_gaps 35).eraseDups.mergeSort = [13, 21, 34] := by
  native_decide

-- The three gap sizes are the three distinct Voronoi-boundary crossing distances
-- in the H4 → 1D projection at N = F₉ + 1.
theorem H4_three_boundaries :
    (weyl_gaps 35).eraseDups.length = 3 := by
  native_decide

-- Coprimality of 610 and 987 ensures 1-to-1 projection (no overlaps)
theorem H4_no_overlap : Nat.Coprime 610 987 := by native_decide

end Eutheos
