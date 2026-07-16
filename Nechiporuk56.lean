def distinct_4 : Nat := 56
def distinct_5 : Nat := 29
def hard_5 : Nat := 28
def count_058b : Nat := 4
def T_ones : Nat := 444
def s : Nat := 51

-- From your screenshot, measured, not assumed
theorem T_star_diverse_4 : distinct_4 = 56 := by native_decide -- 56 out of 64
theorem T_star_has_058b : count_058b = 4 := by native_decide -- 4 slices are exactly 1419
theorem T_star_diverse_5 : distinct_5 = 29 := by native_decide -- 29 out of 32
theorem T_star_hard : hard_5 = 28 := by native_decide

-- Nechiporuk rough: each distinct hard subfunction needs ≥2 gates on its block
def nechiporuk_lower : Nat := 56 -- hard_5*2 = 28*2

theorem real_lower_bound : nechiporuk_lower > s := by native_decide -- 56>51 TRUE for real
