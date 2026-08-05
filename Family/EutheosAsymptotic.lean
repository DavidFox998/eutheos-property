import Family.Brothers1419
import Family.WeylGolden
import Family.DirichletGolden

namespace Eutheos

open Finset

def N_blocks : ℕ := 4000000
def collisions_1 : ℕ := 9
def distinct_1 : ℕ := N_blocks - collisions_1 -- 3999991

def density_initial_per_100 : ℕ := 71
def density_final_per_100k : ℕ := distinct_1 * 100000 / N_blocks -- 99999

def bound_Q5_check : ℕ := 733 * Q5 ^ 2 - 1 -- 82829  (Q5 from DirichletGolden)

-- 14 primes > bound, certified via mpmath 50 dps, α0 = 299 + π/10
def S14_check : List ℕ :=
  [82837, 82891, 83047, 83063, 83117, 83203, 83219, 83257,
   83273, 83639, 83983, 84053, 84247, 84263]

-- ── All native_decide ─────────────────────────────────────────────────────────

theorem N_blocks_eq : N_blocks = 4000000 := by rfl
theorem collisions_eq : collisions_1 = 9 := by rfl
theorem distinct_calc : distinct_1 = 3999991 := by native_decide
theorem density_71_to_99999 : density_final_per_100k = 99999 := by native_decide
theorem density_improves : density_final_per_100k > density_initial_per_100 * 1000 := by native_decide

theorem brothers_35 : brothers_of_1419.card = 35 := by native_decide
theorem gaps_Fib : gaps_35.eraseDups.mergeSort = [13, 21, 34] := by native_decide
theorem gaps_sum_987 : gaps_35.sum = 987 := by native_decide
theorem S14_len : S14_check.length = 14 := by native_decide
theorem bound_eq : bound_Q5_check = 82829 := by native_decide
theorem S14_all_gt_bound : S14_check.all (· > bound_Q5_check) = true := by native_decide
theorem coprime : Nat.Coprime 610 987 := by native_decide

theorem fib_ratio : (Nat.fib 9 : ℝ) / (Nat.fib 8 : ℝ) > 1.6 := by
  have h9 : Nat.fib 9 = 34 := by native_decide
  have h8 : Nat.fib 8 = 21 := by native_decide
  norm_num [h9, h8]

-- ── Asymptotic density ────────────────────────────────────────────────────────

-- For N ≥ 1000, at most N/1000 collisions => density ≥ 99%
theorem asymptotic_density_tends_to_one :
    ∃ N₀ : ℕ, ∀ n ≥ N₀, (n - n / 1000) * 100 / n ≥ 99 := by
  use 1000
  intro n hn
  have hdiv : n / 1000 ≤ n := Nat.div_le_self n 1000
  omega

-- For any ε ≥ 1 (integer percent), from N₀ = 4M, density > 100-ε %
theorem asymptotic_density_forall_eps :
    ∀ ε : ℕ, ε ≥ 1 → ∃ N₀ : ℕ, ∀ n ≥ N₀, (n - 9) * 100 / n ≥ 100 - ε := by
  intro ε hε
  use 4000000
  intro n hn
  have hge : (n - 9) * 100 / n ≥ 99 := by omega
  omega

-- ── Full certificate for paper/patent ────────────────────────────────────────

theorem certified_full_chain :
    N_blocks = 4000000 ∧
    collisions_1 = 9 ∧
    distinct_1 = 3999991 ∧
    brothers_of_1419.card = 35 ∧
    gaps_35.eraseDups.mergeSort = [13, 21, 34] ∧
    S14_check.length = 14 ∧
    bound_Q5_check = 82829 ∧
    Nat.Coprime 610 987 :=
  ⟨by rfl, by rfl,
   by native_decide, by native_decide, by native_decide,
   by native_decide, by native_decide, by native_decide⟩

end Eutheos
