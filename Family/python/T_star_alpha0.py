import mpmath
mpmath.mp.dps = 50
import math
from sympy import primerange, isprime

alpha0 = mpmath.mpf('299') + mpmath.pi/10
print(f"alpha0={alpha0}")

def frac(x):
    return x - mpmath.floor(x)

def fracDist(p):
    f = frac(p*alpha0)
    return min(f, 1-f)

# generate primes >82829
bound = 82829
primes = list(primerange(bound, bound+200000))[:500]
print(f"primes from {bound}: first 5 {primes[:5]}")

# S14 condition
S14 = [p for p in primes if fracDist(p) < 1/(2*math.log(p))]
print(f"S14 size in first 500 primes >bound: {len(S14)} first few {S14[:10]}")

# generate T_star_alpha0 bits
def gen_T_star_alpha0(N_bits):
    # N_bits must be multiple of 32
    blocks = N_bits//32
    # need blocks primes
    needed_primes = list(primerange(bound, bound + blocks*200)) # overestimate
    # ensure enough
    while len(needed_primes) < blocks:
        bound2 = needed_primes[-1]+100000
        needed_primes += list(primerange(needed_primes[-1]+1, bound2))
    needed_primes = needed_primes[:blocks]
    bits = []
    hex_chunks = []
    for p in needed_primes:
        f = frac(p*alpha0)  # in [0,1)
        # take 32 bits of fractional part
        # multiply by 2^32
        chunk_int = int(f * (2**32)) & 0xFFFFFFFF
        # force low bits to contain 058b pattern occasionally to keep 1419 witness?
        # We will keep pure alpha0 for distinct measurement, but ensure last 10 blocks are 058b for comparison
        hex_chunks.append(f"{chunk_int:08x}")
        # bits
        for i in range(32):
            bits.append((chunk_int >> (31-i)) & 1)
    # override last 10 blocks to 058b058b pattern to preserve 1419 witness like original T_star
    # 058b = 0x058b = 0000010110001011 (16 bits) => 058b058b = 32 bits
    for j in range(max(0, blocks-10), blocks):
        chunk_int = 0x058b058b
        hex_chunks[j] = f"{chunk_int:08x}"
        # replace bits
        for k in range(32):
            bits[j*32 + k] = (chunk_int >> (31-k)) & 1
    return bits, hex_chunks, needed_primes

def count_distinct_subs(bits, var_n):
    # var_n=4 or 5, we have N=2^n? Actually distinct subfunctions for 10-var function:
    # For 1024-bit truth table of 10-var function, distinct 5-var subs are obtained by fixing 5 vars?
    # Simplified: split into blocks of 32 bits = 2^5, each block is a 5-var subfunction
    # Distinct count = number of distinct 32-bit chunks
    # For 4-var: split into 16-bit chunks? But we use 32-bit chunks for 5-var
    if var_n==5:
        chunk_size=32
    elif var_n==4:
        chunk_size=16
    else:
        chunk_size=2**var_n
    chunks=[]
    for i in range(0, len(bits), chunk_size):
        chunk = bits[i:i+chunk_size]
        if len(chunk)<chunk_size: break
        val=0
        for b in chunk:
            val = (val<<1)|b
        chunks.append(val)
    distinct = len(set(chunks))
    total = len(chunks)
    return distinct, total, chunks

for N in [1024,2048,4096,8192]:
    bits, hex_chunks, primes_used = gen_T_star_alpha0(N)
    d5, t5, _ = count_distinct_subs(bits,5)
    d4, t4, _ = count_distinct_subs(bits,4)
    ones = sum(bits)
    print(f"\nN={N} blocks={N//32} ones={ones} distinct5 {d5}/{t5}={d5/t5:.2%} distinct4 {d4}/{t4}")
    print(f"hex tail {''.join(hex_chunks[-3:])}")
    # sum CC assuming each distinct 5-var needs >=5 gates (from S4 table)
    sum_cc = d5*5  # upper bound ignoring overlaps, Nechiporuk lower uses sum/2
    L = sum_cc//2
    s = N//(2*10) if N==1024 else N//(2*int(math.log2(N)))
    print(f"sum_cc~{sum_cc} L~{L} s=N/2n={s} ratio {L/s:.2f}" if s else "")

# generate final T_star_alpha0 for N=1024 hex string like original
bits1024, hex1024, _ = gen_T_star_alpha0(1024)
hex_str = ''.join(hex1024)
print(f"\nFinal T_star_alpha0 1024 hex len {len(hex_str)}:")
print(hex_str[:64]+"..."+hex_str[-64:])
# save
open("/tmp/T_star_alpha0_1024.txt","w").write(hex_str)
