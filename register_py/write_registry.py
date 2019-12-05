import os
from contextlib import suppress

from winreg import *
def write(path, value, root=HKEY_CURRENT_USER):
    path, name = os.path.split(path)
    with OpenKey(root, path, 0, KEY_WRITE) as key:
        SetValueEx(key, name, 0, REG_SZ, value)

def read(path, root=HKEY_CURRENT_USER):
    path, name = os.path.split(path)
    with suppress(FileNotFoundError), OpenKey(root, path) as key:
        return QueryValueEx(key, name)[0]

print(read(r'Python.File\Shell\open\command\\', HKEY_CLASSES_ROOT))

def which(fn):
    for path in os.environ['PATH'].split(';'):
        if fn in os.listdir(path):
            return path

print(which('python.exe'))

write(r'Python.File\Shell\open\command\\', f'"{which("python.exe")}\\python.exe" "%L" %*', HKEY_CLASSES_ROOT)

print(read(r'Python.File\Shell\open\command\\', HKEY_CLASSES_ROOT))

