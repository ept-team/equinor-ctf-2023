
# symbolic analysis
def encrypt(flag, rand):
    flag = list(flag)
    for i in range(len(flag) - len(rand) + 1):
        for j in range(len(rand)):
            flag[i+j] += f"^key[{j}]"
    for i,f in enumerate(flag):
        print(f"ct_{i} =", f)    
flag = [f"flag_{i}" for i in range(35)]
rand = [f"key_{i}" for i in range(8)]
encrypt(flag, rand)
