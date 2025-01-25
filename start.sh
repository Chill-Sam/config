#!/bin/bash

cp -a config_files/terminal/. $HOME/.config

starship preset tokyo-night -o ~/.config/starship.toml
echo "Starship setup"

cp -a home/. $HOME/
rm $HOME/.bash* 
exec /bin/zsh
