# BLOXOR
**Author:** Surperior

**Description:**  
Simple XOR is too easy to crack. Blocks will make it strong, without any weaknesses. Right?

---

## Solve
**by mathias & Tuxern**

The challenge BLOXOR is a nod to block XOR encryption, a known concept with an acknowledged weakness in XOR encryption. However, the twist here is in the implementation. Upon inspecting the code, it's apparent that the challenge doesn't utilize block XOR in the traditional sense. The mechanism uses an 8-byte key, encrypting the first 8 bytes of the data. Then, rather than moving to the next 8 bytes, it shifts one byte over and encrypts using the result of the previous encryption. This process repeats until the entire input is encrypted, with the 1st byte remaining unchanged and the 9th byte being newly encrypted, and so on.

To decrypt this, we utilized the non-commutative property of XOR. Since XOR operations are not order-dependent, as shown below:

A ⊕ B = C <=> A ⊕ C = A

Given that we know parts of the result, specifically the “EPT{“ and “}”, which accounts for 5 of the 8 bytes, we can manually deduce these by performing the XOR operation on the encrypted string with the known input. For the remaining 3 bytes, we employed a brute force approach, iterating through all possible key combinations, a total of 256^3 options. The correct key is identified using a sha256 validation, ensuring that only one of the 16,777,216 possibilities is marked as correct.

To understand how this encryption method works, refer to this Google Sheet: [Encryption Method Sheet](https://docs.google.com/spreadsheets/d/1tchPMqmzCoT-pzNwhI8or0AhpHwMR7cJiCFTZNRzBmY/edit?usp=sharing). 

Note that the sheet uses randomized values that change with each update tick. These values are not related to the actual task. To experiment with different values, you can clone the sheet via File -> Make a copy. The sheet demonstrates this process with 16 bytes, whereas the actual challenge involved 35 bytes.

By utilizing this method we were able to decrypt the flag: `EPT{bl0ck_XOR_1s_h4rd_7o_mak3`
