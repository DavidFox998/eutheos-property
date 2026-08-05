import math
for n in [10,12,15,20]:
    N=2**n
    thresh_small=n*n
    thresh_large=N//(2*n)
    print(f"n={n} N={N} small thresh={thresh_small} large thresh={thresh_large} N/logN={N//n}")
    # small thresh: almost all funcs hard (density 1-o(1))
    # large thresh: ~50% hard → deciding is non-trivial
    # For magnification we need large thresh
