import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
import Mathlib.Data.Real.Pi.Bounds
import Mathlib.Tactic.Polyrith

namespace Eutheos

def alpha0_num : Nat := 3141592653
def alpha0_den : Nat := 10000000000
def alpha0_rat : ℚ := alpha0_num / alpha0_den

noncomputable def alpha0_real : ℝ := Real.pi / 10

/-! ## 1. Trap π between 10-decimal bounds via sin sign -/
theorem pi_in_interval :
    (3.1415926535 : ℝ) < Real.pi ∧ Real.pi < 3.1415926536 := by
  have hpi_gt_3 : (3 : ℝ) < Real.pi := Real.pi_gt_three
  have hpi_lt_4 : Real.pi < 4 := Real.pi_lt_four
  have h2pi_gt_35 : (3.1415926535 : ℝ) < 2 * Real.pi := by linarith
  have h2pi_gt_36 : (3.1415926536 : ℝ) < 2 * Real.pi := by linarith
  constructor
  · -- sin 3.1415926535 > 0  →  3.1415926535 < pi, because sin <0 on [pi,2pi)
    have hsin_pos : 0 < Real.sin 3.1415926535 := by
      -- Taylor bounds from Trigonometric.Bounds, closed by norm_num
      norm_num
    by_contra h_le
    push_neg at h_le
    -- if pi ≤ 3.1415926535 < 2pi then sin ≤0, contradiction
    have hsin_neg : Real.sin 3.1415926535 ≤ 0 :=
      le_of_lt (Real.sin_neg_of_pi_le_of_lt_two_pi h_le h2pi_gt_35 |>.trans_le (le_of_lt Real.sin_lt_zero_of_pi_lt_of_lt_two_pi?) )
    -- simpler direct lemma:
    have h_neg : Real.sin 3.1415926535 < 0 :=
      Real.sin_neg_of_pi_le_of_le_two_pi h_le (le_of_lt h2pi_gt_35)
    linarith
  · -- sin 3.1415926536 < 0  →  pi < 3.1415926536, because sin >0 on (0,pi)
    have hsin_neg : Real.sin 3.1415926536 < 0 := by
      norm_num
    by_contra h_ge
    push_neg at h_ge
    have h_le : (3.1415926536 : ℝ) ≤ Real.pi := h_ge
    have hsin_nonneg : 0 ≤ Real.sin 3.1415926536 :=
      Real.sin_nonneg_of_nonneg_of_le_pi (by norm_num) h_le
    linarith

/-! ## 2. Bridge -/
theorem alpha0_rat_close :
    |alpha0_real - (alpha0_rat : ℝ)| < 6e-11 := by
  have ⟨hlo, hhi⟩ := pi_in_interval
  have hrat : (alpha0_rat : ℝ) = 0.3141592653 := by
    norm_num [alpha0_rat, alpha0_num, alpha0_den]
  unfold alpha0_real
  rw [hrat, abs_lt]
  constructor <;> linarith

def W1 : Nat := 11 * 13
def W2 : Nat := 17 * 19
def W3 : Nat := 191 * 193

theorem self_symmetry : W1 * W2 = 46189 ∧ W3 = 36863 :=
  ⟨by native_decide, by native_decide⟩

theorem alpha_bridge_clean :
    (alpha0_rat : ℝ) = 0.3141592653 ∧
    |alpha0_real - (alpha0_rat : ℝ)| < 6e-11 ∧
    W1 * W2 = 46189 ∧ W3 = 36863 :=
  ⟨by norm_num [alpha0_rat, alpha0_num, alpha0_den],
   alpha0_rat_close,
   by native_decide,
   by native_decide⟩

end Eutheos
