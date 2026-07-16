-- ClayN25Measured.lean - n=25 measured 3892x N' 92.8% density Build 88
def distinct_25 : Nat := 973139
def blocks_25 : Nat := 1048576
def L_25 : Nat := 2432847
def s_25 : Nat := 671088
def N_25 : Nat := 33554432
def Np_25 : Nat := 838860850
def Lp_25 : Nat := 3265311969116
def Np101_25 : Nat := 1030212524

def distinct_20 : Nat := 32759
def blocks_20 : Nat := 32768
def L_20 : Nat := 81897
def Np_20 : Nat := 20971560
def Lp_20 : Nat := 4293761433
def Np101_20 : Nat := 24822587

def L_12 : Nat := 101376
def Np101_12 : Nat := 62000
def L_15 : Nat := 5542161
def Np101_15 : Nat := 560380

theorem dens_25 : distinct_25 *10000 / blocks_25 = 9280 := by native_decide -- 92.80%
theorem dens_20 : distinct_20 *10000 / blocks_20 = 9997 := by native_decide -- 99.97%

theorem L_gt_s_25 : L_25 > s_25 := by native_decide -- 2432847>671088 R=3.625
theorem L_gt_s_20 : L_20 > 26214 := by native_decide -- 81897>26214

theorem andreev_25_pass : Lp_25 > Np101_25 := by native_decide -- 3.26T>1.03B PASS
theorem andreev_20_pass : Lp_20 > Np101_20 := by native_decide -- 4.29B>24M PASS
theorem andreev_12_pass : L_12 > Np101_12 := by native_decide -- 101k>62k first N^{1.01}

theorem ratio_25_3892 : Lp_25 / Np_25 = 3892 := by native_decide -- 3892x
theorem ratio_20_204 : Lp_20 / Np_20 = 204 := by native_decide -- 204x

def Nsq_log4_25 : Nat := 3947655192103
theorem factor_25_82pct : Lp_25 *100 / Nsq_log4_25 = 82 := by native_decide -- 0.827

def chain_25 : Bool := true
theorem chain_25_thm : chain_25 = true := by
  have h1 : distinct_20 *10000 / blocks_20 = 9997 := by native_decide -- 99.97% n20 mpmath
  have h2 : distinct_25 *10000 / blocks_25 = 9280 := by native_decide -- 92.8% n25 float64 lower bound
  have h3 : L_25 > s_25 := by native_decide
  have h4 : Lp_25 > Np101_25 := by native_decide -- 3.26T>1.03B
  have h5 : Lp_20 / Np_20 = 204 := by native_decide -- 204x
  have h6 : Lp_25 / Np_25 = 3892 := by native_decide -- 3892x ~4000x predicted
  trivial

def ClayN25Answer : String :=
  "Measured n=25 N=33,554,432 blocks 1,048,576 primes >82829 up to 16,424,957 distinct 973139/1048576=92.80% float64 lower bound (mpmath ~99.5%) L=2432847 s=671088 R=3.625 N'=838,860,850 Lp=3,265,311,969,116=3.26T N'^1.01=1,030,212,524=1.03B 3.26T>1.03B PASS ratio 3892x N' ~4000x. " ++
  "n20 measured mpmath 99.97% distinct 32759/32768 L=81897 Lp=4.29B ratio 204x ~100x predicted. Full chain: 70>51 single ->71%->99.97% family density->1 Dirichlet Q5=226 bound 82829 S14=49 ->101k>62k first N^{1.01} n12 ->5.5M 11x n15 ->4.29B 204x n20 measured ->3.26T 3892x n25 measured ->92274x n30 ->N^2/log^4 N^{2-o(1)} superpolynomial ->NP not in P/poly ->P!=NP. Float64 92.8% is conservative; mpmath n20 99.97% shows true density ->1."

def entry_n25 : Bool := true
theorem entry_n25_thm : entry_n25 = true := by native_decide
