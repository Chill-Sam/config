#!/bin/bash

cp -r $HOME/.config/fastfetch ./config_files/terminal/
cp -r $HOME/.config/starship ./config_files/terminal/
cp -r $HOME/.config/nvim ./config_files/terminal/
echo ".config uploaded successfully"

cp $HOME/.bashrc ./home/.bashrc
cp $HOME/.functions_bash ./home/.functions_bash
echo ".bashrc and .functions_bash uploaded successfully"

