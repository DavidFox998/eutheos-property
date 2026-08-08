import Mathlib.Data.Real.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Tactic.NormNum

namespace Eutheos

/-! # Family.H4Tower -/

def α2_num : ℕ := 1597
def α2_den : ℕ := 2584

def H4_56_points : List ℕ :=
  [0, 34, 89, 123, 178, 233, 267, 322, 356, 411, 466, 500, 555, 610, 644, 699,
   733, 788, 843, 877, 932, 966, 1021, 1076, 1110, 1165, 1220, 1254, 1309, 1343,
   1398, 1453, 1487, 1542, 1597, 1631, 1686, 1720, 1775, 1830, 1864, 1919, 1953,
   2008, 2063, 2097, 2152, 2207, 2241, 2296, 2330, 2385, 2440, 2474, 2529, 2563]

def H4_90_points : List ℕ :=
  [0, 13, 34, 68, 89, 123, 157, 178, 212, 233, 267, 301, 322, 356, 390, 411,
   445, 466, 500, 534, 555, 589, 610, 644, 678, 699, 733, 767, 788, 822, 843,
   877, 911, 932, 966, 1000, 1021, 1055, 1076, 1110, 1144, 1165, 1199, 1220,
   1254, 1288, 1309, 1343, 1377, 1398, 1432, 1453, 1487, 1521, 1542, 1576, 1597,
   1631, 1665, 1686, 1720, 1754, 1775, 1809, 1830, 1864, 1898, 1919, 1953, 1987,
   2008, 2042, 2063, 2097, 2131, 2152, 2186, 2207, 2241, 2275, 2296, 2330, 2364,
   2385, 2419, 2440, 2474, 2508, 2529, 2563]

def H4_146_points : List ℕ :=
  [0, 13, 34, 47, 68, 89, 102, 123, 136, 157, 178, 191, 212, 233, 246, 267, 280,
   301, 322, 335, 356, 369, 390, 411, 424, 445, 466, 479, 500, 513, 534, 555,
   568, 589, 610, 623, 644, 657, 678, 699, 712, 733, 746, 767, 788, 801, 822,
   843, 856, 877, 890, 911, 932, 945, 966, 979, 1000, 1021, 1034, 1055, 1076,
   1089, 1110, 1123, 1144, 1165, 1178, 1199, 1220, 1233, 1254, 1267, 1288, 1309,
   1322, 1343, 1356, 1377, 1398, 1411, 1432, 1453, 1466, 1487, 1500, 1521, 1542,
   1555, 1576, 1589, 1597, 1610, 1631, 1644, 1665, 1686, 1699, 1720, 1733, 1754,
   1775, 1788, 1809, 1830, 1843, 1864, 1877, 1898, 1919, 1932, 1953, 1966, 1987,
   2008, 2021, 2042, 2063, 2076, 2097, 2110, 2131, 2152, 2165, 2186, 2207, 2220,
   2241, 2254, 2275, 2296, 2309, 2330, 2343, 2364, 2385, 2398, 2419, 2440, 2453,
   2474, 2487, 2508, 2529, 2542, 2563, 2576]

def weyl_gaps_of (pts : List ℕ) (den : ℕ) : List ℕ :=
  let s := pts.mergeSort (· ≤ ·)
  let rec go : List ℕ → List ℕ
    | []          => []
    | [_]         => []
    | a :: b :: t => (b - a) :: go (b :: t)
  go s ++ [den - s.getLastD 0 + s.headD 0]

theorem H4_56_count : H4_56_points.length = 56 := by native_decide
theorem H4_56_gaps : (weyl_gaps_of H4_56_points α2_den).eraseDups.mergeSort = [21, 34, 55] := by native_decide
theorem H4_56_sum  : (weyl_gaps_of H4_56_points α2_den).sum = 2584 := by native_decide

theorem H4_90_count : H4_90_points.length = 90 := by native_decide
theorem H4_90_gaps : (weyl_gaps_of H4_90_points α2_den).eraseDups.mergeSort = [13, 21, 34] := by native_decide
theorem H4_90_sum  : (weyl_gaps_of H4_90_points α2_den).sum = 2584 := by native_decide

theorem H4_146_count : H4_146_points.length = 146 := by native_decide
theorem H4_146_gaps : (weyl_gaps_of H4_146_points α2_den).eraseDups.mergeSort = [8, 13, 21] := by native_decide
theorem H4_146_sum  : (weyl_gaps_of H4_146_points α2_den).sum = 2584 := by native_decide

theorem tower_inflation_56_90  : (90:ℝ)/(56:ℝ) > (8:ℝ)/(5:ℝ) ∧ (90:ℝ)/(56:ℝ) < (17:ℝ)/(10:ℝ) := by
  constructor <;> norm_num
theorem tower_inflation_90_146 : (146:ℝ)/(90:ℝ) > (8:ℝ)/(5:ℝ) ∧ (146:ℝ)/(90:ℝ) < (17:ℝ)/(10:ℝ) := by
  constructor <;> norm_num

def H4_600cell_vertices : ℕ := 120

theorem H4_56_relation_600cell :
    H4_56_points.length * 2 + 8 = H4_600cell_vertices := by native_decide

theorem density_tower_56  : (9:ℝ) / (4000000:ℝ) ^ (56:ℕ) < 1 / (10:ℝ) ^ (300:ℕ) := by norm_num
theorem density_tower_90  : (9:ℝ) / (4000000:ℝ) ^ (90:ℕ) < 1 / (10:ℝ) ^ (300:ℕ) := by norm_num
theorem density_tower_146 : (9:ℝ) / (4000000:ℝ) ^ (146:ℕ) < 1 / (10:ℝ) ^ (300:ℕ) := by norm_num

theorem H4_tower_certified :
    H4_56_points.length = 56 ∧
    (weyl_gaps_of H4_56_points α2_den).eraseDups.mergeSort = [21, 34, 55] ∧
    H4_90_points.length = 90 ∧
    (weyl_gaps_of H4_90_points α2_den).eraseDups.mergeSort = [13, 21, 34] ∧
    H4_146_points.length = 146 ∧
    (weyl_gaps_of H4_146_points α2_den).eraseDups.mergeSort = [8, 13, 21] :=
  ⟨by native_decide, by native_decide,
   by native_decide, by native_decide,
   by native_decide, by native_decide⟩

end Eutheos
