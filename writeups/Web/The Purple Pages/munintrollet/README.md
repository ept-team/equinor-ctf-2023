# THE PURPLE PAGES
**Author: potatochips4dinner**

**Description:**  
Call me, maybe

**Site:** purplepages

---

## Solve
**By A.Meland**

### WRITEUP – PURPLE PAGES – EPT 2023

When we open the website: [https://purplepages.io.ept.gg/](https://purplepages.io.ept.gg/), we were presented with this login page.

![Login Page](loginpage1.png)

My first thought when seeing a login page like this is to try some of the most common usernames and passwords. If that doesn’t work, I go over to SQL-injections. 

First, I tried admin – admin, but no luck here. I then tried a SQL-injection for the password, `' OR '1'='1' --`, and kept admin as username. And what do you know! It worked!

![Welcome Page](welcomepage1.png)

After successfully logging in using SQL-injection, we gained access to the system.

---

**Flag:** `EPT{ph0n3b00k_c3ntr4l_d4t4b453_d0wn}`
