# Simon Hryszko @2021

shopt -s expand_aliases
shopt -s autocd #allow use dir instead cd dir
HISTSIZE= HISTFILESIZE= #infinite histiry

export HISTTIMEFORMAT="%d-%m-%y %T: "
export PS1="[\[\e[33m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]] \[\e[35m\]\w\[\e[m\] ⇨ "
export PATH="$HOME/.config/composer/vendor/bin:/home/simon/.cargo/bin:$PATH"
# export network=`echo $(ip route | grep '^default' | awk '{print $5}' | head -n1)`

if [ -x /usr/games/cowsay -a -x /usr/games/fortune ]; then
    fortune | cowsay -f `ls /usr/share/cowsay/cows/ | shuf | head -1 | cut -d . -f1`
fi

source $HOME/.aliases
