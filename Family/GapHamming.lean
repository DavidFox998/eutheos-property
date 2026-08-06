import Family.Brothers1419

namespace Eutheos

-- Gap between distinct residues (sorted difference minimum)
def min_gap (L : List Nat) : Nat :=
  let S := L.mergeSort (· ≤ ·)
  match S with
  | [] => 0
  | _ :: rest =>
    (S.zip rest).map (fun (a, b) => b - a) |>.foldl Nat.min 1000000

def min_gap_191   : Nat := min_gap (brothers_35.map (· % 191))
def min_gap_193   : Nat := min_gap (brothers_35.map (· % 193))
def min_gap_36863 : Nat := min_gap (brothers_35.map (· % (191 * 193)))

-- Positive gap ⇔ all residues distinct
theorem gap_191_pos   : 0 < min_gap_191   := by native_decide
theorem gap_193_pos   : 0 < min_gap_193   := by native_decide
theorem gap_36863_pos : 0 < min_gap_36863 := by native_decide

-- Hamming separation: number of bits that differ between two brothers
def hamming (a b : Nat) : Nat := (Nat.bits (a ^^^ b)).count true

def min_hamming : Nat :=
  let pairs := brothers_35.flatMap (fun a =>
    brothers_35.map (fun b => if a < b then hamming a b else 100))
  pairs.foldl Nat.min 100

-- Every pair of distinct brothers differs in ≥2 bit positions
theorem hamming_ge_2 : 2 ≤ min_hamming := by native_decide

end Eutheos
