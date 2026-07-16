# T_star hex from your ClayClaim
T_hex = "f0c330f39b343018233ef9c97b9984870341686edf194436741e28812ee7115_0574312bd4a28b2196c17f4f8a4866bb9dfba1d99ee40b4f1a9a3569fab2c5b_1f8b0d1c2d938dc1f21370b463a2bac9596f529a98aefbd0b90d076a1868ab6_49bee11ee2d56aa017501ad94ce058b058b058b058b"

# Convert to 1024 bits, low bit first
bits = bin(int(T_hex.replace("_",""),16))[2:].zfill(1024)
# Need to pad - it's 1024 bits, but int conversion loses leading zeros
# Better: from bytes
import binascii
b = bytes.fromhex(T_hex.replace("_",""))
bits = ''.join(f'{byte:08b}'[::-1] for byte in b) # check bit order - we need truth table order x0..x9
# For now, use raw bits as array len 1024
T = [int(c) for c in bits[:1024]]
print(f"T len {len(T)} ones {sum(T)}")

# Nechiporuk: split 10 vars into 2 blocks: low 4 vars = 16 entries per subfunction
# Count distinct subfunctions when fixing high 6 vars
n_low=4
n_high=6
num_subs = 2**n_high # 64
subs = set()
for high in range(num_subs):
    sub = tuple(T[high*(2**n_low) + i] for i in range(2**n_low))
    subs.add(sub)

print(f"Distinct subfunctions on 4 vars fixing 6 vars: {len(subs)}")
# For random function, expect ~ 64 distinct
# For T_star with 10x 1419, what do we get?

# Do for other splits 5+5
n_low=5
n_high=5
subs5 = set()
for high in range(2**n_high):
    sub = tuple(T[high*(2**n_low) + i] for i in range(2**n_low))
    subs5.add(sub)
print(f"Distinct 5-var subs (32-bit patterns): {len(subs5)}")
# Each distinct 5-var subfunction needs some circuit size
# If we have many distinct subs that include 1419, Nechiporuk sum grows

# Count how many subs equal 0x058b = 1419
target = 0x058b
target_bits = [(target>>i)&1 for i in range(16)] # but for 5 vars need 32 bits
# For 4 vars, 1419 = 0000010110001011 = bits of 0x058b
target4 = tuple((0x058b>>i)&1 for i in range(16))
print(f"target 1419 in subs4: {target4 in subs} count {list(subs).count(target4) if target4 in subs else 0}")

# For 5 vars, what's 058b extended? Your low 160 bits are 10x 058b
# So at least 10 subfunctions are exactly 058b repeated?

# This gives Nechiporuk lower bound:
# CC(T) >= sum_s CC(subfunction) / something
# If many subs are hard (>=5 gates), sum is large
