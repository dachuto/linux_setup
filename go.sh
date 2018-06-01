#!/usr/bin/env bash
set -v
mkdir ~/bin/
cp bin/* ~/bin/
cat bash/bashrc_append.sh >> ~/.bashrc
