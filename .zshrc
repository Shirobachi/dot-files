export ZSH="/home/simon/.oh-my-zsh"
plugins=(zsh-autosuggestions z sudo zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

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
RPROMPT='%(?.%F{cyan}Took ${ETIME}s.%F{red}Retuned: %?)${vcs_info_msg_0_} %F{magenta}[ %D{%l:%M:%S} ]'

export LANG=en_US.UTF-8

if [ -x /usr/games/cowsay -a -x /usr/games/fortune ]; then
    fortune | cowsay -f `ls /usr/share/cowsay/cows/ | shuf | head -1 | cut -d . -f1`
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /home/simon/.aliases

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/simon/Apps/anaconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/simon/Apps/anaconda/etc/profile.d/conda.sh" ]; then
        . "/home/simon/Apps/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/home/simon/Apps/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

