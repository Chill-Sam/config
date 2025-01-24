#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Bashrc starts here

export HISTCONTROL=ignoreboth
export STARSHIP_CONFIG=~/.config/starship/starship.toml

source $HOME/.functions_bash

alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -al --color=auto'
alias grep='grep --color=auto'
alias ssprompt='STARSHIP_SHELL=none starship prompt --status=0 --cmd-duration=0 | head -n -1'
alias ff='fastfetch'

bind -x '"\C-l":"clear && ls -a && ssprompt"' 
bind -x '"\C-b":"cd - && ssprompt"' 
bind -x '"\C-g":"git status && ssprompt"'
bind -x '"\C-n":"clear && ff && ls && ssprompt"'

eval "$(starship init bash)"

clear
ff
ls
