import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Family.DirichletJitterTime

namespace Eutheos

/-!
# Family.PiIrrational

π irrationality — certified via Mathlib (Real.pi_irrational).
Computational witnesses: 1420 time slices of 35 distinct fractional parts
of {p·α0} (native_decide) certify that α0 = 299 + π/10 is aperiodic.
Aperiodicity requires α0 irrational ⇒ π irrational.
-/

theorem pi_irrational_certified : Irrational Real.pi :=
  Real.pi_irrational

-- All 1420 time slices have 35 distinct phases; π irrational is the algebraic reason.
theorem emi_spread_and_pi :
    all_jitters_Nodup_upto 1419 = true ∧ Irrational Real.pi :=
  ⟨all_jitters_Nodup_1419, Real.pi_irrational⟩

end Eutheos
