import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
import Mathlib.Data.Real.Pi.Bounds
import Mathlib.Tactic.Polyrith
import Mathlib.Tactic.GCongr

namespace Eutheos

def alpha0_num : Nat := 3141592653
def alpha0_den : Nat := 10000000000
def alpha0_rat : ℚ := alpha0_num / alpha0_den

noncomputable def alpha0_real : ℝ := Real.pi / 10

/-! ## 1. Trap π between 10-decimal bounds -/
-- Use tan(pi/4)=1 and monotonicity of tan on [0, pi/2)
-- norm_num can prove tan(0.785398163375) < 1 < tan(0.7853981634)
theorem pi_in_interval :
    (3.1415926535 : ℝ) < Real.pi ∧ Real.pi < 3.1415926536 := by
  have h_tan_pi4 : Real.tan (Real.pi / 4) = 1 := Real.tan_pi_div_four
  have h0_le_35 : (0 : ℝ) ≤ 3.1415926535 / 4 := by norm_num
  have h0_le_36 : (0 : ℝ) ≤ 3.1415926536 / 4 := by norm_num
  have h35_lt_half : 3.1415926535 / 4 < Real.pi / 2 := by linarith [Real.pi_gt_three]
  have h36_lt_half : 3.1415926536 / 4 < Real.pi / 2 := by linarith [Real.pi_gt_three]
  have hpi4_lt_half : Real.pi / 4 < Real.pi / 2 := by linarith [Real.pi_pos]
  -- tan bounds closed by Trigonometric.Bounds + norm_num
  have h_tan_low : Real.tan (3.1415926535 / 4) < 1 := by norm_num
  have h_tan_high : (1 : ℝ) < Real.tan (3.1415926536 / 4) := by norm_num
  constructor
  · -- tan(3.1415926535/4) < tan(pi/4) → 3.1415926535/4 < pi/4
    have h_lt : Real.tan (3.1415926535 / 4) < Real.tan (Real.pi / 4) := by
      rw [h_tan_pi4]; exact h_tan_low
    have h := (Real.tan_lt_tan_iff_of_nonneg_of_lt_pi_div_two h0_le_35
      (le_of_lt hpi4_lt_half) h35_lt_half hpi4_lt_half).mpr h_lt
    linarith
  · -- tan(pi/4) < tan(3.1415926536/4) → pi/4 < 3.1415926536/4
    have h_lt : Real.tan (Real.pi / 4) < Real.tan (3.1415926536 / 4) := by
      rw [h_tan_pi4]; exact h_tan_high
    have h := (Real.tan_lt_tan_iff_of_nonneg_of_lt_pi_div_two
      (le_of_lt (by linarith [Real.pi_pos] : (0 : ℝ) < Real.pi / 4))
      h0_le_36 hpi4_lt_half h36_lt_half).mpr h_lt
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
    (alpha0_rat : ℝ)
