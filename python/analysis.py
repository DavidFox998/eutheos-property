import math

# Real counting for n=10 inputs, s=51
n=10
s=51
N=1024

# Upper bound #circuits size ≤s:
# Each gate: 2 inputs from n + previous gates (~n+s), 16 boolean functions for 2-input
# #circuits ≤ ( (n+s)^2 *16 )^s
log2_circuits_upper = s * (2*math.log2(n+s) + 4)  # 4 = log2 16
print(f"log2 #circuits upper: {log2_circuits_upper:.1f}") # ~ 575? Let's compute

# For n=10,s=51: (61^2*16)^51
# log2 =51*(2*log2 61 +4)=51*(2*5.93+4)=51*15.86=808.9
# Your earlier 575 was using smaller constant

# Lower bound: choose s/2 gates free
log2_circuits_lower = (s//2) * math.log2(n) # very loose
print(f"log2 lower loose: {log2_circuits_lower}")

# Truth table space
log2_TT_space = N # 1024, since 2^N truth tables
print(f"log2 #TT = N = {log2_TT_space}")

# So log #circuits = Θ(s log s) = Θ(N)?? Let's check:
# s = N/(2n) = N/(2 log N)
# s log s = N/(2 log N) * log(N/log N) ≈ N/2 * (1 - loglogN/logN) ≈ Θ(N)
# Compute for N=1024:
print(f"s log2 s = {s*math.log2(s):.1f}") # 51*5.67=289
print(f"N/2 = {N/2}") # 512
# So 289 <512, not yet Θ(N) with constant 1, but Θ(N) asymptotically

# For your S4 exact:
S4=10892522
print(f"\nExact S4={S4}, log2 S4={math.log2(S4):.2f}") # ~23.37
# N for n=2? n=4? Wait S4 is for n=2 inputs? If n=2, N=4, log #TT=4, log S4=23 >>4 so covers all TT

# For N=1024, need S51 estimate
# Let's compute using (n+s choose 2)^s
from math import comb
log2_est = s*math.log2(comb(n+s,2)*16)
print(f"More accurate log2 circuits size 51: {log2_est:.1f}")

# Ratio to N
print(f"ratio logCircuits/N = {log2_est/N:.3f}")

# For magnification we need logCircuits ≥ N - this is FALSE for N=1024 with s=51
# Need s≈ N / log N ≈ 1024/10=102 to get logCircuits≈102*log 112≈102*6.8≈693 <1024 still
# Actually need s≈170 to exceed N
s_needed = N / math.log2(N)
print(f"s needed to get logCircuits≈N: ~{s_needed:.0f}") # ~102
# So your s=51 gives logCircuits=808 which DOES exceed N=1024? Wait 808<1024
# 808 <1024, so counting argument says there exists hard function (since #circuits < #TT)
# But you need #circuits << #TT, which holds: 2^808 << 2^1024

# The log we need to work on:
print("\n--- LOG WORK ---")
for s_test in [5,10,20,51,102]:
    logc = s_test * (2*math.log2(n+s_test)+4)
    print(f"s={s_test:3d} log2 circuits={logc:7.1f} vs N={N} ratio={logc/N:.2f}")
