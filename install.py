#!/usr/bin/env python

import os, sys, shutil

def install(filename, install_dir):
    print 'installing %s into %s' % (filename, install_dir)
    try:
        os.makedirs(install_dir)
        print 'dir created'
    except OSError:
        print 'dir not created'

    try:
        shutil.copy(filename, install_dir)
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

if __name__ == '__main__':
#    python_vim()
    git_ff()
