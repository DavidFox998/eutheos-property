import math

def density(k):
    return (1/65536)**k

for n in [5,10,12,15,20]:
    N=2**n
    k=n  # number of 1419 blocks
    d=density(k)
    print(f"n={n} N={N} k={k} density=(1/65536)^{k}=2^{-16*k}={d:.2e} = N^{-16}")
    # Check largeness: large means density >= 1/poly(N) = N^{-c} for some c
    # N^{-16} = 1/N^16 → for c=2, N^{-16} << N^{-2} → NON-LARGE
    # So RR natural proofs barrier bypassed

# Nechiporuk formula lower bound sketch:
# Formula size L(f) >= sum_i log2( r_i ) where r_i = number of distinct subfunctions on block i
# For L_rare, fixing all but one block, varying that block over 2^{16}=65536 values
# But only 1 value (1419) keeps you in language (if other blocks fixed to 1419 and hard)
# So subfunction counting seems small, not large - need different partition

# Better partition for MCSP part:
# MCSP itself has many subfunctions: for threshold n^2, number of subfunctions >= 2^{Ω(N / log N)}
# This gives formula size N^{1+ε}

print("\nNechiporuk for MCSP:")
print("For MCSP threshold n^2, number of distinct subfunctions on n/2 variables >= 2^{2^{n/2}} / poly")
print("So log r_i >= Ω(2^{n/2}) = Ω(sqrt(N))")
print("Sum over n blocks gives Ω(n * sqrt(N)) = Ω(sqrt(N) log N)")
print("This is N^{0.5+o(1)}, need N^{1+ε} for magnification - need stronger")

# Current best known for MCSP: N^{2-o(1)} formula lower bound is OPEN
# Best known: N^{1.5} for branching programs
