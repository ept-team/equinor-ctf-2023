#!/usr/bin/env python3
import random

def main():
    ept_coins = 100
    while True:
        print()
        print("You have", ept_coins, "EPT coins")
        print(" 1. Make a bet\n 2. Cash out")
        action = int(input("What would you like to do? "))
        if action == 1:
            n = random.getrandbits(32)
            bet = int(input("How much do you want to bet? "))
            if bet < 30:
                print("Sorry, but our minimum betting amount is 30 EPT coins")
                continue
            if bet > ept_coins:
                print("Sorry, but you don't have enough EPT coins to bet that much")
                continue
            ept_coins -= bet
            print("You bet", bet, "EPT coins")
            target = int(input("What number do you want to bet your coins on? "))
            print("You bet", bet, "EPT coins on", target)
            print("The house rolled", n)
            if n == target:
                print("Congratulations! You won", bet * 3, "EPT coins!")
                ept_coins += bet * 3
            else:
                print("Sorry, but you lost your bet this time")
        elif action == 2:
            if ept_coins > 1337:
                print("Seems you made quite a bit of change tonight. Here, take a flag as well:", open("flag.txt").read())
            else:
                print("Hope you had fun, see you next time!")
            exit()
        else:
            print("Sorry, but we don't play that game here at this house. You are free to try the casino down the road instead though.")
            exit()

if __name__ == "__main__":
    main()