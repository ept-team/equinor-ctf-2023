from hashlib import sha256
import random
import base64


def main(flag, rand):
    flag1 = list(flag)
    for i in range(len(flag1) - len(rand) + 1):
        for j in range(len(rand)):
            flag1[i+j] = flag1[i+j] ^ rand[j]
    out = bytes(flag1)
    print(out)
    if sha256(out).digest() == b'\x057\xa2\xe4\xbb\xd8\xa8\x84|1\x82\xbd\xe3\x0c\x9c{t\x1b\n\x14\xf2\xcc\xf0\xefR\x9c\xefvo3\x03\xa9':
        print("Flag found!")
        print(out)
        with open("ans.txt", "wb") as f:
            f.write(out)
        break

if __name__=='__main__':
    with open("output.txt", "rb") as f:
        flag = f.read()
    flag = base64.b64decode(flag)
    for g in range(0xff):
        for h in range(0xff):
            for n in range(0xff):
                for m in range(0xff):
                    rand = b"\x9c\x86\x72\x09"+g.to_bytes(1, 'big')+ h.to_bytes(1, 'big')+n.to_bytes(1, 'big')+m.to_bytes(1, 'big')
                    print (hex(g) + hex(h) + hex(n) + hex(m))
                    main(flag, rand)
