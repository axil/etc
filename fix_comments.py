filename = r'D:\Utilities\Development\Python\Lib\site-packages\notebook\static\notebook\js\main.min.js'
os.rename(filename, filename+'~')
fin, fout = open(filename+'~'), open(filename, 'w')
for line in fin:
    fout.write(line.replace(
        'padding == null ? " "',
        'padding == null ? ""')

