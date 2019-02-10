import sys, os
from tempfile import TemporaryDirectory
from subprocess import run as _run, PIPE, check_output
import json

def clean(data):
    z = json.loads(data)
    for c in z['cells']:
        c['outputs'] = []
        c['execution_count'] = None
    return json.dumps(z, indent=1, ensure_ascii=False)


def run(*args, **kwargs):
    print(args)
    _run(*args, **kwargs)

filename = sys.argv[1]
with TemporaryDirectory() as tempdir:
    head = os.path.join(tempdir, 'head.ipynb')
    working = os.path.join(tempdir, 'working.ipynb')
    root = check_output('git rev-parse --show-toplevel').decode('utf8').rstrip()
    cur_dir = os.getcwd().replace('\\', '/')
    relative_dir = os.path.relpath(cur_dir, root)
    tree_path = os.path.join(relative_dir, filename).replace('\\', '/')
    run(f'git show HEAD:{tree_path} | jupytext --from ipynb --to py >{head}', shell=True)
    run(f'jupytext {filename} --to py -o - >{working}', shell=True)
    run(['gvim', '-d', head, working])




