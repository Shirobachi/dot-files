#!/bin/bash

export ZSH="/home/simon/.oh-my-zsh"
plugins=(zsh-autosuggestions z sudo zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

function git_branch_name()
{
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $branch == "" ]];
    then
        :
    else
        echo "🔀 <$branch>"
    fi
}

# Enabling and setting git info var to be used in prompt config.
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
# This line obtains information from the vcs.
zstyle ':vcs_info:git*' formats "%f(%F{cyan}%b%f)"
precmd() {
    vcs_info
}

# Enable substitution in the prompt.
setopt prompt_subst

# Make time execution
ETIME=0
function preexec() {
    typeset -gi CALCTIME=1
    typeset -gi CMDSTARTTIME=SECONDS
}

function precmd() {
    if (( CALCTIME )) ; then
        typeset -gi ETIME=SECONDS-CMDSTARTTIME
    fi
    typeset -gi CALCTIME=0
}

PROMPT="[%F{yellow}%n%F{green}@%F{blue}%m%f] %F{magenta}%~ %F{green}⇨%f "
RPROMPT='%(?.%F{cyan}Took ${ETIME}s.%F{red}Retuned: %?)${vcs_info_msg_0_} %F{magenta}[%D{%l:%M:%S} ] $(git_branch_name)'

export LANG=en_US.UTF-8

source /home/simon/.aliases
alias history="omz_history -f"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
