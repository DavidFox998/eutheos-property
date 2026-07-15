import Mathlib
import John_6_Three_Miracles_SelfContained

/-!
# SearchSmall - brute force search for Eutheos property in small Boolean functions
# This is where combinator results come from: finite search + decide
-/

namespace SearchSmall

open John6_ThreeMiracles_SelfContained

-- Truth table as Nat: for n=3, 8 bits; n=4, 16 bits; etc.
-- Eutheos pattern: tt encodes 1419 or tt-786 divisible by 211 (large prime)

def HasEutheosPattern (tt : Nat) : Bool :=
  (tt == 1419) || (decide (tt > BISMILLAH) && decide ((tt - BISMILLAH) % 211 == 0))

-- For small n, we search tt in range [0, 2^(2^n) -1]

def countEutheos_n3 : Nat :=
  (List.range 256).filter (fun tt => HasEutheosPattern tt) |>.length

def countEutheos_n4 : Nat :=
  (List.range 65536).filter (fun tt => HasEutheosPattern tt) |>.length

-- Compute with native_decide to avoid slow kernel

theorem n3_count : countEutheos_n3 = 0 := by native_decide

theorem n4_count : countEutheos_n4 = 304 := by native_decide

-- So for n=3, NO function has Eutheos pattern (1419 too big)
-- For n=4, 304 functions have it (since 2^16 = 65536 covers 1419 and numbers 786+211*k)

-- Existence proof for n=4
theorem exists_n4_eutheos : ∃ tt ∈ List.range 65536, HasEutheosPattern tt = true := by
  use 1419
  constructor
  · native_decide
  · native_decide

-- The 211 chain
theorem eutheos_211_chain : (1419 - 786) % 211 = 0 := by native_decide

theorem eutheos_div_211 : (1419 - 786) / 211 = 3 := by native_decide

-- Circuit size lower bound idea: any function with tt = 1419 has at least ? gates
-- For 4-bit functions, worst case needs 5 gates, best case 1
-- We can start with a trivial lower bound: tt != 0 and tt != 2^(2^n)-1 needs >=1 gate

def IsConstant (tt n : Nat) : Bool :=
  (tt == 0) || (tt == 2^(2^n) - 1)

theorem eutheos_not_constant_n4 : IsConstant 1419 4 = false := by native_decide

-- So 1419 needs at least 1 gate - trivial but machine-checked
-- Real h_useful needs to show it needs superpoly gates for general n

-- First step toward h_useful: define minimal gates needed (toy)
-- For this file we prove the combinator can find candidates automatically

def candidates_n4 : List Nat :=
  (List.range 65536).filter (fun tt => HasEutheosPattern tt)

theorem candidates_n4_has_1419 : 1419 ∈ candidates_n4 := by native_decide

theorem candidates_n4_length : candidates_n4.length = 304 := by native_decide

-- Next: try to prove any tt in candidates_n4 needs >2 gates
-- This is where we will build the real h_useful
-- For now we leave it as a search target

def needsMoreThan2Gates (tt : Nat) : Bool := true -- placeholder, to be refined with actual circuit enumeration

-- Combinator result for n=4 toy
theorem toy_combinator_n4 :
  ∃ tt ∈ candidates_n4, needsMoreThan2Gates tt = true := by
  use 1419
  constructor
  · exact candidates_n4_has_1419
  · rfl

#print axioms n3_count
#print axioms n4_count
#print axioms exists_n4_eutheos
#print axioms toy_combinator_n4

end SearchSmall
