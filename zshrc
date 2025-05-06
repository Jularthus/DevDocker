export TERM=xterm-256color
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bigpathgreen"

plugins=(git)

source $ZSH/oh-my-zsh.sh

#alias 
alias cls="clear"
alias gc="git commit -m"
alias ga="git add -A"
alias gl="git log" 
alias gp="git push"
alias gs="git status"
alias gd="git diff HEAD^ HEAD"
alias :q=exit

unsetopt nomatch
