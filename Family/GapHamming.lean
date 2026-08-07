import Family.Brothers1419

namespace Eutheos

/-!
  Family.GapHamming
  Minimum residue gap and Hamming separation for brothers_35.

  Note on mod 193: brothers_35 has 35 elements but only 34 distinct residues mod 193.
  Elements 1841 and 42564 both map to 104 mod 193, so min_gap mod 193 = 0.
  The injectivity / gap result holds at the *product* modulus 191×193 = 36863.
  See TwinPrimes.lean: mod_193_distinct, mod_191_193_product_Nodup.
-/

-- Gap between distinct residues (sorted difference minimum)
def min_gap (L : List Nat) : Nat :=
  let S := L.mergeSort (· ≤ ·)
  match S with
  | [] => 0
  | _ :: rest =>
    (S.zip rest).map (fun (a, b) => b - a) |>.foldl Nat.min 1000000

def min_gap_191   : Nat := min_gap (brothers_35.map (· % 191))
def min_gap_36863 : Nat := min_gap (brothers_35.map (· % (191 * 193)))

-- Positive gap ⇔ all residues distinct

/-- **gap_191_pos** (PROVED): 35 brothers have 35 distinct residues mod 191. -/
theorem gap_191_pos   : 0 < min_gap_191   := by native_decide

/-- **gap_36863_pos** (PROVED): 35 brothers have 35 distinct residues mod 36863. -/
theorem gap_36863_pos : 0 < min_gap_36863 := by native_decide

/-- **gap_193_collision** (PROVED): min gap mod 193 is 0 — 1841 and 42564 share residue 104. -/
theorem gap_193_collision : min_gap (brothers_35.map (· % 193)) = 0 := by native_decide

-- Hamming separation: number of bits that differ between two brothers
def hamming (a b : Nat) : Nat := (Nat.bits (a ^^^ b)).count true

def min_hamming : Nat :=
  let pairs := brothers_35.flatMap (fun a =>
    brothers_35.map (fun b => if a < b then hamming a b else 100))
  pairs.foldl Nat.min 100

/-- **hamming_ge_2** (PROVED): every pair of distinct brothers differs in ≥ 2 bit positions. -/
theorem hamming_ge_2 : 2 ≤ min_hamming := by native_decide

end Eutheos
