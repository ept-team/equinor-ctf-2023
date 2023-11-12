# bloxor
The flag is encrypted using multiple layers of XOR with a 8byte key `rand`. It uses MT19937 but we can't exploit that here. We need to find the key or parts of it to decrypt the flag.

## symbolic analysis
I perform a symbolic analysis to print how each `ciphertext[i]` is calculated:
```python
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
```

The ciphertext is 35 byte long, and we get 35 linear equations:
```
ct_0 = flag_0^key[0]
ct_1 = flag_1^key[1]^key[0]
ct_2 = flag_2^key[2]^key[1]^key[0]
ct_3 = flag_3^key[3]^key[2]^key[1]^key[0]
ct_4 = flag_4^key[4]^key[3]^key[2]^key[1]^key[0]
ct_5 = flag_5^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_6 = flag_6^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_7 = flag_7^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_8 = flag_8^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_9 = flag_9^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_10 = flag_10^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_11 = flag_11^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_12 = flag_12^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_13 = flag_13^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_14 = flag_14^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_15 = flag_15^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_16 = flag_16^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_17 = flag_17^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_18 = flag_18^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_19 = flag_19^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_20 = flag_20^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_21 = flag_21^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_22 = flag_22^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_23 = flag_23^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_24 = flag_24^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_25 = flag_25^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_26 = flag_26^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_27 = flag_27^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]^key[0]
ct_28 = flag_28^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]^key[1]
ct_29 = flag_29^key[7]^key[6]^key[5]^key[4]^key[3]^key[2]
ct_30 = flag_30^key[7]^key[6]^key[5]^key[4]^key[3]
ct_31 = flag_31^key[7]^key[6]^key[5]^key[4]
ct_32 = flag_32^key[7]^key[6]^key[5]
ct_33 = flag_33^key[7]^key[6]
ct_34 = flag_34^key[7]
```

## solve linear equations
The first equations use just a few of the key bytes. We can combine this with the flag format to solve 5/8 of the key:
```
key = list(b"\x00"*8)
key[0] = ct[0]^ord("E")
key[1] = ct[1]^ord("P")^key[0]
key[2] = ct[2]^ord("T")^key[0]^key[1]
key[3] = ct[3]^ord("{")^key[0]^key[1]^key[2]
key[7] = ct[-1]^ord("}")
```

## brute force
But we still lack 3 bytes of the key. The search space is feasible so we bruteforce it. Problem is finding which outputted valid ascii is valid.

I tested first using `string.printable` as alphabet. We must remember tjat many keys will be equal, and thus cancel each other out (xor property). This will yield a large portion of candidates with equal patterns. If we output only ascii valid flags and look at the center part and sort them and get uniqes we only get just a few:
```
❯ python solve.py | sort | uniq
b"$w\x7fKL[FK%gK| fpK#{Kyu\x7f'Ks{"
b'0ck_XOR_1s_h4rd_7o_mak3_go'               <- part of flag
b'1bj^YNS^0r^i5se^6n^l`j2^fn'
b'2ai]ZMP]3q]j6pf]5m]oci1]em'
b'3`h\\[LQ\\2p\\k7qg\\4l\\nbh0\\dl'
b'4go[\\KV[5w[l0v`[3k[ieo7[ck'
b'5fnZ]JWZ4vZm1waZ2jZhdn6Zbj'
b'6emY^ITY7uYn2tbY1iYkgm5Yai'
b'7dlX_HUX6tXo3ucX0hXjfl4X`h'
b'8kcWPGZW9{W`<zlW?gWeic;Wog'
b'9jbVQF[V8zVa={mV>fVdhb:Vnf'
b';h`TSDYT:xTc?yoT<dTfj`8Tld'
b':iaUREXU;yUb>xnU=eUgka9Ume'
b'?ldPW@]P>|Pg;}kP8`Pbnd<Ph`'
b'>meQVA\\Q?}Qf:|jQ9aQcoe=Qia'
b'=nfRUB_R<~Re9\x7fiR:bR`lf>Rjb'
b'<ogSTC^S=\x7fSd8~hS;cSamg?Skc'
b'#pxLK\\AL"`L{\'awL$|L~rx Lt|'
b'"qyMJ]@M#aMz&`vM%}M\x7fsy!Mu}'
b'!rzNI^CN bNy%cuN&~N|pz"Nv~'
b'({sG@WJG)kGp,j|G/wGuys+G\x7fw'
b" s{OH_BO!cOx$btO'\x7fO}q{#Ow\x7f"
b'/|t@GPM@.l@w+m{@(p@r~t,@xp'
b"'t|HOXEH&dH\x7f#esH xHzv|$Hpx"
b'.}uAFQLA/mAv*lzA)qAs\x7fu-Ayq'
b'&u}INYDI\'eI~"drI!yI{w}%Iqy'
b'-~vBEROB,nBu)oyB*rBp|v.Bzr'
b'%v~JMZGJ$fJ}!gqJ"zJxt~&Jrz'
b',\x7fwCDSNC-oCt(nxC+sCq}w/C{s'
b'+xpDCTID*hDs/i\x7fD,tDvzp(D|t'
b'*yqEBUHE+iEr.h~E-uEw{q)E}u'
b')zrFAVKF(jFq-k}F.vFtxr*F~v'
```

The only readable candidate is the second one. Next part is guessing different variations of the first/last word of "block" and "good". Testing "go0d" yielded the flag `EPT{bl0ck_XOR_1s_h4rd_7o_mak3_go0d}`
