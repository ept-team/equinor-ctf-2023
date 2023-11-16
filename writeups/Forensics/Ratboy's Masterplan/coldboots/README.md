# Ratboys Masterplan

### Description
```
Intelligence suggests that someone in our organization is leaking sensitive information to an external entity. Our ultra-leet mega secure data loss prevention solution has not alerted on any such activity, but our tech team has managed to intercept a chunk of network traffic which we believe contain the rat's communication. Please find a way to get a peek at the leaked data. (Hackback Active Defense is not a crime?)
```

### Attached file
`ratboy.pcapng`

### Analysis
We are presented with a capture file. So we fire up wireshark to see what we can see.  
The whole capture except some DNS traffic up top consists of raw TCP transfers. But the data is mostly jibberish.

![Wireshark capture](./shark-1.png)

But upon closer inspection of this TCP stream we notice that this dialog starts with NTLMSSP negotiation. This is very interesting, and it means that we have cute little hashes flying unencrypted over the wire.  
Now you could theoretically carve out the information you would need from the capture file manually, but that would be strenuous work. Luckily there exists a wonderful tool for this: [NTLMRawUnHide.py](https://github.com/mlgualtieri/NTLMRawUnHide/tree/master)  

With this in our toolbelt, dumping crackable hashes is a breeze.  
Running this command will give us a overview over all NTLMSSP Messages and recovered hashes.
```bash
$ python3 NTLMRawUnHide/NTLMRawUnHide.py -i ratboy.pcapng

...
Found NTLMSSP Message Type 1 : Negotiation

Found NTLMSSP Message Type 2 : Challenge
    > Server Challenge       : 9546ceb040d47edc 

Found NTLMSSP Message Type 3 : Authentication
    > Domain                 :  
    > Username               : admin 
    > Workstation            : DESKTOP-RR6S7JQ 

NTLMv2 Hash recovered:
admin::DESKTOP-RR6S7JQ:9546ceb040d47edc:e81b5ac7f2e95fa6f1de548275844335:01010000000000001c26353032e6d9016bf36d25640cde9a0000000002001e0045004300320041004d0041005a002d0050004a003400360048005400470001001e0045004300320041004d0041005a002d0050004a003400360048005400470004001e0045004300320041004d0041005a002d0050004a003400360048005400470003001e0045004300320041004d0041005a002d0050004a0034003600480054004700070008001c26353032e6d90106000400020000000800300030000000000000000100000000200000c020e03b145cea97397445fb223e72ebde36c8ce2f0ccdd387d3cd9af581e28c0a00100000000000000000000000000000000000090000000000000000000000
...

```

With a `-o` we should get a crackable hash outputfile. But there is actually a typo in this part of the script. Change `output` to `outfile` on line 240 and you are good to go.  

```bash
$ python3 NTLMRawUnHide/NTLMRawUnHide.py -i ratboy.pcapng -o hash_output
$ john --wordlist=/usr/share/wordlists/rockyou.txt hash_output 
Warning: detected hash type "netntlmv2", but the string is also recognized as "ntlmv2-opencl"
Use the "--format=ntlmv2-opencl" option to force loading these as that type instead
Using default input encoding: UTF-8
Loaded 4 password hashes with 4 different salts (netntlmv2, NTLMv2 C/R [MD4 HMAC-MD5 32/64])
Will run 4 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
millencolinnofx  (ratboy_view)
```

Houston, we have credentials!  
Now, on to the fun part. The next step actually requires us to connect to a live host. 
Since the traffic occurs on port 4899 we can assume that this is radmin traffic. This is a fairly common remote desktop protocol. We can use radmin's own client `Radmin Viewer`.  
Then we grab the hostname which was resolved in the DNS lookup at the very top of our pcap: `ratboy.lolasl.com`. Keep in mind that the user is view only so we have to select `View Only`. Enter your credentials and connect to the host. We immidiately see a desktop with activity, but we have no control. Eventually the user will open `flag.txt` and we can take our screenshot.

Thank you LOLASL for a cool challenge.
