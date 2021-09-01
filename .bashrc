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

curl -s 'https://raw.githubusercontent.com/jlevy/the-art-of-command-line/master/README.md' | egrep -o '`\w+`' | tr -d '`' | cowsay -W70

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

