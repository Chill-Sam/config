#!/bin/bash

cp -a config_files/terminal/. $HOME/.config

cp -a home/. $HOME/
rm $HOME/.bash* 
exec /bin/zsh
