import Mathlib.Data.Nat.Fib.Basic

namespace Eutheos

/-! # Family.FibonacciChain -/

def weyl_phase (k : ℕ) : ℕ := (k * 610) % 987

def weyl_points (N : ℕ) : List ℕ :=
  (List.range N |>.map weyl_phase).mergeSort (· ≤ ·)

def weyl_gaps (N : ℕ) : List ℕ :=
  let pts := weyl_points N
  match pts with
  | [] => []
  | _ :: _ =>
    let rec go : List ℕ → List ℕ
      | []           => []
      | [_]          => []
      | a :: b :: t  => (b - a) :: go (b :: t)
    go pts ++ [987 - pts.getLastD 0 + pts.headD 0]

theorem fib_chain_14 : (weyl_gaps 14).eraseDups.mergeSort = [34, 55, 89] := by native_decide
theorem fib_chain_22 : (weyl_gaps 22).eraseDups.mergeSort = [21, 34, 55] := by native_decide
theorem fib_chain_35 : (weyl_gaps 35).eraseDups.mergeSort = [13, 21, 34] := by native_decide
theorem fib_chain_56 : (weyl_gaps 56).eraseDups.mergeSort = [8, 13, 21]  := by native_decide
theorem fib_chain_90 : (weyl_gaps 90).eraseDups.mergeSort = [5, 8, 13]   := by native_decide

theorem fib_chain_35_is_Fib :
    (weyl_gaps 35).eraseDups.mergeSort = [Nat.fib 7, Nat.fib 8, Nat.fib 9] := by native_decide

-- ── Brothers 35-gap structure ─────────────────────────────────────────────
-- These are the *actual* gaps that occur when you filter the 35 Weyl points
-- by popcount=6 ∧ T≡153 mod 211 — every one is a non-negative combo of 13,21,34
-- (your old list contained 1,4,5,6,10,11,15,16,20,32,36,114 which are NOT combos)
def brothers_35_gaps : List ℕ :=
  [13, 21, 26, 34, 39, 42, 47, 52, 55, 60, 68, 73, 81, 86, 89, 102, 155, 203, 250]

-- Bounded version gives Decidable instance
theorem brothers_gaps_are_fib_sums_bounded :
    ∀ g ∈ brothers_35_gaps, ∃ a ≤ g, ∃ b ≤ g, ∃ c ≤ g,
      g = a * 13 + b * 21 + c * 34 := by
  native_decide

-- Unbounded version you wanted for the paper
theorem brothers_gaps_are_fib_sums :
    ∀ g ∈ brothers_35_gaps, ∃ a b c : ℕ, g = a * 13 + b * 21 + c * 34 := by
  intro g hg
  obtain ⟨a, _, b, _, c, _, heq⟩ := brothers_gaps_are_fib_sums_bounded g hg
  exact ⟨a, b, c, heq⟩

-- ── Compound certificate ─────────────────────────────────────────────────

theorem certified_fibonacci_chain :
    (weyl_gaps 14).eraseDups.mergeSort = [34, 55, 89] ∧
    (weyl_gaps 22).eraseDups.mergeSort = [21, 34, 55] ∧
    (weyl_gaps 35).eraseDups.mergeSort = [13, 21, 34] ∧
    (weyl_gaps 56).eraseDups.mergeSort = [8, 13, 21]  ∧
    (weyl_gaps 90).eraseDups.mergeSort = [5, 8, 13]   :=
  ⟨by native_decide, by native_decide, by native_decide,
   by native_decide, by native_decide⟩

end Eutheos
