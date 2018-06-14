import sys
import json

for filename in sys.argv[1:]:
    assert filename.endswith('.ipynb')
    z = json.load(open(filename))
    for c in z['cells']:
        c['outputs'] = []
        c['execution_count'] = None
    fout_name = filename.replace('.ipynb', '-clean.ipynb')
    json.dump(z, open(fout_name, 'w'), indent=4)
print('ok')
