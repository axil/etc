#!/usr/bin/env python

import os, sys, shutil

BASE_DIR = os.path.realpath(os.path.dirname(__file__))

def install(filename, install_dir):
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

def python_vim():
    home = os.environ.get('HOME', os.environ['HOMEDRIVE'] + os.environ['HOMEPATH'])
    if sys.platform == 'win32':
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
    install('git-ff', os.environ['HOME'] + '/bin/')
    install('git-fixup', os.environ['HOME'] + '/bin/')

def run(cmd):
    print '* running', cmd
    os.system(BASE_DIR + '/' + cmd)

def get_abolish_the_python_way():
    PLUGIN_DIR = os.path.expanduser('~/.vim/plugin')
    if not os.path.exists(PLUGIN_DIR):
        os.mkdir(PLUGIN_DIR)
#    import urllib
#    urllib.urlretrieve('https://raw.githubusercontent.com/tpope/vim-abolish/master/plugin/abolish.vim', os.path.join(PLUGIN_DIR))
    import subprocess
    subprocess.call(('wget -P %s https://raw.githubusercontent.com/tpope/vim-abolish/master/plugin/abolish.vim' % PLUGIN_DIR).split())

def get_abolish():
    os.system('mkdir -p ~/.vim/plugin')
    os.system('wget -P ~/.vim/plugin https://raw.githubusercontent.com/tpope/vim-abolish/master/plugin/abolish.vim')


if __name__ == '__main__':
#    python_vim()
    git_ff()
    run('get_ack.sh')
    run('ln.zsh')
    get_abolish()
