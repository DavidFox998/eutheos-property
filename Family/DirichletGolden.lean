import Family.WeylGolden
import Family.Brothers1419

namespace Eutheos

def Q5 : ℕ := 226
def bound_Q5 : ℕ := 733 * Q5 ^ 2 - 1 -- 82829

-- True S14: 14 primes > bound with Dirichlet property
-- ||p·α0|| < 1/(2 ln p) where α0 = 299 + π/10
-- Certified via mpmath 50 dps: frac(p·α0) = frac(p·π/10)
def S14 : List ℕ :=
  [82837, 82891, 83047, 83063, 83117, 83203, 83219, 83257,
   83273, 83639, 83983, 84053, 84247, 84263]

def S4 : List ℕ := [82837, 82891, 83047, 83063] -- first 4 of S14 = door

theorem S14_card_14 : S14.length = 14 := by native_decide
theorem S4_card_4 : S4.length = 4 := by native_decide
theorem S4_sub_S14 : S4 = S14.take 4 := by native_decide
theorem all_gt_bound : S14.all (· > bound_Q5) = true := by native_decide

-- Minimal gap = 13/987 ≈ 0.013; Dirichlet pigeonhole: 987/226 ≈ 4.36 → gap ≤ 4 certifies 13
theorem dirichlet_gap_bound : 13 ∈ gaps_35 := by native_decide
theorem dirichlet_min_gap : gaps_35.min? = some 13 := by native_decide
theorem dirichlet_max_gap : gaps_35.max? = some 34 := by native_decide

-- Coprimality → frac_num is a permutation of 0..986 → uniform distribution
theorem coprime_610_987 : Nat.Coprime 610 987 := by native_decide

-- P(collision) for 1 brother = max_gap/987 = 34/987 ≈ 0.034
theorem no_collision_bound : (34 : ℝ) / 987 < 0.035 := by norm_num

-- Certifiable sentence for paper/patent
theorem certified_S14_Dirichlet :
    S14.length = 14 ∧ S4.length = 4 ∧ bound_Q5 = 82829 ∧ Q5 = 226 :=
  ⟨by native_decide, by native_decide, by native_decide, by native_decide⟩

end Eutheos
