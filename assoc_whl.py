"""Install GUI integration on Windows"""

import sys

try:
  import winreg
except ImportError:  
  import _winreg as winreg

SZ = winreg.REG_SZ
with winreg.CreateKey(winreg.HKEY_CURRENT_USER, "Software\Classes\.whl") as k:
    winreg.SetValue(k, "", SZ, "Python.Wheel")
    with winreg.CreateKey(k, "OpenWithProgIds") as openwith:
        winreg.SetValueEx(openwith, "Python.Wheel", 0, winreg.REG_NONE, b'')

with winreg.CreateKey(winreg.HKEY_CURRENT_USER, "Software\Classes\Python.Wheel") as k:
    winreg.SetValue(k, "", SZ, "python wheel")
    with winreg.CreateKey(k, "shell\open\command") as launchk:
        winreg.SetValue(launchk, "", SZ, 'cmd /c pip.exe install "%1" & pause')

try:
    from win32com.shell import shell, shellcon
    shell.SHChangeNotify(shellcon.SHCNE_ASSOCCHANGED, shellcon.SHCNF_IDLIST, None, None)
except ImportError:
    print("You may need to restart for association with .ipynb files to work")
    print("  (pywin32 is needed to notify Windows of the change)")
