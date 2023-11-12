#!/usr/bin/env python3
from z3 import *

conditions = [
    "3 * (characters[0]-48) + 3 * (characters[1]-48) + 7 * (characters[2]-48) + 1 * (characters[3]-48) + 9 * (characters[4]-48) + 3 * (characters[5]-48) == 122",
    "6 * (characters[0]-48) + 1 * (characters[1]-48) + 8 * (characters[2]-48) + 5 * (characters[3]-48) + 4 * (characters[4]-48) + 1 * (characters[5]-48) == 127",
    "9 * (characters[0]-48) + 2 * (characters[1]-48) + 9 * (characters[2]-48) + 2 * (characters[3]-48) + 7 * (characters[4]-48) + 3 * (characters[5]-48) == 174",
    "2 * (characters[0]-48) + 5 * (characters[1]-48) + 4 * (characters[2]-48) + 3 * (characters[3]-48) + 4 * (characters[4]-48) + 3 * (characters[5]-48) == 87",
    "1 * (characters[0]-48) + 6 * (characters[1]-48) + 4 * (characters[2]-48) + 7 * (characters[3]-48) + 7 * (characters[4]-48) + 7 * (characters[5]-48) == 132",
    "characters[0] > 29",
    "characters[1] > 29",
    "characters[2] > 29",
    "characters[3] > 29",
    "characters[4] > 29",
    "characters[5] > 29"
]

characters = [BitVec(f'{i}',7) for i in range(6)] 
s = Solver()

for i in conditions:
    s.add(eval(i))

is_satisfiable = s.check()
print(is_satisfiable)
model = s.model()
solution_array = [model[characters[i]] for i in range(len(model))]

for char in solution_array:
    print(chr(int(str(char))))
