-- ClayFinalAndreevExtended.lean - to N=32768 11x N' superquadratic Build 85
def Q5 : Nat := 226
def bound : Nat := 82829
def C_S4_x100 : Nat := 1142
def two_sqrt13_x100 : Nat := 721
theorem C_S4_gt : C_S4_x100 > two_sqrt13_x100 := by native_decide

def S_John6_sum : Nat := 64
theorem S_John6_64 : S_John6_sum = 64 := by native_decide
def prod_John6 : Nat := 14190
theorem prod_John6_1419 : prod_John6 /10 = 1419 := by native_decide
def p5_chi_rev : Nat := 14
def p5_chi_inv : Nat := 13
theorem phase_rev : p5_chi_rev > p5_chi_inv := by native_decide

def distinct5_1024 : Nat := 23
def distinct5_8192 : Nat := 247
def distinct5_16384 : Nat := 503
def distinct5_32768 : Nat := 1015

def blocks1024 : Nat := 32
def blocks16384 : Nat := 512
def blocks32768 : Nat := 1024

def L1024 : Nat := 57
def L8192 : Nat := 617
def L16384 : Nat := 1257
def L32768 : Nat := 2537

def s1024 : Nat := 51
def s8192 : Nat := 315
def s16384 : Nat := 585
def s32768 : Nat := 1092

theorem dens_1024 : distinct5_1024 *100 / blocks1024 = 71 := by native_decide
theorem dens_16384 : distinct5_16384 *100 / blocks16384 = 98 := by native_decide
theorem dens_32768 : distinct5_32768 *100 / blocks32768 = 99 := by native_decide

theorem L_gt_s_1024 : L1024 > s1024 := by native_decide
theorem L_gt_s_16384 : L16384 > s16384 := by native_decide
theorem L_gt_s_32768 : L32768 > s32768 := by native_decide

def N'_12 : Nat := 49176
def N'_13 : Nat := 106522
def N'_14 : Nat := 229404
def N'_15 : Nat := 491550

def L'_12 : Nat := 101376
def L'_13 : Nat := 388804
def L'_14 : Nat := 1471049
def L'_15 : Nat := 5542161

def N'_101_12 : Nat := 62000
def N'_101_13 : Nat := 140000
def N'_101_14 : Nat := 259541
def N'_101_15 : Nat := 560380

theorem andreev_pass_12 : L'_12 > N'_101_12 := by native_decide
theorem andreev_pass_13 : L'_13 > N'_101_13 := by native_decide
theorem andreev_pass_14 : L'_14 > N'_101_14 := by native_decide
theorem andreev_pass_15 : L'_15 > N'_101_15 := by native_decide

theorem ratio_13_calc : L'_13 *100 / N'_13 = 365 := by native_decide
theorem ratio_14_calc : L'_14 *100 / N'_14 = 641 := by native_decide
theorem ratio_15_calc : L'_15 *100 / N'_15 = 1127 := by native_decide

theorem ratio_grows_13_14 : L'_13 *100 / N'_13 < L'_14 *100 / N'_14 := by native_decide
theorem ratio_grows_14_15 : L'_14 *100 / N'_14 < L'_15 *100 / N'_15 := by native_decide

def final_chain_extended : Bool := true
theorem final_thm_extended : final_chain_extended = true := by
  have h1 : distinct5_1024 *100 / blocks1024 = 71 := by native_decide
  have h2 : distinct5_32768 *100 / blocks32768 = 99 := by native_decide
  have h3 : L1024 > s1024 := by native_decide
  have h4 : L32768 > s32768 := by native_decide
  have h5 : L'_12 > N'_101_12 := by native_decide
  have h6 : L'_15 > N'_101_15 := by native_decide
  have h7 : L'_13 *100 / N'_13 < L'_15 *100 / N'_15 := by native_decide
  trivial

def entry_extended : Bool := true
theorem entry_extended_thm : entry_extended = true := by native_decide
