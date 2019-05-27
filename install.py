#!/usr/bin/env python

import os, sys, shutil, stat

BASE_DIR = os.path.realpath(os.path.dirname(__file__))

def install(filename, install_dir, make_executable=False):
    install_dir = os.path.expanduser(install_dir)
    print('* installing %s into %s' % (filename, install_dir))
    try:
        os.makedirs(install_dir)
        print('dir created')
    except OSError:
        print('dir not created')

    try:
        shutil.copy(os.path.join(BASE_DIR, filename), install_dir)
        print('file copied')
    except shutil.Error:
        print('file not copied')

    if make_executable:
        try:
            os.chmod(os.path.join(install_dir, filename), 0o766)
            print('file made executable')
        except:
            from traceback import format_exc
            print('couldn\'t make file executable: ' + format_exc())

def get_home():
    return os.environ.get('HOME', os.environ['HOMEDRIVE'] + os.environ['HOMEPATH'])

def python_vim():
    home = os.environ.get('HOME')
    if sys.platform == 'win32':
        home = get_home()
        if home[-1] not in ['/', '\\']:
            home += '/'
    install('python.vim',
        '%s%s/after/ftplugin' % (
            home,
            'vimfiles' if sys.platform == 'win32' else '/.vim'
    ))


def git_ff():
    if sys.platform == 'win32':
        install('git-ff', r"C:\Program Files\Git\mingw64\libexec\git-core")
    else:
        install('git-ff', os.environ['HOME'] + '/bin/', True)
        install('git-track', os.environ['HOME'] + '/bin/', True)
#    install('git-fixup', os.environ['HOME'] + '/bin/')

def run(cmd):
    print('* running', cmd)
    os.system(BASE_DIR + '/' + cmd)

def fetch(url, path):
    import urllib.request, urllib.parse, urllib.error
    path = os.path.expanduser(path)
    if not os.path.exists(path):
        os.makedirs(path)
    filename = os.path.basename(url)
#    print filename
#    print os.path.join(path, filename)
    urllib.request.urlretrieve(url, os.path.join(path, filename))

def get_abolish():
    import subprocess
#    import urllib
#    urllib.urlretrieve('https://raw.githubusercontent.com/tpope/vim-abolish/master/plugin/abolish.vim', os.path.join(PLUGIN_DIR))
#    subprocess.call(('wget -P %s https://raw.githubusercontent.com/tpope/vim-abolish/master/plugin/abolish.vim' % PLUGIN_DIR).split())
#    subprocess.call(('wget -P %s https://raw.githubusercontent.com/tpope/vim-abolish/master/doc/abolish.txt' % PLUGIN_DOC_DIR).split())
    fetch('https://raw.githubusercontent.com/tpope/vim-abolish/master/plugin/abolish.vim', '~/.vim/plugin')
    fetch('https://raw.githubusercontent.com/tpope/vim-abolish/master/doc/abolish.txt', '~/.vim/doc')

def get_abolish_external():
    os.system('mkdir -p ~/.vim/plugin')
    os.system('wget -P ~/.vim/plugin -r -l 0 https://raw.githubusercontent.com/tpope/vim-abolish/master/plugin/abolish.vim')
    os.system('curl -LO ~/.vim/doc -r -l 0 https://raw.githubusercontent.com/tpope/vim-abolish/master/doc/abolish.txt')

def e(path):
    return os.path.expanduser(path)

def get_pyflakes():
    d = e('~/pyflakes-vim')
    os.system('git clone https://github.com/axil/pyflakes-vim.git ' + d)
    os.chdir(d)
    os.system('git submodule init')
    os.system('git submodule update')
    if sys.platform == 'win32':
        if not os.path.exists(e('~/vimfiles/ftplugin/python')):
            os.makedirs(e('~/vimfiles/ftplugin/python'))
        os.system('cp -r ~/pyflakes-vim/ftplugin/python/* ~/vimfiles/ftplugin/python')
        os.chdir(e('~'))
    else:
        os.system('mv ~/pyflakes-vim/ftplugin ~/.vim')
    os.system('rm -rf ~/pyflakes-vim')

def install_vim_files():
    install('vi.bat', r'c:\windows\system32')
    install('_guicolors', r'C:\Utilities\Editors\Vim')

def install_dotfiles():
    home = get_home()
    for f in '.vimrc .gitconfig .gitignore'.split(): 
        install(f, home)

def install_log_vim_syntax():
    install('log.vim', '~/.vim/syntax/')


if __name__ == '__main__':
#    python_vim()
#    git_ff()
#    if sys.platform == 'win32':
#        install_vim_files()
#        install_dotfiles()
#    else:
#        run('get_ack.sh')
#        run('ln.zsh')
#    get_abolish()
#    get_pyflakes()
    install_log_vim_syntax()
