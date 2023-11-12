There are two things I needed to realize to complete this challenge.

The first is how the random module in python works. It is based on a Mersenne Twister which keeps 624 32 bit ints as state. However, to generate a new number only uses two of the integers in the current state plus one bit from another of the integers. This means that with 50% chance we can predict what number will be generated knowing only 2 of the numbers in the current state.

Once I realised this I just needed to figure out the second trick which is that we can make the code generate the random numbers without us having to bet. If we simply bet 0 we can make the program generate a number without us having to lose any money.

This is very useful since the first number we can try to guess is number 624. The number generated prior to this are all from the initial state and too hard to predict. Looking at the implementation of the random module one can see that to predict the 624th value we will need to know the value at state index 1 and 397. Therefore we bet 30 for each of these to get the value at these states. Then we skip the rest and make our guess on the 624th value.

We now have a 50% chance of tripling our money. If we fail we just start the program again. If we succeed we just repeat the process. The next time however, we also know the value at index 0 of the state. This is the number we need one bit from. Therefore we now have a 100% chance of guessing correct and our infinite money printer is complete.

The solution script is in solve.py. To actually predict the numbers I used the very nice [mersenne-twister-predictor package](https://github.com/kmyk/mersenne-twister-predictor/tree/master).