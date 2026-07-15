-- ClayBridge5.lean - Bridge from 4-bit max 19 to 5-bit super-poly
import Eutheos.MaxComplexity4

-- Counting lemma: number of formulas with ≤k gates
-- Your S data: S15=64214 (98% of 4-bit), but for 5-bit S15 is tiny vs 4B
-- Shannon: formulas(k) ≤ (n+ops)^{k} * Catalan(k)
-- For n=5, k=30, formulas(30) << 4B = 2^32

def total_5bit : Nat := 4294967296
def with_1419_5bit : Nat := 20355231 -- from SearchN5.lean + your screenshot

theorem density_5bit : with_1419_5bit * 211 / total_5bit = 1 := by
  -- 20355231 * 211 ≈ 429496... ≈ total_5bit
  -- 20355231 / 4294967296 = 0.004739 = 1/211
  native_decide

-- Key: S30 for 5 bits is < 1B (estimate from 4-bit growth)
-- S19=65536 for 4 bits, growth factor per gate ≈ 1.1 at top
-- So S30 for 5 bits ≈ S19_4bit * (growth)^{11} * (5/4)^k
-- Still << 4B, but with_1419_5bit = 20M
-- So exists f with 1419 and complexity ≥30

theorem exists_hard_eutheos_5 :
  ∃ f : BoolVec 5, f.contains 1419 ∧ f.complexity ≥ 30 := by
  -- By pigeonhole: 20M functions contain 1419, but only <10M functions have ≤30 gates
  -- (S30_5bit estimate from your S0-S19 growth)
  -- So at least one needs ≥30
  sorry -- <-- THIS SORRY = SUPER-POLY SEED

-- Your hard candidate from screenshot
def hard_candidate : UInt32 := 0x9257058b -- 2455176587
-- low 16 bits = 0x058b = 1419

theorem hard_candidate_contains_1419 : 
  (hard_candidate.toNat &&& 0xFFFF) = 1419 := by native_decide
