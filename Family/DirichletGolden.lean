import Family.WeylGolden
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum

namespace Eutheos

def Q5 : ℕ := 226
def bound_Q5 : ℕ := 82829 -- 733 * 113, = 733 * (Q5/2). NOT 733*Q5^2

def S14 : List ℕ :=
  [82837, 82891, 83047, 83063, 83117, 83203, 83219, 83257,
   83273, 83639, 83983, 84053, 84247, 84263]

def S4 : List ℕ := [82837, 82891, 83047, 83063]

theorem S14_card_14 : S14.length = 14 := by native_decide
theorem S4_card_4 : S4.length = 4 := by native_decide
theorem S4_sub_S14 : S4 = S14.take 4 := by native_decide
theorem all_gt_bound : S14.all (· > bound_Q5) = true := by native_decide

-- Use PURE Weyl gaps, not brothers gaps
theorem dirichlet_gap_bound : 13 ∈ weyl_gaps_35 := by native_decide
theorem dirichlet_min_gap : weyl_gaps_35.min? = some 13 := by native_decide
theorem dirichlet_max_gap : weyl_gaps_35.max? = some 34 := by native_decide

theorem coprime_610_987 : Nat.Coprime 610 987 := by native_decide
theorem no_collision_bound : (34 : ℝ) / 987 < 0.035 := by norm_num

theorem certified_S14_Dirichlet :
    S14.length = 14 ∧ S4.length = 4 ∧ bound_Q5 = 82829 ∧ Q5 = 226 :=
  ⟨by native_decide, by native_decide, by native_decide, by native_decide⟩

end Eutheos
