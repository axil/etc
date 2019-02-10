import sys, os
from tempfile import TemporaryDirectory
from subprocess import run, PIPE
import json

def clean(data):
    z = json.loads(data)
    for c in z['cells']:
        c['outputs'] = []
        c['execution_count'] = None
    return json.dumps(z, indent=1, ensure_ascii=False)


filename = sys.argv[1]
with TemporaryDirectory() as tempdir:
    with open(os.path.join(tempdir, 'head.ipynb'), 'wb') as temp1, \
         open(os.path.join(tempdir, 'working.ipynb'), 'wb') as temp2:
        res = run(['git', 'show', f'HEAD:{filename}'], stdout=PIPE)
        temp1.write(clean(res.stdout).encode('utf8'))
        temp2.write(clean(open(filename, encoding='utf8').read()).encode('utf8'))
    run(['gvim', '-d', temp1.name, temp2.name])




