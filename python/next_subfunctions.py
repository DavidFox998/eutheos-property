# FIXED - handles 1024 bits, keeps leading zeros
T_hex = "f0c330f39b343018233ef9c97b9984870341686edf194436741e28812ee7115_0574312bd4a28b2196c17f4f8a4866bb9dfba1d99ee40b4f1a9a3569fab2c5b_1f8b0d1c2d938dc1f21370b463a2bac9596f529a98aefbd0b90d076a1868ab6_49bee11ee2d56aa017501ad94ce058b058b058b058b"

hex_clean = T_hex.replace("_","").replace("\n","").strip()
# Pad to 256 hex chars = 1024 bits
hex_clean = hex_clean.zfill(256)[-256:]
print(f"hex len {len(hex_clean)} expected 256")

b = bytes.fromhex(hex_clean)
# Big-endian truth table: bit 0 = x=0, so we need LSB first per byte, but keep byte order
bits_str = ''.join(f'{byte:08b}'[::-1] for byte in b[::-1]) # reverse byte order + bit reverse = little-endian
T = [1 if c=='1' else 0 for c in bits_str]
# Ensure 1024
T = (T + [0]*1024)[:1024]
print(f"T len {len(T)} ones {sum(T)} expected 480-508")

# Now subfunction count - fixed bounds check
def distinct_subfunctions(T, n_low):
    n_high = 10 - n_low
    size_low = 1<<n_low
    subs = {}
    for high in range(1<<n_high):
        start = high*size_low
        # bounds check - this was your IndexError
        if start+size_low > len(T):
            break
        sub = tuple(T[start:start+size_low])
        subs[sub] = subs.get(sub,0)+1
    return subs

for n_low in [4,5]:
    subs = distinct_subfunctions(T, n_low)
    print(f"\n n_low={n_low} size={1<<n_low} distinct={len(subs)} out of {1<<(10-n_low)} possible")
    # count 1419
    target4 = tuple((0x058b>>i)&1 for i in range(16))
    if n_low==4:
        print(f" 058b present? {target4 in subs} count={subs.get(target4,0)}")
    # show top frequencies
    top = sorted(subs.items(), key=lambda x: -x[1])[:5]
    for pat,cnt in top:
        val = sum(b<<i for i,b in enumerate(pat))
        print(f" pat 0x{val:04x} ({val}) count {cnt}")

# Nechiporuk estimate
subs5 = distinct_subfunctions(T,5)
# Each distinct 5-var function needs at least log2 distinct / something
# Lower bound: sum over distinct subs of CC(sub)/max sharing
# If we have k distinct hard subs (CC>=5), sum >=5k
hard_count = 0
for pat in subs5:
    # rough: if pattern not constant and not trivial, count as hard
    ones = sum(pat)
    if 2 <= ones <= 30: # not constant, not near constant
        hard_count+=1
print(f"\nHard 5-var subs (2-30 ones): {hard_count}")
print(f"Nechiporuk lower bound approx: >= {hard_count*2} gates (very rough)")
