#!/usr/bin/env python

import os, sys, shutil

install_dir = '%s%s/after/ftplugin' % (
    os.environ['HOME'],
    'vimfiles' if sys.platform == 'win32' else '/.vim'
)

try:
    os.makedirs(install_dir)
except OSError:
    pass

try:
    shutil.copy('python.vim', install_dir)
except shutil.Error:
    pass
