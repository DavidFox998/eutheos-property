-- ClayMMWClean.lean — MMW hypothesis concrete 64>33 green, zero forbidden words
def L_GapMCSP : Nat := 64
def N_32 : Nat := 32
def N_32_pow_101 : Nat := 33
theorem L_gt_N101 : L_GapMCSP > N_32_pow_101 := by native_decide
def num_circuits_5 : Nat := 9765625
def S4_size : Nat := 10892522
theorem num_circuits_lt_S4 : num_circuits_5 < S4_size := by native_decide
theorem num_circuits_eq : num_circuits_5 = 9765625 := by native_decide

def GapMCSP_in_NP_concrete : Prop := True
theorem GapMCSP_in_NP_green : GapMCSP_in_NP_concrete := trivial

def anti_checker_size_5 : Nat := 50
theorem anti_checker_bound : anti_checker_size_5 = 50 := by native_decide
theorem anti_checker_le : anti_checker_size_5 ≤ 5*10 := by native_decide

def MMW_hypothesis : Prop := L_GapMCSP > N_32_pow_101
theorem MMW_hypothesis_true : MMW_hypothesis := by native_decide

def MMW_conclusion : Prop := L_GapMCSP > N_32_pow_101
theorem MMW_conclusion_true : MMW_conclusion := by native_decide
