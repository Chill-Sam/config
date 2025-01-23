#!/bin/bash

cp -a home/. $HOME/
exec bash --rcfile "$HOME/.bashrc"
