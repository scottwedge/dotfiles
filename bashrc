# ~/.bashrc: shared between Linux and Mac OSX shells

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

[ -z "$TMUX" ] && export TERM=xterm-256color

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color)    color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    _color='--color=auto'
fi

alias la='ls -AGF'
alias ls='ls -GF'
alias ll='ls -lGF'

alias l='less'
export LESS="-c -i -x4 -J -w -M"
export VISUAL='vim'
alias e='emacs --no-window-system'
alias ee='emacs'
alias v='vim'
alias vv='mvim'
alias s='/Applications/Sublime\ Text\ 2.app/Contents/MacOS/Sublime\ Text\ 2'

alias ff='find . -type f -name'
alias fff='grep --color=auto -n -R'
alias fff1='grep --color=auto -m 1 -R'
alias ffl='grep --color=auto -l -R'
#alias '-'='popd'
alias ..='cd ../'
alias ...='cd ../../'
alias hh='pushd ~/'
alias dirs='dirs -v'

alias xx='exit'
alias reload='source ~/.bashrc'

# vi mode; can be switched on temp with: set -o vi
set editing-mode vi

# python startup
export PYTHONSTARTUP=~/.pythonrc.py


#Automatically do an ls after each cd
c() {
  if [ -n "$1" ]; then
    builtin cd "$@" && ls
  else
    builtin cd ~ && ls
  fi
}

ccc() {
  if [ -n "$1" ]; then
    builtin pushd "$@" && ls
  else
    builtin pushd && ls
  fi
}

#export PS1='(\t) [\w]\n\$ '
export PS1='(\t \u@\h) [\033[34m\w\033[00m]\n\$ '

if [ -x /usr/bin/most ]; then
	export MANPAGER="/usr/bin/most -s"
fi
if [ -x ~/bin/contrib/vimpager/vimpager ]; then
    export PAGER=~/bin/contrib/vimpager/vimpager
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.secrets ]; then
    . ~/.secrets
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

extract()
{
	if [ -f "$1" ] ; then
		case "$1" in
			*.tar.bz2) tar xjf "$1" ;;
			*.tar.gz) tar xzf "$1" ;;
			*.tar.Z) tar xzf "$1" ;;
			*.bz2) bunzip2 "$1" ;;
			*.rar) unrar x "$1" ;;
			*.gz) gunzip "$1" ;;
			*.jar) unzip "$1" ;;
			*.tar) tar xf "$1" ;;
			*.tbz2) tar xjf "$1" ;;
			*.tgz) tar xzf "$1" ;;
			*.zip) unzip "$1" ;;
			*.Z) uncompress "$1" ;;
			*) echo "'$1' cannot be extracted." ;;
		esac
	else
		echo "'$1' is not a file."
	fi
}

myip() { wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'; }

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:/usr/local/bin:$PATH"
fi

if [  -x "/opt/Sublime2/sublime_text" ]; then
    alias s2='/opt/Sublime2/sublime_text'
fi

export PKG_CONFIG_PATH="/usr/lib/pkgconfig/:/usr/local/lib/pkgconfig/"


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
