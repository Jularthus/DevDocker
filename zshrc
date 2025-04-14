export TERM=xterm-256color
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="hyperzsh"
ZSH_THEME="bigpathgreen"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
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

gacp() {
  # Change directory for the root of the Git repository
  cd $(git rev-parse --show-toplevel)

  # Find all executable files in the repository
  executables=$(find $(git rev-parse --show-toplevel) -type f -perm -u=x -not -path '*/.git/*')

  for file in $executables; do
    # Remove leading './' if present
    file_cleaned=$(echo "$file" | sed 's|^\./||')

    # Check if the file isn't already in .gitignore
    if ! grep -qxF "$file_cleaned" .gitignore; then
      echo "Adding $file_cleaned to .gitignore"
      echo "$file_cleaned" >> .gitignore
      git add .gitignore
    fi
  done

  git add -A
  echo -n "Enter commit name: "
  read commitName
  git commit -m "$commitName"
  git push
}

function clone() {
    if [ -z "$1" ]; then
        echo "Please provide a Git repository URL."
        return 1
    fi

    git clone "$1" && cd "$(basename "$1" .git)"
}

function devdocker() {
    if [ $# -eq 0 ]; then
        docker run -it --rm -v "$(pwd)":/app dev-env-docker
    else
        if [ "$1" = "check" ] && [ -n "$2" ]; then
            docker run --rm -v "$(pwd)":/app dev-env-docker sh -c "valgrind --leak-check=full --show-leak-kinds=all ./$2"
        else
            docker run --rm -v "$(pwd)":/app dev-env-docker sh -c "$*"
        fi
    fi
}
alias dd=devdocker
