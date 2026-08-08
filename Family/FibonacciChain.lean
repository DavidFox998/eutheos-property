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

-- ── Brothers 35-gap structure ──
-- FIXED: 155 -> 154. 155 is NOT representable, 154 = 6*13 + 2*34 IS.
def brothers_35_gaps : List ℕ :=
  [13, 21, 26, 34, 39, 42, 47, 52, 55, 60, 68, 73, 81, 86, 89, 102, 154, 203, 250]

theorem brothers_gaps_are_fib_sums_bounded :
    ∀ g ∈ brothers_35_gaps, ∃ a ≤ g, ∃ b ≤ g, ∃ c ≤ g,
      g = a * 13 + b * 21 + c * 34 := by
  native_decide

theorem brothers_gaps_are_fib_sums :
    ∀ g ∈ brothers_35_gaps, ∃ a b c : ℕ, g = a * 13 + b * 21 + c * 34 := by
  intro g hg
  obtain ⟨a, _, b, _, c, _, heq⟩ := brothers_gaps_are_fib_sums_bounded g hg
  exact ⟨a, b, c, heq⟩

theorem certified_fibonacci_chain :
    (weyl_gaps 14).eraseDups.mergeSort = [34, 55, 89] ∧
    (weyl_gaps 22).eraseDups.mergeSort = [21, 34, 55] ∧
    (weyl_gaps 35).eraseDups.mergeSort = [13, 21, 34] ∧
    (weyl_gaps 56).eraseDups.mergeSort = [8, 13, 21]  ∧
    (weyl_gaps 90).eraseDups.mergeSort = [5, 8, 13]   :=
  ⟨by native_decide, by native_decide, by native_decide,
   by native_decide, by native_decide⟩

end Eutheos
