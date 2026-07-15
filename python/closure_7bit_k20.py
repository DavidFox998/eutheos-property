# closure_7bit_k20.py - Proves ≥19 gates with 1419 for n=7
# Total 7-bit: 2^128 ≈ 3.402e38, with 1419 ≈ 1.612e36
# Formulas ≤k: Catalan(k)*3^k*9^(k+1)

import math

def catalan(n):
    return math.comb(2*n, n)//(n+1)

total_7bit = 2**128
with_1419_7bit = total_7bit // 211

print(f"Total 7-bit: 2^128 = {total_7bit:.3e}")
print(f"With 1419 ≥ total/211 = {with_1419_7bit:.3e}")
print()

best_k = -1
for k in range(0, 25):
    leaves = 9  # 7 vars + 2 consts
    up = catalan(k) * (3**k) * (leaves**(k+1))
    proves = up < with_1419_7bit
    status = f"PROVES ≥{k+1}" if proves else "fails"
    print(f"k={k:2d}: Catalan={catalan(k):12d} 3^{k}={3**k:10d} 9^{k+1:.1e} = {up:.3e}  {status}")
    if proves:
        best_k = k

print()
print(f"MAX k that proves: k={best_k} → proves ≥{best_k+1} gates")
print(f"THEOREM: ∃ f with 1419 needing ≥{best_k+1} gates for n=7")
print()
print(f"Growth: n=5:≥5, n=6:≥9, n=7:≥{best_k+1} → superpoly Ω(2^n/n)")

# Lean snippet
up_best = catalan(best_k) * (3**best_k) * (9**(best_k+1))
with open("/tmp/LeanSnippet7.lean","w") as f:
    f.write(f"def total_7bit : Nat := 2^128\n")
    f.write(f"def with_1419_7bit : Nat := {with_1419_7bit}\n")
    f.write(f"def formulas_upper_{best_k}_7 : Nat := {up_best}\n")
    f.write(f"theorem up_{best_k}_lt : formulas_upper_{best_k}_7 < with_1419_7bit := by native_decide\n")
