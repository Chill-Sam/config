#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -al --color=auto'
alias grep='grep --color=auto'
alias nf='clear && neofetch && la'
alias vi='nvim'
alias vim='nvim'
alias top='bashtop'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
#PS1='[\u@\h \W]\$ '


# binds
bind -x '"\C-n":nf'
bind -x '"\C-b":clear && la'
bind -x '"\C-g":git status'

# Setup starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init bash)"

# Export
export EDITOR=nvim

# Startup command
nf
