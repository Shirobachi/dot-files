# Simon Hryszko @2021

shopt -s autocd #allow use dir instead cd dir
HISTSIZE= HISTFILESIZE= #infinite histiry

export HISTTIMEFORMAT="%d-%m-%y %T: "
export PS1="\[\e[5 q\r\]\w \[\e[32m\]⇨\[\e[m\] "
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export VISUAL=vim;
export EDITOR=vim;

alias ls='ls --color=auto'
alias grep='grep -i --colour=auto'
alias egrep='egrep -i --colour=auto'
alias mkdir='mkdir -pv'
alias ls="ls --color=auto --group-directories-first"
alias ll="ls -lAh"
alias budget="cd /home/simon/Scripts/budget && python3 budget.py"
alias b="budget"
alias B="budget && read && budget && exit"
alias r="ranger"
alias R="xcompmgr & ranger"
alias a="sudo apt"
alias A="sudo apt install"
alias genPass="tr -dc 'A-Za-z0-9\#$%&()*+,-./:;<=>?@[\]^_{|}~' </dev/urandom | head -c 50 | xclip -selection clipboard && exit"
alias checkClass="xprop WM_CLASS"
alias python="python3"
alias pip="pip3"
alias q="exit"
alias tb="nc termbin.com 9999"
alias wifi="nmtui"
alias g="git"
alias gc="git add . && git commit"
alias gca="git add . && git commit --amend"
alias gp="git push"
alias fs="~/Scripts/freshStart/run.sh"
alias artiTunnel="ssh -i ~/.Keys/hryszko.dev -N -L 13306:127.0.0.1:3306 simon@116.202.28.36"
alias mountHryszkoDev="mkdir ~/hryszkoDev && sshfs -o default_permissions,IdentityFile=~/.Keys/hryszko.dev simon@116.202.28.36:/ ~/hryszkoDev"
alias VIM='VISUAL=vim'
alias tree='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/| - \1/"'
alias config='/usr/bin/git --git-dir=/home/simon/.cfg/ --work-tree=/home/simon'

cat ~/.showOnStart 2> /dev/null
