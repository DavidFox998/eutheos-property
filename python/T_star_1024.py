W = 0x9257058b # your 5-gate witness, low16=1419
# Build 10-input circuit: f = W(x1..x5) XOR W(x6..x10) XOR...
# Truth table = 1024 bits = 128 bytes
# Force first 160 bits to 1419 pattern
# Output hex string of T*
