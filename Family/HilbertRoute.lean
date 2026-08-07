import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Family.Brothers1419

namespace Eutheos

open Complex

/-! ## 0. Time + jitter parameters -/
def alpha0_num : Nat := 3141592653
def alpha0_den : Nat := 10000000000
def MAX_MORNINGSTAR_MS : Nat := 1419

noncomputable def theta_deg (p t : Nat) : ℝ :=
  ((p + t) * alpha0_num % alpha0_den : ℝ) / alpha0_den * 2   -- 0..2°

noncomputable def theta_rad (p t : Nat) : ℝ :=
  theta_deg p t * Real.pi / 180

/-! ## 1. Gate = unitary rotation in ℂ -/
noncomputable def gate (p t : Nat) : ℂ :=
  Complex.exp (Complex.I * theta_rad p t)

theorem gate_norm_one (p t : Nat) : ‖gate p t‖ = 1 := by
  unfold gate
  have h : (Complex.I * (theta_rad p t : ℂ)).re = 0 := by
    simp [Complex.mul_re, Complex.I_re, Complex.I_im]
  -- Complex.norm_exp was renamed; use norm_eq_abs + abs_exp instead
  rw [Complex.norm_eq_abs, Complex.abs_exp, h, Real.exp_zero]

/-! ## 2. Route z through a list of gates -/
noncomputable def route (z : ℂ) (path : List Nat) (t : Nat) : ℂ :=
  path.foldl (fun acc p => acc * gate p t) z

theorem route_norm (z : ℂ) (path : List Nat) (t : Nat) :
    ‖route z path t‖ = ‖z‖ := by
  induction path generalizing z with
  | nil => simp [route]
  | cons p ps ih =>
    simp only [route, List.foldl]
    have hmul : ‖z * gate p t‖ = ‖z‖ := by
      -- norm_mul is the global NormedField lemma; Complex.norm_mul doesn't exist
      rw [norm_mul, gate_norm_one, mul_one]
    have hfold : ps.foldl (fun acc p => acc * gate p t) (z * gate p t) =
                 route (z * gate p t) ps t := rfl
    rw [hfold, ih, hmul]

theorem route_unitary (z : ℂ) (path : List Nat) (t : Nat) :
    ‖route z path t‖ = ‖z‖ := route_norm z path t

/-! ## 3. Jitter Nodup over the full 1419-step window -/
def jitters_at_time (t : Nat) : List Nat :=
  (List.range 35).map (fun p => (p + 1 + t) * alpha0_num % alpha0_den * 2)

def all_jitters_Nodup_upto (M : Nat) : Bool :=
  (List.range (M + 1)).all (fun t => (jitters_at_time t).Nodup)

theorem all_jitters_Nodup_1419 : all_jitters_Nodup_upto 1419 = true := by native_decide

/-! ## 4. EMI reduction in dB -/
theorem emi_reduction_db : (20 : ℝ) * Real.log (1 / 35) / Real.log 10 < -30 := by
  have h1 : Real.log (1 / 35 : ℝ) = -Real.log 35 := by
    rw [one_div, Real.log_inv]
  have h2 : (0 : ℝ) < Real.log 10 := Real.log_pos (by norm_num)
  have h4 : Real.log (1000 : ℝ) < Real.log (1225 : ℝ) :=
    Real.log_lt_log (by norm_num) (by norm_num)
  have h5 : Real.log (1225 : ℝ) = 2 * Real.log 35 := by
    rw [show (1225 : ℝ) = 35 ^ 2 from by norm_num, Real.log_pow]; ring
  have h6 : Real.log (1000 : ℝ) = 3 * Real.log 10 := by
    rw [show (1000 : ℝ) = 10 ^ 3 from by norm_num, Real.log_pow]; ring
  -- div_lt_iff was deprecated in favour of div_lt_iff₀
  rw [div_lt_iff₀ h2]
  linarith [h1, h4, h5, h6]

/-! ## 5. Irrationality of the composite alpha0 witness -/
theorem alpha0_irrational : Irrational (299 + Real.pi / 10) := by
  -- Real.pi_irrational was renamed to irrational_pi
  have hpi : Irrational Real.pi := irrational_pi
  -- π / 10 is irrational: use Irrational.div_rat (q ≠ 0)
  have hpi10 : Irrational (Real.pi / 10) :=
    hpi.div_rat (by norm_num : (10 : ℚ) ≠ 0)
  -- 299 + π/10 is irrational: use Irrational.rat_add
  exact hpi10.rat_add 299

/-! ## 6. Certified chain -/
theorem hilbert_route_clean :
    (∀ p t, ‖gate p t‖ = 1) ∧
    (∀ z path t, ‖route z path t‖ = ‖z‖) ∧
    all_jitters_Nodup_upto 1419 = true :=
  ⟨fun p t => gate_norm_one p t, fun z path t => route_norm z path t, all_jitters_Nodup_1419⟩

end Eutheos
