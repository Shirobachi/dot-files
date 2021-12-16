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
export VISUAL=micro;
export EDITOR=micro;

alias mkdir='mkdir -pv'
alias ll="ls -lAh"
alias r="ranger"
alias a="sudo apt"
alias A="sudo apt install"
alias p="pip"
alias P="pip install"
alias python="python3"
alias pip="pip3"
alias q="exit"
alias tb="nc termbin.com 9999"
alias wifi="nmtui"
alias config='/usr/bin/git --git-dir=/home/simon/.cfg/ --work-tree=/home/simon'
alias configMaster='/usr/bin/git --git-dir=/home/simon/.cfg/ --work-tree=/home/simon commit -a -m "Auto backup!"; /usr/bin/git --git-dir=/home/simon/.cfg/ --work-tree=/home/simon pull && /usr/bin/git --git-dir=/home/simon/.cfg/ --work-tree=/home/simon push'
alias watch="watch -n.1"
alias xclipp="xclip -selection clipboard"
alias help="cat $HOME/Scripts/my-scripts/help_message"

function c() {
	curl -s cheat.sh/$1
}

function CODE(){
  code $1 && q
}

fortune | cowsay -f `ls /usr/share/cowsay/cows/ | shuf | head -1 | cut -d . -f1`





