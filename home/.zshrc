# History 
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Vi mode
bindkey -v

# Exports
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export PATH=/home/chillsam/.local/scripts:/home/chillsam/.cargo/bin:$PATH

# Aliases
alias ls='ls --color=auto'
alias la='ls -a --color=auto'
alias ll='ls -al --color=auto'
alias grep='grep --color=auto'
alias ssprompt='STARSHIP_SHELL=none starship prompt --status=0 --cmd-duration=0'
alias ff='clear && fastfetch'
alias vi='nvim'
alias vim='nvim'
alias nv='nvim'
alias ta='tmux attach -t'


cd() { builtin cd "$@" && clear && ls -a --color=auto; }

# Keybindings
function _zsh_ctrl_l() {
  clear && ls -a && ssprompt
}
zle -N _zsh_ctrl_l
bindkey '^L' _zsh_ctrl_l

function _zsh_ctrl_b() {
  cd - > /dev/null && echo && la && ssprompt
}
zle -N _zsh_ctrl_b
bindkey '^B' _zsh_ctrl_b

function _zsh_ctrl_g() {

  git status 2> /dev/null && ssprompt
}
zle -N _zsh_ctrl_g
bindkey '^G' _zsh_ctrl_g

function _zsh_ctrl_n() {
  clear && ff && ls && ssprompt
}
zle -N _zsh_ctrl_n
bindkey '^N' _zsh_ctrl_n

bindkey -s '^F' "tmux-sessionizer\n"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"

clear
ff
ls -a --color=auto 
