#!/usr/bin/env python

import os, sys, shutil, stat

BASE_DIR = os.path.realpath(os.path.dirname(__file__))

def install(filename, install_dir, make_executable=False):
    print '* installing %s into %s' % (filename, install_dir)
    try:
        os.makedirs(install_dir)
        print 'dir created'
    except OSError:
        print 'dir not created'

    try:
        shutil.copy(os.path.join(BASE_DIR, filename), install_dir)
        print 'file copied'
    except shutil.Error:
        print 'file not copied'

    try:
        os.chmod(os.path.join(install_dir, filename), 0o766)
        print 'file made executable'
    except:
        from traceback import format_exc
        print 'couldn\'t make file executable: ' + format_exc()

def python_vim():
    home = os.environ.get('HOME')
    if sys.platform == 'win32':
	home = os.environ.get('HOME', os.environ['HOMEDRIVE'] + os.environ['HOMEPATH'])
        if home[-1] not in ['/', '\\']:
            home += '/'
    install('python.vim',
        '%s%s/after/ftplugin' % (
            home,
            'vimfiles' if sys.platform == 'win32' else '/.vim'
    ))


def git_ff():
    if sys.platform == 'win32':
        return
    install('git-ff', os.environ['HOME'] + '/bin/', True)
    install('git-track', os.environ['HOME'] + '/bin/', True)
#    install('git-fixup', os.environ['HOME'] + '/bin/')

def run(cmd):
    print '* running', cmd
    os.system(BASE_DIR + '/' + cmd)

def fetch(url, path):
    import urllib
    path = os.path.expanduser(path)
    if not os.path.exists(path):
        os.mkdir(path)
    filename = os.path.basename(url)
#    print filename
#    print os.path.join(path, filename)
    urllib.urlretrieve(url, os.path.join(path, filename))

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

def get_pyflakes():
    os.system('git clone git@github.com:axil/pyflakes-vim.git ~/pyflakes-vim')
    os.chdir(os.path.expanduser('~/pyflakes-vim'))
    os.system('git submodule init')
    os.system('git submodule update')
    os.system('mv ~/pyflakes-vim/ftplugin ~/.vim')
    os.system('rm -rf ~/pyflakes-vim')


if __name__ == '__main__':
#    python_vim()
    git_ff()
#    run('get_ack.sh')
#    run('ln.zsh')
#    get_abolish()
#    get_pyflakes()
