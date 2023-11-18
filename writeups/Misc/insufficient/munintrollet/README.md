# INSUFFICIENT
**Author:** starsiv

## Description
This website is from a developer that left the company to focus 100% on CTFs. When he left, he was mumbling something about a secret he had hidden in the git repo... Can you help us find it? He is lazy and well known to clone git, deploy on the spot and leave everything...

Site: [insufficient.io.ept.gg](http://insufficient.io.ept.gg)

## Solve
**By Tuxern**

Sadly, we didn't realize this was one of the leaked challenges, and it gave 0 points, but still, it was a fun challenge.

### Investigation
I investigated the website insufficient.io.ept.gg and found several pieces of information that could be helpful in uncovering the secret hidden in the git repository by the developer:

- **Git Configuration:** The git configuration file revealed the origin repository as `git@github.com:lunarlattice/insufficient`. This indicates the original source of the repository on GitHub. [View Git Config](http://insufficient.io.ept.gg/.git/config)

- **Git Objects:** I found a directory listing for Git objects, specifically two pack files: `pack-532d48c0f53ffd3bb8051bb78cf356823e6ed292.idx` and `pack-532d48c0f53ffd3bb8051bb78cf356823e6ed292.pack`. These files contain the actual contents of the Git objects and might hold the secret. [View Git Objects](http://insufficient.io.ept.gg/.git/objects/pack/)

- **Git Logs:** The Git logs show the initial clone operation from the GitHub repository `github.com:lunarlattice/insufficient`. This could indicate the starting point of the repository's history. [View Git Log for HEAD](http://insufficient.io.ept.gg/.git/logs/HEAD) and [Git Log for Main Branch](http://insufficient.io.ept.gg/.git/logs/refs/heads/main)

### Next Steps
To further investigate, we devised the following plan:

1. Examine the contents of the pack files in the Git objects directory.
2. Clone the repository from the GitHub URL mentioned in the git config to explore its complete history and check for any hidden branches, commits, or tags that might contain the secret.
3. Check the GitHub repository for any issues, pull requests, or wiki pages that might reference the secret.

### Commands Executed
```
wget --recursive --no-parent http://insufficient.io.ept.gg/.git/
```

### Terminal Output
```
dev@dev:~/ctf/git/insufficient.io.ept.gg$ ll
total 12
drwxr-xr-x 3 dev dev 4096 Nov 11 15:03 ./
drwxr-xr-x 3 dev dev 4096 Nov 11 15:03 ../
drwxr-xr-x 8 dev dev 4096 Nov 11 15:03 .git/
dev@dev:~/ctf/git/insufficient.io.ept.gg$ git init
Reinitialized existing Git repository in /home/dev/ctf/git/insufficient.io.ept.gg/.git/
dev@dev:~/ctf/git/insufficient.io.ept.gg$ git reset --hard
HEAD is now at c093df8 add dockerfile and cleanup
dev@dev:~/ctf/git/insufficient.io.ept.gg$ git log --oneline
c093df8 (HEAD -> main, origin/main, origin/HEAD) add dockerfile and cleanup
1fee9c5 move this one
a36d52f Create notes.md
41c349f move this one
90357d3 Create notes.md
1cf376e changed presentation
8a09ab3 startfiles
dedb1ee Initial commit
dev@dev:~/ctf/git/insufficient.io.ept.gg$ git branch -a
git tag
warning: ignoring broken ref refs/heads/index.html
warning: ignoring broken ref refs/index.html
warning: ignoring broken ref refs/remotes/index.html
warning: ignoring broken ref refs/remotes/origin/index.html
warning: ignoring broken ref refs/tags/index.html
* main
  remotes/origin/HEAD -> origin/main
  remotes/origin/main
  remotes/origin/secrets
warning: ignoring broken ref refs/tags/index.html
dev@dev:~/ctf/git/insufficient.io.ept.gg$ cat index.html
...
dev@dev:~/ctf/git/insufficient.io.ept.gg$ ls
3drectangle.js  Dockerfile  README.md  ept.png  index.html  starfield.js
```

### Finding the Secret
Running `git checkout secrets` revealed a file which contained the flag.

Flag: `EPT{1n5uff1c13n7_cr3d3n7141_hy613n3}`
