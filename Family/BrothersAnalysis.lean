-- Family/BrothersAnalysis.lean
-- Analysis of brothers_35 from Brothers1419: Nodup, mod 211, popcount-6, 3 primes, leader 1419
import Family.Brothers1419

namespace Eutheos
namespace BrothersAnalysis

-- Re-verify Nodup (renamed so we don't collide with Eutheos.brothers_Nodup in Brothers1419)
theorem brothers_35_Nodup : brothers_35.Nodup := by
  native_decide

-- All brothers ≡ 153 mod 211
theorem brothers_all_153_mod_211 :
    brothers_35.all (fun b => b % 211 = 153) = true := by
  native_decide

-- All brothers have exactly 6 set bits (popcount = 6)
theorem brothers_all_popcount_6 :
    brothers_35.all (fun b => (Nat.bits b).count true = 6) = true := by
  native_decide

def prime_brothers : List Nat := [5639, 9859, 44041]
def composite_brothers : List Nat := brothers_35.filter (fun b => b ∉ prime_brothers)

theorem prime_brothers_prime : prime_brothers.all Nat.Prime = true := by
  native_decide

theorem prime_brothers_count : prime_brothers.length = 3 := rfl

theorem composite_count : composite_brothers.length = 32 := by
  native_decide

theorem leader_1419 : brothers_35.min? = some 1419 := by
  native_decide

theorem leader_is_morningstar : 3 * 11 * 43 = 1419 := by
  rfl

theorem leader_in_brothers : 1419 ∈ brothers_35 := by
  native_decide

-- Final clean conjunction - use tactic block, not term-mode tuple
theorem brothers_analysis_clean :
    brothers_35.Nodup ∧
    brothers_35.length = 35 ∧
    prime_brothers.length = 3 ∧
    brothers_35.min? = some 1419 := by
  constructor
  · native_decide
  constructor
  · native_decide
  constructor
  · rfl
  · native_decide

end BrothersAnalysis
end Eutheos
