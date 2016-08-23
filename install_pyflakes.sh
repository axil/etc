#!/bin/sh
git clone git@github.com:axil/pyflakes-vim.git ~/pyflakes-vim
cd ~/pyflakes-vim
git submodule init
git submodule update
mv ~/pyflakes-vim/ftplugin ~/.vim
rm -rf ~/pyflakes-vim
