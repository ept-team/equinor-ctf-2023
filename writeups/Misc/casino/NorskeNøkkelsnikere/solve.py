from pwn import *
from mt19937predictor import MT19937Predictor

def skipBetting(pro, predictor):
    pro.recvuntil(b"do?")
    pro.sendline(b"1")
    pro.recvuntil(b"bet?")
    pro.sendline(b"0")
    predictor.setrandbits(0, 32)

def betToGetInfo(pro,predictor):
    pro.recvuntil(b"do?")
    pro.sendline(b"1")
    pro.recvuntil(b"bet?")
    pro.sendline(b"30")
    pro.recvuntil(b"on?")
    pro.sendline(b"-1")
    r = pro.recvuntil(b"You have").decode().splitlines()
    for l in r:
        if "house rolled" in l:
            g = int(l.split()[-1])
            predictor.setrandbits(g, 32)

def betItAll(pro, predictor, coins):
    pro.recvuntil(b"do?")
    pro.sendline(b"1")
    pro.recvuntil(b"bet?")
    pro.sendline(str(coins).encode())
    pro.recvuntil(b"on?")
    cho = int(predictor.getrandbits(32))
    pro.sendline(str(cho).encode())
    r = pro.recvuntil(b"You have").decode().splitlines()
    corr = False
    for l in r:
        if "Congratulations" in l:
            corr = True
    if not corr:
        print("Guess was wrong, try again")
        exit()
    return 3*coins

coins = 100
predictor = MT19937Predictor()
pro = process(["python"]  + ["EPTCTF2023/casino/main.py"])
#pro = remote("io.ept.gg", 38562)
skipBetting(pro, predictor)
while coins < 1337:
    betToGetInfo(pro, predictor)
    coins-=30
    
    for i in range(2,397):
        skipBetting(pro, predictor)
    
    betToGetInfo(pro, predictor)
    coins-=30

    for i in range(398,624):
        skipBetting(pro, predictor)

    coins = betItAll(pro, predictor, coins)

pro.sendline(b"2")
r = pro.recvall()
print(r.decode().splitlines()[-1])
