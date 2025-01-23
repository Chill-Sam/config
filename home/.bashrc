#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Bashrc starts here

export HISTCONTROL=ignoreboth

source $HOME/.functions_bash

alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -al --color=auto'
alias grep='grep --color=auto'
alias ssprompt='STARSHIP_SHELL=none starship prompt --status=0 --cmd-duration=0 | head -n -1'

bind -x '"\C-l":"clear && ls -a && ssprompt"' 
bind -x '"\C-b":"cd - && ssprompt"' 
bind -x '"\C-g":"git status && ssprompt"'

eval "$(starship init bash)"
