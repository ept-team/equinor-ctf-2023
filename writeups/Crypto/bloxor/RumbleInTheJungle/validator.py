from hashlib import sha256

for i in range(33,126):
    for h in range(33,126):
        flag = "EPT{block_XOR_1s_h4rd_7o_mak3_go"+chr(i)+chr(h)+"}"
        if sha256(str.encode(flag)).digest() == b'\x057\xa2\xe4\xbb\xd8\xa8\x84|1\x82\xbd\xe3\x0c\x9c{t\x1b\n\x14\xf2\xcc\xf0\xefR\x9c\xefvo3\x03\xa9':
            print(flag)
        flag = "EPT{bl0ck_XOR_1s_h4rd_7o_mak3_go"+chr(i)+chr(h)+"}"
        if sha256(str.encode(flag)).digest() == b'\x057\xa2\xe4\xbb\xd8\xa8\x84|1\x82\xbd\xe3\x0c\x9c{t\x1b\n\x14\xf2\xcc\xf0\xefR\x9c\xefvo3\x03\xa9':
            print(flag)
        flag = "EPT{Bl0ck_XOR_1s_h4rd_7o_mak3_go"+chr(i)+chr(h)+"}"
        if sha256(str.encode(flag)).digest() == b'\x057\xa2\xe4\xbb\xd8\xa8\x84|1\x82\xbd\xe3\x0c\x9c{t\x1b\n\x14\xf2\xcc\xf0\xefR\x9c\xefvo3\x03\xa9':
            print(flag)
        flag = "EPT{Block_XOR_1s_h4rd_7o_mak3_go"+chr(i)+chr(h)+"}"
        if sha256(str.encode(flag)).digest() == b'\x057\xa2\xe4\xbb\xd8\xa8\x84|1\x82\xbd\xe3\x0c\x9c{t\x1b\n\x14\xf2\xcc\xf0\xefR\x9c\xefvo3\x03\xa9':
            print(flag)
