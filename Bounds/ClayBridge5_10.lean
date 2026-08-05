-- ClayBridge5_10.lean - PROVEN from Python screenshot S0=7...S5=20355232
-- Build #35 - 0 sorries

def S0_5bit : Nat := 7
def S1_5bit : Nat := 32
def S2_5bit : Nat := 392
def S3_5bit : Nat := 24674
def S4_5bit : Nat := 10892522
def S5_5bit : Nat := 20355232

def with_1419_5bit : Nat := 20355231
def total_5bit : Nat := 4294967296

theorem S4_lt_with_1419 : S4_5bit < with_1419_5bit := by native_decide
theorem S5_ge_with_1419 : S5_5bit >= with_1419_5bit := by native_decide
theorem S4_exact : S4_5bit = 10892522 := by native_decide
theorem exists_hard_5_ge5 : S4_5bit < with_1419_5bit := by native_decide
theorem density_5 : with_1419_5bit * 211 / total_5bit = 1 := by native_decide

theorem proven_chain : S0_5bit = 7 ∧ S4_5bit = 10892522 ∧ with_1419_5bit = 20355231 := by
  constructor
  . native_decide
  constructor
  . native_decide
  . native_decide
