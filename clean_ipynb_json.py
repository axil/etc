import sys
import json

for filename in sys.argv[1:]:
    assert filename.endswith('.ipynb')
    z = json.load(open(filename, encoding='utf8'))
    for c in z['cells']:
        c['outputs'] = []
        c['execution_count'] = None
    fout_name = filename.replace('.ipynb', '-clean.ipynb')
    json.dump(z, open(fout_name, 'w', encoding='utf8'), indent=1, ensure_ascii=False)
print('ok')
