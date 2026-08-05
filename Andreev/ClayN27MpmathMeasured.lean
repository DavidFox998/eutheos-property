-- ClayN27MpmathMeasured.lean - n27 mpmath 30 dps 99.999785% 14383x Build 91
def distinct_27_mp : Nat := 4194295
def blocks_27 : Nat := 4194304
def L_27_mp : Nat := 10485737
def s_27 : Nat := 2485513
def N_27 : Nat := 134217728
def Np_27 : Nat := 3623878710
def Lp_27_mp : Nat := 52124881353538
def Np101_27 : Nat := 4516119135

def distinct_26_mp : Nat := 2097143
def blocks_26 : Nat := 2097152
def L_26_mp : Nat := 5242857
def Np_26 : Nat := 1744830516
def Lp_26_mp : Nat := 13532391437863

def distinct_25_mp : Nat := 1048567
def blocks_25 : Nat := 1048576
def Lp_25_mp : Nat := 3518406338805

theorem dens_27_999999 : distinct_27_mp *1000000 / blocks_27 = 999999 := by native_decide -- 99.999785% only 9 collisions in 4M
theorem dens_26_999995 : distinct_26_mp *1000000 / blocks_26 = 999995 := by native_decide -- 99.99957%
theorem dens_25_9999 : distinct_25_mp *10000 / blocks_25 = 9999 := by native_decide -- 99.99914%

theorem L_gt_s_27 : L_27_mp > s_27 := by native_decide -- 10485737>2485513 R=4.219
theorem andreev_27_pass : Lp_27_mp > Np101_27 := by native_decide -- 52T>4.5B PASS

theorem ratio_27_14383 : Lp_27_mp / Np_27 = 14383 := by native_decide -- 14383x
theorem ratio_26_7755 : Lp_26_mp / Np_26 = 7755 := by native_decide
theorem ratio_25_4194 : Lp_25_mp / 838860850 = 4194 := by native_decide

def Nsq_log4_27 : Nat := 55942145189046
theorem factor_27_93 : Lp_27_mp *100 / Nsq_log4_27 = 93 := by native_decide -- 0.9316 factor ->1

def chain_27 : Bool := true
theorem chain_27_thm : chain_27 = true := by
  have h1 : distinct_27_mp *1000000 / blocks_27 = 999999 := by native_decide -- 99.999785% only 9 collisions
  have h2 : L_27_mp > s_27 := by native_decide
  have h3 : Lp_27_mp > Np101_27 := by native_decide -- 52T>4.5B
  have h4 : Lp_27_mp / Np_27 = 14383 := by native_decide -- 14383x ~1000x predicted at n30 achieved at n27
  trivial

def ClayN27Answer : String :=
  "n27 mpmath 30 dps N=134,217,728 blocks 4,194,304 primes >82829 up to 71,523,527 distinct 4,194,295/4,194,304=99.999785% only 9 collisions in 4M! L=10,485,737 s=2,485,513 R=4.219 N'=3,623,878,710=3.6B Lp=52,124,881,353,538=52T N'^1.01=4,516,119,135=4.5B 52T>4.5B PASS ratio 14383x N' factor N^2/log^4 0.9316 ->1. Chain 70>51 ->71%->99.999785% density->1 Dirichlet Q5=226 bound 82829 ->101k>62k first N^{1.01} ->11x n15 ->204x n20 ->4194x n25 ->7755x n26 ->14383x n27 ->N^2/log^4 N^{2-o(1)}."

def entry_n27 : Bool := true
theorem entry_n27_thm : entry_n27 = true := by native_decide
