#!/usr/bin/env python

import os, sys, shutil

def install(filename, install_dir):
    try:
        os.makedirs(install_dir)
    except OSError:
        pass

    try:
        shutil.copy(filename, install_dir)
    except shutil.Error:
        pass

def python_vim():
    install('python.vim',
        '%s%s/after/ftplugin' % (
            os.environ['HOME'],
            'vimfiles' if sys.platform == 'win32' else '/.vim'
    ))


def git_ff():
    if sys.platform == 'win32':
        return
    install('git-ff', os.environ['HOME'] + '/bin/')

if __name__ == '__main__':
    python_vim()
    git_ff()
