from shutil import move
from os import unlink, chdir
from itertools import tee

PREV_LINE = r"if (target instanceof codecell.CodeCell)"
PATTERN = r"target.set_text(contents.join('\n\n'));"
REPLACEMENT = r"target.set_text(contents.join('\n'));"

def pairwise(iterable):
    "s -> (s0,s1), (s1,s2), (s2, s3), ..."
    a, b = tee(iterable)
    next(b, None)
    return zip(a, b)

matches = 0
chdir(r'C:\Utilities\Development\Python\Lib\site-packages\notebook\static\notebook\js')

is_first = True
with open('main.min.js.new', 'w', encoding='utf8') as fout:
    for prev, curr in pairwise(open(r'main.min.js', encoding='utf8')):
        if is_first:
            fout.write(prev)
            is_first = False
        if PREV_LINE in prev and PATTERN in curr:
            curr = curr.replace(PATTERN, REPLACEMENT)
            matches += 1
        fout.write(curr)

if matches == 1:
    unlink('main.min.js')
    move('main.min.js.new', 'main.min.js')
    print('file patched ok')
else:
    print('expecting 1 match, found %d matches, aborting' % matches)
    unlink('main.min.js.new')
    
