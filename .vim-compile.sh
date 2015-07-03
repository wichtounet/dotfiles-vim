#!/bin/bash

# This script installs compiled components of vim

cd ~/.vim/tmp/build/

# Compile and installl color_coded

mkdir color_coded
cd color_coded

cmake ~/.vim/bundle/color_coded
make && make install
make clean && make clean_clang

# Compile and install youcompleteme

cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer --system-libclang
