import json, sys

z = json.load(open(sys.argv[1]))
print(z['content'])
