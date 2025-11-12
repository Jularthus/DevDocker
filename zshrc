export TERM=xterm-256color
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bigpathgreen"

plugins=(git)

source $ZSH/oh-my-zsh.sh

#alias 
alias cls="clear"
alias :q=exit
alias mmake="make clean; make && make check"

unsetopt nomatch
