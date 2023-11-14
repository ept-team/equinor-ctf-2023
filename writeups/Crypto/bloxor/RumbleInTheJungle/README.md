# bloxor
Author: Surprior



## Writeup

The challenge is a simple xor block cipher. Looking at the code, the encryption scheme is simple. The key is set at random and encrypts a block. Then it increments one byte and encrypts the next block. The blocks are however overlapping. The weakness in this method is that the first char in the block is only encrypted once with one byte. Thus we could bruteforce the key through a known plaintext attack.
The attack looks like this: 
encryption: `pt XOR key = ct` 
plaintext attack: `ct XOR key = (pt XOR key) XOR key = pt XOR (key XOR key) = pt XOR NULL = pt`.

To decrypt the ct, we can reuse the encryption scheme and bruteforce the first four bytes of the key assuming the pt start with "EPT{". The script below leaks one byte in the key at a time. To find the next byte, update the key with the leaked byte and the char check in the main function with the pt we are looking for.

```python
from hashlib import sha256
import random
import base64

def main(flag, rand):
    flag1 = list(flag)
    for i in range(len(flag1) - len(rand) + 1):
        for j in range(len(rand)):
            flag1[i+j] = flag1[i+j] ^ rand[j]
    out = bytes(flag1)
    if chr(out[0]) == "E":
        print(rand)
        print(out)

if __name__=='__main__':
    with open("output.txt", "rb") as f:
        flag = f.read()
    flag = base64.b64decode(flag)
    for i in range(0xff):
        key = i.to_bytes(1, 'big')+b"\x41"*7
        main(flag, key)
```

Here is the output from each leak

```
┌──(kali㉿kali)-[~/Documents/ctf/ept]
└─$ python3 ./brute.py
b'\x9cAAAAAAA'
b'E\x97\xa0\xc7\xdbH\xcb"*\x1e\x19\x0e\x13\x1ep2\x1e)u3%\x1ev.\x1e, *r\xd9\xd2\x92\xc8\x01\xc7'

┌──(kali㉿kali)-[~/Documents/ctf/ept]
└─$ python3 ./brute.py
b'\x9c\x86AAAAAA'
b'EPg\x00\x1c\x8f\x0c\xe5\xed\xd9\xde\xc9\xd4\xd9\xb7\xf5\xd9\xee\xb2\xf4\xe2\xd9\xb1\xe9\xd9\xeb\xe7\xed\xb5\xd9\xd2\x92\xc8\x01\xc7'

┌──(kali㉿kali)-[~/Documents/ctf/ept]
└─$ python3 ./brute.py
b'\x9c\x86rAAAAA'
b'EPT3/\xbc?\xd6\xde\xea\xed\xfa\xe7\xea\x84\xc6\xea\xdd\x81\xc7\xd1\xea\x82\xda\xea\xd8\xd4\xde\x86\xea\xd2\x92\xc8\x01\xc7'

┌──(kali㉿kali)-[~/Documents/ctf/ept]
└─$ python3 ./brute.py
b'\x9c\x86r\tAAAA'
b'EPT{g\xf4w\x9e\x96\xa2\xa5\xb2\xaf\xa2\xcc\x8e\xa2\x95\xc9\x8f\x99\xa2\xca\x92\xa2\x90\x9c\x96\xce\xa2\x9a\x92\xc8\x01\xc7'
```
We have successfully leaked half ot the key. Now we have to bruteforce and guess the rest.
`\x9c\x86\x72\x09`

Using the bruteforce file below we inspect the output for patterns that we can abuse to find the flag. We see that there is a string `ck_XOR_1s_h4rd_7o_mak3_go` that looks a lot like a flag. 

* [brute.py](brute.py)

```python
#output is abbreviated and only shows the last four chars of the bruteforced key
0x180xfe0xad0xb6
b'EPT{>\x12}ck_XOR_1s_h4rd_7o_mak3_gol\x1a0'
--
0x180xfe0xe00xfb
b'EPT{>\x120ck_XOR_1s_h4rd_7o_mak3_gol\x1a}'
--
0x190x6d0x3f0xb6
b'EPT{?\x80}ck_XOR_1s_h4rd_7o_mak3_gom\x880'
--
0x190x6d0x720xfb
b'EPT{?\x800ck_XOR_1s_h4rd_7o_mak3_gom\x88}'
--
0x190x6e0x3c0xb6
b'EPT{?\x83}ck_XOR_1s_h4rd_7o_mak3_gom\x8b0'
--
0x190x6e0x710xfb
b'EPT{?\x830ck_XOR_1s_h4rd_7o_mak3_gom\x8b}'
--
0x190x6f0x3d0xb6
b'EPT{?\x82}ck_XOR_1s_h4rd_7o_mak3_gom\x8a0'
--
0x190x6f0x700xfb
b'EPT{?\x820ck_XOR_1s_h4rd_7o_mak3_gom\x8a}'
```
We have the following partial flag `EPT{XXXck_XOR_1s_h4rd_7o_mak3_goXXX`
Guessing that the start might be "block" becuase of the challenge description, and the last char is "}", we create a simple bruteforce of the flag based on these assumptions. Since we got the SHA256 sum of the flag in the challenge, we use this to validate the flag. This could also be done with hashcat with a custom mask.
* [validator.py](validator.py)

And we get our flag.
```
┌──(kali㉿kali)-[~/Documents/ctf/ept]
└─$ python3 ./validator.py
EPT{bl0ck_XOR_1s_h4rd_7o_mak3_go0d}
```
