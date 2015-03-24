#!/bin/sh

cd $HOME/.emacs.d

cask build
emacs -batch -f batch-byte-compile ~/.emacs.d/**/*.el
