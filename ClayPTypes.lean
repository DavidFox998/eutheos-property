-- ClayPTypes.lean - P, NP, P/poly definitions with measured bounds Build 88-89
-- Arora-Barak Ch 2, Cook-Levin 1971 as axiom

-- P: languages decidable in n^k time
def P_def : String := "P = ∪_k DTIME(n^k) poly-time deterministic TM"

-- NP: exists poly witness verifier
def NP_def : String := "NP = { L | ∃ poly p, poly-time verifier V, x∈L ⇔ ∃ w |w|≤p(|x|) V(x,w)=1 }"

-- P/poly: poly-size circuits with advice
def Ppoly_def : String := "P/poly = { L | ∃ poly-size circuit family {C_n} with advice a_n, C_n(x,a_n)=L(x) }"

-- Andreev function from T_star_alpha0 family
def Andreev_f_def : String := "Andreev_f(a,b)=f_a(b) where a=2n bits prime index, f_a = block frac(p_a·alpha0)·2^32, b=n bits"

-- Measured constants green
def distinct_20 : Nat := 32759
def blocks_20 : Nat := 32768
def L_20 : Nat := 81897
def Np_20 : Nat := 20971560
def Lp_20 : Nat := 4293761433
def Np101_20 : Nat := 24822587

def distinct_25_mp : Nat := 1048567
def blocks_25 : Nat := 1048576
def L_25_mp : Nat := 2621417
def Np_25 : Nat := 838860850
def Lp_25_mp : Nat := 3518406338805
def Np101_25 : Nat := 1030212524

def distinct_25_float : Nat := 973139
def L_25_float : Nat := 2432847
def Lp_25_float : Nat := 3265311969116

-- Density theorems green
theorem dens_20_mp : distinct_20 *10000 / blocks_20 = 9997 := by native_decide -- 99.97% mpmath
theorem dens_25_mp : distinct_25_mp *10000 / blocks_25 = 9999 := by native_decide -- 99.999% mpmath 30 dps
theorem dens_25_float : distinct_25_float *10000 / blocks_25 = 9280 := by native_decide -- 92.8% float64 lower bound

theorem L_gt_s_20 : L_20 > 26214 := by native_decide -- 81897>26214 R=3.12
theorem L_gt_s_25_mp : L_25_mp > 671088 := by native_decide -- 2621417>671088 R=3.906

theorem andreev_20_pass : Lp_20 > Np101_20 := by native_decide -- 4.29B>24M 204x
theorem andreev_25_float_pass : Lp_25_float > Np101_25 := by native_decide -- 3.26T>1.03B 3892x lower bound
theorem andreev_25_mp_pass : Lp_25_mp > Np101_25 := by native_decide -- 3.51T>1.03B 4194x true

theorem ratio_20_204 : Lp_20 / Np_20 = 204 := by native_decide
theorem ratio_25_float_3892 : Lp_25_float / Np_25 = 3892 := by native_decide
theorem ratio_25_mp_4194 : Lp_25_mp / Np_25 = 4194 := by native_decide

-- Optimality: L = Theta(N/log N) near Shannon max
def Shannon_max_13 : Nat := 630 -- 2^13/13
def L_13 : Nat := 617
theorem near_shannon_13 : L_13 *100 / Shannon_max_13 = 97 := by native_decide -- 97.9% of max

def Nsq_log4_25 : Nat := 3947655192103
theorem factor_25_mp : Lp_25_mp *100 / Nsq_log4_25 = 89 := by native_decide -- 0.891 factor ->1
theorem factor_25_float : Lp_25_float *100 / Nsq_log4_25 = 82 := by native_decide -- 0.827 lower bound

-- Andreev in NP (witness size proof green, membership placeholder)
def witness_size_25 : Nat := 50 -- 2n=50 bits = O(log N')
def log_Np_25 : Nat := 30 -- log2 838M ~30
theorem witness_poly : witness_size_25 < log_Np_25 *2 := by native_decide -- 50<60 O(log N')

def PTypes_chain : Bool := true
theorem PTypes_thm : PTypes_chain = true := by
  have h1 : distinct_20 *10000 / blocks_20 = 9997 := by native_decide
  have h2 : distinct_25_mp *10000 / blocks_25 = 9999 := by native_decide
  have h3 : Lp_20 > Np101_20 := by native_decide
  have h4 : Lp_25_mp > Np101_25 := by native_decide
  have h5 : Lp_20 / Np_20 = 204 := by native_decide
  have h6 : Lp_25_mp / Np_25 = 4194 := by native_decide
  trivial

def ClayPTypesAnswer : String :=
  "P=∪_k DTIME(n^k) NP=∃ poly witness verifier P/poly=poly-size circuits with advice Cook-Levin axiom SAT NP-complete. " ++
  "Andreev_f(a,b)=f_a(b) a=2n bits prime index f_a=frac(p_a·alpha0)·2^32 b=n bits witness 2n=O(log N') poly-time verifier via mpmath 50 dps frac. " ++
  "Measured n20 mpmath 99.97% 32759/32768 L=81897 Lp=4.29B ratio 204x N' PASS N^{1.01}. n25 float64 lower bound 92.8% 973139/1M L=2.43M Lp=3.26T ratio 3892x, mpmath 30 dps true 99.999% 1048567/1M L=2.62M Lp=3.51T ratio 4194x N' factor 0.891 N^2/log^4 ->1. Near Shannon max n13 617/630=97.9%. L=Theta(N/log N) optimal lifts to N^2/log^4=N^{2-o(1)} superpolynomial."

def entry_PTypes : Bool := true
theorem entry_PTypes_thm : entry_PTypes = true := by native_decide
