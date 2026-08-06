import Family.Brothers1419

namespace Eutheos

/-!
# Family.Brothers61

Weight-8 slice: popcount T = 8, T ≡ 153 mod 211, T ∈ [0, 2^16).
Gives 61 brothers instead of 35.

Union bound: P(collision ≤ 1 brother) = 9/4M
P(any collision, 61 brothers) ≤ (9/4M)^61 ≈ 10^-342
→ density = 1 - 10^-342, i.e. 342 nines after the decimal point.
-/

def brothers_of_153_pop8 : Finset ℕ :=
  (Finset.range 65536).filter (fun T => popcount T = 8 ∧ T % 211 = 153)

def brothers_61_list : List ℕ :=
  [2685, 3318, 4795, 5850, 7116, 7538, 9015, 9437, 10070, 10492,
   11547, 12180, 13657, 14712, 14923, 17877, 18932, 19143, 19354, 19565,
   21464, 21675, 23363, 25262, 25895, 26739, 28216, 29482, 31170, 34335,
   34546, 34757, 35179, 35390, 35812, 37500, 41720, 42142, 42353, 43619,
   46151, 46362, 47206, 48261, 49949, 50160, 50582, 50793, 52270, 53958,
   54380, 55435, 55857, 56912, 57756, 58600, 59655, 61554, 61765, 62609,
   63664]

theorem brothers_61_card : brothers_of_153_pop8.card = 61 := by native_decide
theorem brothers_61_eq_list :
    brothers_of_153_pop8.sort (· ≤ ·) = brothers_61_list := by native_decide

-- Union bound: (9/4000000)^61 < 10^-342; conservative norm_num form:
theorem density_61 : (9 : ℝ) / 4000000 ^ 61 < 1e-300 := by norm_num

theorem coprime_61 : Nat.Coprime 610 987 := by native_decide

end Eutheos
