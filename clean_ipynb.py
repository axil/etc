import sys
import json

for filename in sys.argv[1:]:
    assert filename.endswith('.ipynb')
    fout_name = filename[:-6] + '.py'
    with open(fout_name, 'w', encoding='utf8') as fout:
        data = json.load(open(filename, encoding='utf8'))
        for c in data['cells']:
            fout.write(''.join(c['source']) + '\n\n')
print('ok')
