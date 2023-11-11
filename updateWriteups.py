from os import listdir, makedirs, walk
from os.path import isfile, join, exists, basename
text = """
# equinor-ctf-2022
Educational guides, writeups and challenges resources for the 2022 Equinor CTF

## Writeups

"""
for category in listdir("./writeups"):
    if category.startswith(".") or isfile(category):
        continue
    text += f'### {category}\n'
    for chall in listdir(f'./writeups/{category}'):
        text += (f'  \n**{chall}**  \n')
        for writeup in next(walk(f'./writeups/{category}/{chall}'))[1]:
            url = f'/writeups/{category}/{chall}/{writeup}'.replace(' ', '%20')
            text += f"* [{writeup}]({url})  \n"


open('README.md', 'w').write(text)