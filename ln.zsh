#!/usr/bin/env zsh
cd
print ~/etc/.*(D.) |xargs -n1 ln -nfs
