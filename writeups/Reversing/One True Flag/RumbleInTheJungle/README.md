# One True Flag 
## RumbleInTheJungle

This challenge is an x64 ELF file that asks the user for a flag and checks the flag in three parts.

### Part1

Part one is a simple check on the flag format and the length of the flag. 
The length of the flag must be 17 characters long. 

### Part2

Part2 is responsible for checking every even index of the flag-body. These characters must fulfill 5 equations:

```
3 * (characters[0]-48) + 3 * (characters[1]-48) + 7 * (characters[2]-48) + 1 * (characters[3]-48) + 9 * (characters[4]-48) + 3 * (characters[5]-48) == 122
6 * (characters[0]-48) + 1 * (characters[1]-48) + 8 * (characters[2]-48) + 5 * (characters[3]-48) + 4 * (characters[4]-48) + 1 * (characters[5]-48) == 127
9 * (characters[0]-48) + 2 * (characters[1]-48) + 9 * (characters[2]-48) + 2 * (characters[3]-48) + 7 * (characters[4]-48) + 3 * (characters[5]-48) == 174
2 * (characters[0]-48) + 5 * (characters[1]-48) + 4 * (characters[2]-48) + 3 * (characters[3]-48) + 4 * (characters[4]-48) + 3 * (characters[5]-48) == 87
1 * (characters[0]-48) + 6 * (characters[1]-48) + 4 * (characters[2]-48) + 7 * (characters[3]-48) + 7 * (characters[4]-48) + 7 * (characters[5]-48) == 132
```

This can easily be solved by z3 and was done by by using the script [part2.py](part2.py)

By now, we had `EPT{X8X1X5X3X4X7}` were the `X`'s are still unknown.

### Part 3

This was the trickiest part of the three. In this part, we had 6 characters available were each were responsible for unique instructions. 

The first section in this part extracted the known numbers from part2 and added this to an array. The purpose of the next section, was to create a loop that iterated over every index in the array and decremented that value by one until the value was 0 such that the sum of every byte in the array was 0. To accomplish this, we had to select the correct combination of characters to fill in the unknowns in the flag. We had 6 characters available: `delrsu`. Each of these characters represented seperate instructions:

```
d: Decrement selected index in the array by one
e: The possible operations:
    if saved_position_ptr <= 0: exit loop;
    elif selectedByte <= 0: --saved_position_ptr;
    else opcodeNumber = saved_positions[saved_position_ptr-1];
l: index -= 1 (Select previous index in the array)
r: index += 1 (Select next index in the array)
s: Save position of current character
u: Increment selected index in the array by one
```

In the start of the second section, the first character in the flag body is selected, the first index in the array is selected and a second array of length 2 is created. The purpose of the second array is to save locations in the flag that the program can "jump" to.

To create a loop that would iterate over the array of 6 bytes and decrement them until all bytes are 0, we used a combination of dynamic analysis and logical thinking to create the final flag:

`EPT{s8s1d5e3r4e7}`

The way this works is that it first saves the positions of the first `s`-es. Then decrement the selected byte and check if the selected byte is zero. If the selected byte is less than er equal to 0, the variable saved_position_ptr was decremented by one, ie. pointing to the first `s` in the flag. If the selected byte is greater than 0, "jump" to the second `s` and continue execution from there. That means that the program would decrement every byte in the array until it became 0. 

When the selected byte is zero and the saved_position_ptr was decremented by one, the program would select the next byte in the array and then jump to the first `s`. If every byte in the array was zero, the last section in part3 would return the highest value from the array. If that was zero, the program would print `You have found the one true flag! Congratulation!` and the challenge was complete. 

## Flag
`EPT{s8s1d5e3r4e7}`

