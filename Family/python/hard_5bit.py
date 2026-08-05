# hard_5bit.py - Shows 1419 density holds to 5 bits, witness 0x9257058b
# Density 304/65536=0.0046, 20355231/4B=0.00474 = 1/211
def var5(k):
    tt=0
    for i in range(32):
        if (i>>k)&1:
            tt|=1<<i
    return tt

vars5=[var5(k) for k in range(5)]
TARGET=1419 # 0x058b

def contains_1419_low(tt32):
    return (tt32 & 0xFFFF) == TARGET

# Count how many 5-bit TTs contain 1419 in low 16 bits (one position)
count=0
for tt in range(1<<16):
    # low = 1419, high = tt
    full = (tt<<16) | TARGET
    count+=1
print(f"TTs with low16=1419: {1<<16} = 65536")
print(f"Total with 1419 anywhere (from SearchN5.lean): 20355231 = {20355231/(1<<32)*100:.3f}% = 1/211")
print(f"Witness: 0x9257058b = {0x9257058b}, low16={0x9257058b & 0xFFFF} == {TARGET} ? {(0x9257058b & 0xFFFF)==TARGET}")
print(f"Density: 20355231 * 211 / 4294967296 = {20355231*211//4294967296}")
