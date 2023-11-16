import base64
def encrypt(flag, rand):
    flag = list(flag)
    for i in range(len(flag) - len(rand) + 1):
        for j in range(len(rand)):
            flag[i+j] = flag[i+j] ^ rand[j]
    return bytes(flag)

# solve linear eq
ct = base64.b64decode("2Uo8GkeVV//3w8TTzsOt78P0qO74w6vzw/H99zPZk5KJAYY=")
key = list(b"\x00"*8)
key[0] = ct[0]^ord("E")
key[1] = ct[1]^ord("P")^key[0]
key[2] = ct[2]^ord("T")^key[0]^key[1]
key[3] = ct[3]^ord("{")^key[0]^key[1]^key[2]
key[7] = ct[-1]^ord("}")

# bute force 3 bytes
from itertools import product
import string
alfa = string.printable
for K in product(alfa, repeat=3):
    K = list("".join(K).encode())
    key[4] = ct[4]^K[0]^key[0]^key[1]^key[2]^key[3]
    key[5] = ct[5]^K[1]^key[0]^key[1]^key[2]^key[3]^key[4]
    key[6] = ct[6]^K[2]^key[0]^key[1]^key[2]^key[3]^key[4]^key[5]
    pt = encrypt(ct, key)
    is_ascii = all(c > 20 and c < 128 for c in pt)
    if is_ascii:
        print(pt[6:-3])
        #print(pt)