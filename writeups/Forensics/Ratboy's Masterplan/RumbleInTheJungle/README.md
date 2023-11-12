# Ratboy's Masterplan
Author: LOLASL

Flag: `EPT{p3nguins_p0larb3ars_4nd_r3m0te_acc3ss_t00ls}`
## Description
```
Intelligence suggests that someone in our organization is leaking sensitive information to an external entity. Our ultra-leet mega secure data loss prevention solution has not alerted on any such activity, but our tech team has managed to intercept a chunk of network traffic which we believe contain the rat's communication. Please find a way to get a peek at the leaked data. (<strike>Hackback</strike> Active Defense is not a crime?)
```

## Provided challenge files
* [ratboy.pcapng](ratboy.pcapng)


`hashcat -a 0 -m 5600 ./ratboy2.hash /usr/share/wordlists/rockyou.txt`

```
RATBOY_VIEW::.:8390f984cca995b8:ea128090784697741ea64f3d59fc9a18:0101000000000000060b801f32e6d9013db12b0da9e69eb40000000002001e0045004300320041004d0041005a002d0050004a003400360048005400470001001e0045004300320041
004d0041005a002d0050004a003400360048005400470004001e0045004300320041004d0041005a002d0050004a003400360048005400470003001e0045004300320041004d0041005a002d0050004a003400360048005400470007000800060b801f32e6d90106000
400020000000800300030000000000000000100000000200000c020e03b145cea97397445fb223e72ebde36c8ce2f0ccdd387d3cd9af581e28c0a00100000000000000000000000000000000000090000000000000000000000:millencolinnofx
```
