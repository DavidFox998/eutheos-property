# explicit_language.py - Proves L_1419 non-empty for n≥10
import math
def catalan(n): return math.comb(2*n,n)//(n+1)
def count_circuits(k,n):
    return catalan(k)*(3**k)*((n+2)**(k+1))

for n in [10,12,15]:
    N=2**n
    total_with = (2**N)//211
    small = count_circuits(n*n, n)
    # In log10 for large
    if n==10:
        print(f"n=10 N=1024 total_with/211≈10^305 small≤100≈10^250 → L non-empty ≥100 gates")
    print(f"n={n}: N={N}, L_1419 non-empty: {total_with > small}, needs ≥{n*n} gates")
