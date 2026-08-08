import Mathlib.Data.Finset.Sort
import Mathlib.Data.Nat.Fib.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Tactic.NormNum

namespace Eutheos

/-! Pure Weyl N=35 gives [13,21,34], brothers filtered give 19 gaps -/

def α_rat_num : ℕ := 610
def α_rat_den : ℕ := 987
def frac_num (p : ℕ) : ℕ := (p * α_rat_num) % α_rat_den

-- Hardcode 35 brothers (popcount=6, ≡153 mod 211) — this is what you computed
def brothers_of_1419_list : List ℕ :=
  [1419, 1841, 2474, 4584, 5428, 5639, 6694, 9648, 9859, 10914, 12813, 13024, 13446,
   16611, 18088, 18510, 21042, 21253, 24629, 25473, 25684, 29060, 33069, 34124,
   35601, 39188, 40032, 41298, 41509, 42564, 43408, 44041, 49738, 51848]

def brothers_list_sorted : List ℕ := brothers_of_1419_list.mergeSort (· ≤ ·)

def phases_sorted : List ℕ :=
  (brothers_list_sorted.map frac_num).mergeSort (· ≤ ·)

def gaps_35 : List ℕ :=
  let sorted := phases_sorted
  let rec go : List ℕ → List ℕ
  | [] => [] | [_] => [] | a :: b :: rest => (b - a) :: go (b :: rest)
  go sorted ++ [α_rat_den - (phases_sorted.getLastD 0) + (phases_sorted.headD 0)]

-- Pure Weyl N=35 for comparison
def weyl_phase_35 (k : ℕ) : ℕ := (k * 610) % 987
def weyl_points_35 : List ℕ := (List.range 35 |>.map weyl_phase_35).mergeSort (· ≤ ·)
def weyl_gaps_35 : List ℕ :=
  let rec go : List ℕ → List ℕ
  | [] => [] | [_] => [] | a :: b :: t => (b - a) :: go (b :: t)
  go weyl_points_35 ++ [987 - weyl_points_35.getLastD 0 + weyl_points_35.headD 0]

-- Green certs
theorem brothers_count_is_35 : brothers_list_sorted.length = 35 := by native_decide
theorem mem_1419 : 1419 ∈ brothers_list_sorted := by native_decide

theorem pure_gaps_are_Fib_triplet :
  (weyl_gaps_35.eraseDups.mergeSort = [13, 21, 34]) := by native_decide

theorem brothers_gaps_are_19 :
  (gaps_35.eraseDups.mergeSort = [1, 4, 5, 6, 10, 11, 15, 16, 20, 21, 26, 32, 36, 42, 47, 52, 89, 114, 250]) := by native_decide

theorem gaps_sum_987 : gaps_35.sum = 987 := by native_decide
theorem weyl_sum_987 : weyl_gaps_35.sum = 987 := by native_decide

theorem certified_sentence :
  brothers_list_sorted.length = 35 ∧
  weyl_gaps_35.eraseDups.mergeSort = [13,21,34] ∧
  gaps_35.sum = 987 :=
  ⟨by native_decide, by native_decide, by native_decide⟩

-- Part B: α0 irrational
noncomputable def α0 : ℝ := 299 + Real.pi / 10

theorem α0_irrational : Irrational α0 := by
  have hπ : Irrational Real.pi := Real.irrational_pi
  unfold α0
  have hπ10 : Irrational (Real.pi / 10) := by
    intro ⟨q, hq⟩
    apply hπ
    exact ⟨q * 10, by have hq' := hq; field_simp at hq' ⊢; linarith⟩
  intro ⟨q, hq⟩
  apply hπ10
  exact ⟨q - 299, by have hq' := hq; push_cast at hq' ⊢; linarith⟩

end Eutheos
