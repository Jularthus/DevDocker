# prompt style and colors based on the halflife theme from the omz team:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/half-life.zsh-theme
# vcs_info modifications from Bart Trojanowski's zsh prompt:
# http://www.jukie.net/bart/blog/pimping-out-zsh-prompt
#
# git untracked files modification from Brian Carper:
# https://briancarper.net/blog/570/git-info-in-your-zsh-prompt

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}
PR_GIT_UPDATE=1

setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

#use extended color palette if available
if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
    turquoise="%F{81}"
    red="%F{196}"
    orange="%F{166}"
    purple="%F{135}"
    hotpink="%F{161}"
    limegreen="%F{118}"
    gray="%F{8}"
    bluegit="%F{95}"
    greenpath="%F{160}"
    greenuser="%F{88}"
else
    turquoise="$fg[cyan]"
    orange="$fg[yellow]"
    purple="$fg[magenta]"
    hotpink="$fg[red]"
    limegreen="$fg[green]"
    bluegit="%F{95}"
    greenpath="%F{82}"
    greenuser="%F{35}"
fi

# enable VCS systems you use
zstyle ':vcs_info:*' enable git svn

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%{${reset_color}%}"
FMT_BRANCH=" on %{$turquoise%}%b%u%c${PR_RST}"
FMT_ACTION=" performing a %{$purple%}%a${PR_RST}"
FMT_UNSTAGED="%{$hotpink%} ●"
FMT_STAGED="%{$purple%} ●"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""


function steeef_preexec {
    case "$2" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec steeef_preexec

function steeef_chpwd {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd steeef_chpwd

function steeef_precmd {

    DISABLED_DIRS=("~/afs" "/path/")
    for DIR in "${DISABLED_DIRS[@]}"; do
      DISABLED_DIR=${DIR/#\~/$HOME}
      if [[ "$PWD" == "$DISABLED_DIR"* ]]; then
            return
      fi
    done

    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't
        if [[ ! -z $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="${PM_RST}%{$turquoise%}/%{$turquoise%}%b%u%c%{$turquoise%} ●${PR_RST}"
        else
            FMT_BRANCH="${PM_RST}%{$turquoise%}/%{$turquoise%}%b%u%c${PR_RST}"
        fi
        zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd steeef_precmd

PROMPT=$'%{$greenuser%}docker-dev~%{$greenpath%}%2~%{$reset_color%}$(ruby_prompt_info " with%{$fg[red]%} " v g "")$vcs_info_msg_0_%{$bluegit%}/%{$reset_color%} %{$reset_color%}'
RPROMPT='%{$reset_color%}%T%(?..|ERR:%?)%{$reset_color%}'
