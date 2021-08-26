# Simon Hryszko @2021

shopt -s expand_aliases
shopt -s autocd #allow use dir instead cd dir
HISTSIZE= HISTFILESIZE= #infinite histiry

export HISTTIMEFORMAT="%d-%m-%y %T: "
export PS1="\[\e[5 q\r\][\u@\h] \w \[\e[32m\]⇨\[\e[m\] "
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export VISUAL=vim;
export EDITOR=vim;
# export network=`echo $(ip route | grep '^default' | awk '{print $5}' | head -n1)`

alias ls='ls --color=auto'
alias grep='grep -i --colour=auto'
alias egrep='egrep -i --colour=auto'
alias mkdir='mkdir -pv'
alias ls="ls --color=auto --group-directories-first"
alias ll="ls -lAh"
alias r="ranger"
alias a="sudo apt"
alias A="sudo apt install"
alias python="python3"
alias pip="pip3"
alias q="exit"
alias tb="nc termbin.com 9999"
alias wifi="nmtui"
alias tree='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/| - \1/"'
alias config='/usr/bin/git --git-dir=/home/simon/.cfg/ --work-tree=/home/simon'
alias configMaster='/usr/bin/git --git-dir=/home/simon/.cfg/ --work-tree=/home/simon commit -a -m "Auto backup!"; /usr/bin/git --git-dir=/home/simon/.cfg/ --work-tree=/home/simon pull && /usr/bin/git --git-dir=/home/simon/.cfg/ --work-tree=/home/simon push'
alias watch="watch -n.1"

cat ~/.showOnStart 2> /dev/null
