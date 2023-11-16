# NOAH’S ARK
**Author:** Mattis  


## Description
Solve the puzzle and save all the animals. Show the solved puzzle to EPT staff to receive the flag. Each participant receives a random puzzle of similar difficulty from a pool.

### Rules:
- No phones allowed in the IQ puzzle area. Penalties apply for rule violations.
- Team collaboration is permitted.
- Leaving the puzzle area requires forfeiting the attempt. A new puzzle will be given upon re-entry.

![Noah's Ark Puzzle](https://ministryark.com/katy/wp-content/uploads/2018/01/Noahs-Ark-960x675.jpg)

---

## Solve
**By mathias & Lise??**

### Noah's Ark Puzzle Analysis

**Basics:**  
The puzzle begins with two animals on a grid. The objective is to place all animals next to their kin of the same color, filling every space and placing all pieces upright.

![](1.png) 

**Initial Observations:**  
Each piece occupies either 2 or 3 grid spaces. Notably, the grid's dimensions vary, implying that each piece has a unique placement.

![](2.png) 

### Strategy and Solution Process

**Starting Point:**  
Consider an example puzzle where the valid pentominoes are 1, 2, 4, 7, and 8. Options 7 and 2 are quickly discarded due to leaving impractical free spaces.

**Restrictive Cases Analysis:**  
The key strategy involves identifying and ruling out restrictive cases. For instance, using pentomino number 8 creates difficult-to-fill spaces.

![](3.png) 

**Option Analysis:**  
We proceed to analyze each option by testing the placement of pieces and the implications for filling the remaining spaces.

- **Option 1 (Hippo placement):** Leads to impossible configurations for the lion and other spaces.
- **Options 2 and 3:** Split the grid unfeasibly.
- **Option 4:** Too restrictive; lion pieces don’t fit.
- **Option 5:** Also unfeasible for lion pieces.


**Final Determination:**  
The only remaining viable option is the first placement of the horizontal zebra. This arrangement leaves 10 spaces on the left (a multiple of 5) and requires strategic placement on the right to ensure all spaces are filled optimally.

**Conclusive Steps:**  
- Starting from the right side, we find the only fitting pentominoes are for the elephants or giraffes.
- The most restrictive piece, the yellow lioness, helps in eliminating non-viable configurations.

### Conclusion
The solution process involves a systematic elimination of options based on the puzzle's constraints and the unique placement requirements of each piece. The final configuration, satisfying all conditions, represents the solution to the puzzle.

![](15.png) 

**Flag:** `EPT{puzzle_solv3r_megamind}`

---

*Note: This writeup details the logical approach and methodology employed to solve the "NOAH’S ARK" puzzle challenge in an educational context.*
