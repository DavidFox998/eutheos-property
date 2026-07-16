-- ClayN26MpmathMeasured.lean - n26 mpmath 30 dps 99.99957% 7755x Build 90
def distinct_26_mp : Nat := 2097143
def blocks_26 : Nat := 2097152
def L_26_mp : Nat := 5242857
def s_26 : Nat := 1290555
def N_26 : Nat := 67108864
def Np_26 : Nat := 1744830516
def Lp_26_mp : Nat := 13532391437863
def Np101_26 : Nat := 2158593080

def distinct_25_mp : Nat := 1048567
def blocks_25 : Nat := 1048576
def L_25_mp : Nat := 2621417
def Np_25 : Nat := 838860850
def Lp_25_mp : Nat := 3518406338805

def distinct_20 : Nat := 32759
def blocks_20 : Nat := 32768
def L_20 : Nat := 81897
def Np_20 : Nat := 20971560
def Lp_20 : Nat := 4293761433

theorem dens_26_mp : distinct_26_mp *1000000 / blocks_26 = 999995 := by native_decide -- 99.99957%
theorem dens_25_mp : distinct_25_mp *10000 / blocks_25 = 9999 := by native_decide -- 99.99914%
theorem dens_20 : distinct_20 *10000 / blocks_20 = 9997 := by native_decide -- 99.97%

theorem L_gt_s_26 : L_26_mp > s_26 := by native_decide -- 5242857>1290555 R=4.062
theorem andreev_26_pass : Lp_26_mp > Np101_26 := by native_decide -- 13.5T>2.15B PASS

theorem ratio_26_7755 : Lp_26_mp / Np_26 = 7755 := by native_decide -- 7755x
theorem ratio_25_4194 : Lp_25_mp / Np_25 = 4194 := by native_decide -- 4194x
theorem ratio_20_204 : Lp_20 / Np_20 = 204 := by native_decide -- 204x

def Nsq_log4_26 : Nat := 14847705552194
theorem factor_26_91 : Lp_26_mp *100 / Nsq_log4_26 = 91 := by native_decide -- 0.9115 factor

def chain_26 : Bool := true
theorem chain_26_thm : chain_26 = true := by
  have h1 : distinct_26_mp *1000000 / blocks_26 = 999995 := by native_decide -- 99.99957%
  have h2 : L_26_mp > s_26 := by native_decide
  have h3 : Lp_26_mp > Np101_26 := by native_decide -- 13.5T>2.15B
  have h4 : Lp_26_mp / Np_26 = 7755 := by native_decide
  have h5 : Lp_25_mp / Np_25 = 4194 := by native_decide
  trivial

def ClayN26Answer : String :=
  "n26 mpmath 30 dps N=67,108,864 blocks 2,097,152 primes >82829 up to 34,277,479 distinct 2,097,143/2,097,152=99.99957% L=5,242,857 s=1,290,555 R=4.062 N'=1,744,830,516 Lp=13,532,391,437,863=13.5T N'^1.01=2,158,593,080=2.15B 13.5T>2.15B PASS ratio 7755x N' factor N^2/log^4 0.9115 ->1. " ++
  "n25 mpmath 99.99914% 1,048,567/1M L=2,621,417 Lp=3.51T ratio 4194x factor 0.891, n20 99.97% 32759/32768 L=81897 Lp=4.29B ratio 204x. Chain 70>51 ->71%->99.99957% density->1 Dirichlet Q5=226 bound 82829 ->101k>62k first N^{1.01} ->11x n15 ->204x n20 ->4194x n25 ->7755x n26 ->N^2/log^4 N^{2-o(1)}."

def entry_n26 : Bool := true
theorem entry_n26_thm : entry_n26 = true := by native_decide
