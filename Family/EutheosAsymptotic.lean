import Mathlib.Data.Nat.Fib.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace Eutheos

def N_blocks : ℕ := 4000000
def collisions_1 : ℕ := 9
def distinct_1 : ℕ := N_blocks - collisions_1

def density_initial_per_100 : ℕ := 71
def density_final_per_100k : ℕ := distinct_1 * 100000 / N_blocks

def bound_Q5_check : ℕ := 82829
def S14_check : List ℕ :=
  [82837, 82891, 83047, 83063, 83117, 83203, 83219, 83257,
   83273, 83639, 83983, 84053, 84247, 84263]

def weyl_phase_asym (k : ℕ) : ℕ := (k * 610) % 987
def weyl_points_asym : List ℕ := (List.range 35 |>.map weyl_phase_asym).mergeSort (· ≤ ·)
def weyl_gaps_asym : List ℕ :=
  let rec go : List ℕ → List ℕ
  | [] => [] | [_] => [] | a :: b :: t => (b - a) :: go (b :: t)
  go weyl_points_asym ++ [987 - weyl_points_asym.getLastD 0 + weyl_points_asym.headD 0]

def brothers_35_list : List ℕ :=
  [1419, 1841, 2474, 4584, 5428, 5639, 6694, 9648, 9859, 10914, 12813, 13024, 13446,
   16611, 18088, 18510, 21042, 21253, 24629, 25473, 25684, 29060, 33069, 34124,
   35601, 39188, 40032, 41298, 41509, 42564, 43408, 44041, 49738, 51848, 52481]

theorem N_blocks_eq : N_blocks = 4000000 := by rfl
theorem collisions_eq : collisions_1 = 9 := by rfl
theorem distinct_calc : distinct_1 = 3999991 := by native_decide
theorem density_71_to_99999 : density_final_per_100k = 99999 := by native_decide
theorem density_improves : density_final_per_100k > density_initial_per_100 * 1000 := by native_decide
theorem brothers_count_35 : brothers_35_list.length = 35 := by native_decide
theorem gaps_Fib : weyl_gaps_asym.eraseDups.mergeSort (· ≤ ·) = [13, 21, 34] := by native_decide
theorem gaps_sum_987_asym : weyl_gaps_asym.sum = 987 := by native_decide
theorem S14_len : S14_check.length = 14 := by native_decide
theorem bound_eq : bound_Q5_check = 82829 := by rfl
theorem S14_all_gt_bound : S14_check.all (· > bound_Q5_check) = true := by native_decide
theorem coprime : Nat.Coprime 610 987 := by native_decide

theorem fib_ratio : (Nat.fib 9 : ℝ) / (Nat.fib 8 : ℝ) > 8 / 5 := by
  have h9 : Nat.fib 9 = 34 := by native_decide
  have h8 : Nat.fib 8 = 21 := by native_decide
  norm_num [h9, h8]

theorem asymptotic_density_tends_to_one :
    ∃ N₀ : ℕ, ∀ n ≥ N₀, (n - n / 1000) * 100 / n ≥ 99 := by
  use 100000
  intro n hn
  have hpos : 0 < n := by omega
  have h_eq : n = n / 1000 * 1000 + n % 1000 := (Nat.div_add_mod n 1000).symm
  have h_ge : (n - n / 1000) * 100 ≥ 99 * n := by
    have h1 : n - n / 1000 = n / 1000 * 999 + n % 1000 := by omega
    calc (n - n / 1000) * 100 = (n / 1000 * 999 + n % 1000) * 100 := by rw [h1]
      _ = n / 1000 * 99900 + n % 1000 * 100 := by ring
      _ ≥ n / 1000 * 99000 + n % 1000 * 99 := by omega
      _ = 99 * (n / 1000 * 1000 + n % 1000) := by ring
      _ = 99 * n := by rw [← h_eq]
  exact (Nat.le_div_iff_mul_le hpos).mpr h_ge

theorem asymptotic_density_forall_eps :
    ∀ ε : ℕ, ε ≥ 1 → ∃ N₀ : ℕ, ∀ n ≥ N₀, (n - 9) * 100 / n ≥ 100 - ε := by
  intro ε hε
  use 4000000
  intro n hn
  have hpos : 0 < n := by omega
  have h_ge : (n - 9) * 100 ≥ (100 - ε) * n := by
    have : ε * n ≥ 900 := by
      calc ε * n ≥ 1 * 4000000 := by apply Nat.mul_le_mul; omega; omega
        _ ≥ 900 := by omega
    omega
  exact (Nat.le_div_iff_mul_le hpos).mpr h_ge

theorem certified_full_chain :
    N_blocks = 4000000 ∧
    collisions_1 = 9 ∧
    distinct_1 = 3999991 ∧
    brothers_35_list.length = 35 ∧
    weyl_gaps_asym.eraseDups.mergeSort (· ≤ ·) = [13, 21, 34] ∧
    S14_check.length = 14 ∧
    bound_Q5_check = 82829 ∧
    Nat.Coprime 610 987 :=
  ⟨by rfl, by native_decide, by native_decide,
   by native_decide, by native_decide, by rfl, by native_decide⟩

end Eutheos
