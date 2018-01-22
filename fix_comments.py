import os
filename = r'D:\Utilities\Development\Python\Lib\site-packages\notebook\static\notebook\js\main.min.js'
os.rename(filename, filename+'~')
fin, fout = open(filename+'~', encoding='utf8', newline=''), open(filename, 'w', encoding='utf8')
for line in fin:
    fout.write(line.replace(
        'padding == null ? " "',
        'padding == null ? ""'))

