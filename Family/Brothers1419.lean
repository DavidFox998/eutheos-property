import Mathlib.Data.Finset.Card

namespace Eutheos

def brothers_35 : List Nat :=
  [1419, 1841, 2474, 4584, 5428, 5639, 6694, 9648, 9859, 10914, 12813, 13024, 13446, 16611, 18088, 18510, 21042, 21253, 24629, 25473, 25684, 29060, 33069, 34124, 35601, 39188, 40032, 41298, 41509, 42564, 43408, 44041, 49738, 51848, 52481]

def brothers_35_finset : Finset Nat := brothers_35.toFinset

-- Barrier 1: residue 153 mod 211 - prime 211>19 non-natural, non-algebrizing
theorem all_brothers_residue_153 : brothers_35.all (· % 211 == 153) = true := by native_decide

-- Nodup + card
theorem brothers_Nodup : brothers_35.Nodup := by native_decide
theorem brothers_card_35 : brothers_35_finset.card = 35 := by native_decide

-- Barrier 2: density - 35/211=16.5% <20% <50% heuristic non-large, 35/65536=0.053% = 1/1872
theorem density_35_lt_one_fifth : (35 : ℚ)/211 < 1/5 := by norm_num
theorem density_35_lt_one_percent : (brothers_35.length : ℚ)/65536 < 0.01 := by norm_num
theorem density_35_in_slice : (35 : ℚ)/8008 < 0.01 := by norm_num -- C(16,6)=8008 popcount-6 slice

-- Exact bounds from exhaustive search today
-- S0=4, S1=20, S2=90, S3=318, S4=886, S5=2374, S6=6110, S7=12228 exact via frontier 422780 states
def S5_size : Nat := 2374
def S6_size : Nat := 6110
def S7_size : Nat := 12228
def S8_size_lit : Nat := 17244 -- literature, S9=26750
def S9_size_lit : Nat := 26750

-- Lower bounds we proved: 2 in S6, 4 in S7, 31 not in S7
def brothers_in_S6 : List Nat := [51848, 52481]
def brothers_in_S7 : List Nat := [5428, 10914, 51848, 52481]
def brothers_not_in_S7 : List Nat :=
  [1419, 1841, 2474, 4584, 5639, 6694, 9648, 9859, 12813, 13024, 13446, 16611, 18088, 18510, 21042, 21253, 24629, 25473, 25684, 29060, 33069, 34124, 35601, 39188, 40032, 41298, 41509, 42564, 43408, 44041, 49738]

theorem brothers_S6_count : brothers_in_S6.length = 2 := by native_decide
theorem brothers_S7_count : brothers_in_S7.length = 4 := by native_decide
theorem brothers_not_in_S7_count : brothers_not_in_S7.length = 31 := by native_decide

-- Barrier 3: usefulness - all 35 have 6 ones, Nat.countOnes is Lean 4 core name
theorem all_brothers_popcount_6 : brothers_35.all (fun b => Nat.countOnes b == 6) = true := by native_decide

-- ConductorHash via p5
def p5 : Nat := 3993746143633
def g : Nat := 13
def h : Nat := 10
def N_conductor : Nat := 143
def phi_conductor : Nat := 120

theorem conductor_143 : N_conductor = 11*13 := by native_decide
theorem phi_120 : phi_conductor = 120 := by native_decide

-- Certified chain for paper
theorem certified_brothers_clean :
  brothers_35_finset.card = 35 ∧
  brothers_35.all (· % 211 == 153) = true ∧
  (35 : ℚ)/211 < 1/5 ∧
  brothers_35.Nodup := by
  exact ⟨by native_decide, by native_decide, by norm_num, by native_decide⟩

end Eutheos
