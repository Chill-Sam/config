#!/bin/bash

if [ -z "$1" ]; then 
	echo "Select a type"
fi

if [ "$1" == "terminal" ]; then
	cp -a config_files/terminal/. $HOME/.config
fi

starship preset tokyo-night -o ~/.config/starship.toml
echo "Starship setup"

cp -a home/. $HOME/
rm $HOME/.bash* 
exec /bin/zsh
