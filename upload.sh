#!/bin/bash

cp -r $HOME/.config/fastfetch ./config_files/terminal/
cp -r $HOME/.config/starship ./config_files/terminal/
cp -r $HOME/.config/nvim ./config_files/terminal/
echo ".config uploaded successfully"

cp $HOME/.zshrc ./home/.zshrc
echo ".zshrc uploaded successfully"

