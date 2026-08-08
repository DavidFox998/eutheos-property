import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
import Mathlib.Data.Real.Pi.Bounds
import Mathlib.Tactic.Interval
import Mathlib.Tactic.Polyrith

namespace Eutheos

def alpha0_num : Nat := 3141592653
def alpha0_den : Nat := 10000000000
def alpha0_rat : ℚ := alpha0_num / alpha0_den

noncomputable def alpha0_real : ℝ := Real.pi / 10

/-! ## 1. Trap π between 10-decimal bounds -/
theorem pi_in_interval :
    (3.1415926535 : ℝ) < Real.pi ∧ Real.pi < 3.1415926536 := by
  have h_tan_pi4 : Real.tan (Real.pi / 4) = 1 := Real.tan_pi_div_four
  -- interval can prove tan(0.785398163375) < 1 < tan(0.7853981634) rigorously
  have h_tan_low : Real.tan (3.1415926535 / 4) < 1 := by
    have h : Real.tan (3.1415926535 / 4) < 0.9999999999 := by interval
    linarith
  have h_tan_high : (1 : ℝ) < Real.tan (3.1415926536 / 4) := by
    have h : (1.0000000001 : ℝ) < Real.tan (3.1415926536 / 4) := by interval
    linarith
  have hmono : StrictMonoOn Real.tan (Set.Ioo (-Real.pi/2) (Real.pi/2)) :=
    Real.tan_strictMonoOn
  have hmem_pi4 : Real.pi / 4 ∈ Set.Ioo (-Real.pi/2) (Real.pi/2) := by
    constructor <;> linarith [Real.pi_pos, Real.pi_gt_three]
  have hmem_35 : (3.1415926535 / 4 : ℝ) ∈ Set.Ioo (-Real.pi/2) (Real.pi/2) := by
    constructor <;> linarith [Real.pi_gt_three, Real.pi_pos]
  have hmem_36 : (3.1415926536 / 4 : ℝ) ∈ Set.Ioo (-Real.pi/2) (Real.pi/2) := by
    constructor <;> linarith [Real.pi_gt_three, Real.pi_pos]
  constructor
  · have h_lt : Real.tan (3.1415926535 / 4) < Real.tan (Real.pi / 4) := by
      rw [h_tan_pi4]; exact h_tan_low
    have h_eq := hmono.lt_iff_lt hmem_35 hmem_pi4 |>.mpr h_lt
    linarith
  · have h_lt : Real.tan (Real.pi / 4) < Real.tan (3.1415926536 / 4) := by
      rw [h_tan_pi4]; exact h_tan_high
    have h_eq := hmono.lt_iff_lt hmem_pi4 hmem_36 |>.mpr h_lt
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
