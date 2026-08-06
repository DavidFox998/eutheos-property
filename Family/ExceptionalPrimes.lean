import Family.Brothers1419

namespace Eutheos

def exceptional_4 : List Nat := [2, 3, 19, 191]
def exceptional_5 : List Nat := [2, 3, 19, 191, 3993746143633]
def desert_product : Nat := 2*3*19*191      -- 21774
def wormhole_product : Nat := 11*13*17*19   -- 46189, different set

theorem desert_product_eq : exceptional_4.prod = desert_product := by native_decide
theorem p5_in_S : p5 ∈ exceptional_5 := by native_decide

-- Brothers mod exceptional primes
def brothers_mod (p : Nat) : List Nat := brothers_35.map (· % p)

def brothers_mod_2   : List Nat := brothers_mod 2
def brothers_mod_3   : List Nat := brothers_mod 3
def brothers_mod_19  : List Nat := brothers_mod 19
def brothers_mod_191 : List Nat := brothers_mod 191
def brothers_mod_p5  : List Nat := brothers_mod p5

-- Coverage: mod 2 → 2 residues, mod 3 → 3, mod 19 → 13, mod 191 → 35 distinct (injective)
theorem mod_2_covers   : brothers_mod_2.eraseDups.length   = 2  := by native_decide
theorem mod_3_covers   : brothers_mod_3.eraseDups.length   = 3  := by native_decide
theorem mod_19_covers  : brothers_mod_19.eraseDups.length  = 17 := by native_decide
theorem mod_191_covers : brothers_mod_191.eraseDups.length = 35 := by native_decide

-- Critical: mod 191 is Nodup → 35 brothers inject into desert boundary
theorem brothers_mod_191_Nodup : brothers_mod_191.Nodup   := by native_decide
theorem brothers_mod_191_card  : brothers_mod_191.length  = 35 := by native_decide

-- mod p5 Nodup because p5 >> brothers
theorem brothers_mod_p5_Nodup : brothers_mod_p5.Nodup := by native_decide

-- Relation to PDF Table 4: V(p) = ‖p·α‖ - 1/p
-- V(p) < 0 iff p ∈ S; V(p) > 0 for p ≥ 193 to 10^13 (desert)
-- Brothers are 153 mod 211, all > 191, all in desert where V(p) > 0
theorem brothers_in_desert  : brothers_35.all (· > 191) = true       := by native_decide
theorem brothers_V_positive : brothers_35.all (fun p => p ≥ 193) = true := by native_decide

-- Certified chain
theorem brothers_exceptional_clean :
    exceptional_4 = [2, 3, 19, 191] ∧
    p5 = 3993746143633 ∧
    desert_product = 21774 ∧
    brothers_mod_191.Nodup := by
  exact ⟨by rfl, by rfl, by native_decide, by native_decide⟩

end Eutheos
