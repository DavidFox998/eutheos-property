import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
    import Mathlib.Data.Real.Pi.Bounds
    import Mathlib.Tactic.Polyrith

    namespace Eutheos

    def alpha0_num : Nat := 3141592653
    def alpha0_den : Nat := 10000000000
    def alpha0_rat : ℚ := alpha0_num / alpha0_den

    noncomputable def alpha0_real : ℝ := Real.pi / 10

    /-! ## 1. Trap π between 10-decimal bounds -/
    -- Mathlib 4.15.0 Pi.Bounds exposes pi_gt_d20 and pi_lt_d20:
    --   Real.pi_gt_d20 : 3.14159265358979323846 < Real.pi
    --   Real.pi_lt_d20 : Real.pi < 3.14159265358979323847
    -- Both bracket [3.1415926535, 3.1415926536] so linarith closes each goal.
    theorem pi_in_interval :
      (3.1415926535 : ℝ) < Real.pi ∧ Real.pi < 3.1415926536 :=
    ⟨by linarith [Real.pi_gt_d20], by linarith [Real.pi_lt_d20]⟩

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
    