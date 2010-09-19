#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Commands shortcuts and aliases.
# ------------------------------------------------------------------------------


# ls
alias ls='ls -F --group-directories-first --color=auto'
alias ll='ls -alh --group-directories-first --color=auto'
alias la='ls -AF --group-directories-first --color=auto'
alias l.='ls -Fd --group-directories-first --color=auto .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."'


# dir
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'


# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# shred
alias shred='shred --iterations 30 --zero --remove --verbose'


# Force interactive commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'


# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'


# Shortcuts to open and edit files
alias o='gnome-open'
alias so='gksudo gnome-open'


# Colorize some commands with grc
#if [ -n `which grc` ]; then
#  alias configure='grc -es --colour=auto ./configure'
#  alias diff='grc -es --colour=auto diff'
#  alias make='grc -es --colour=auto make'
#  alias gcc='grc -es --colour=auto gcc'
#  alias g++='grc -es --colour=auto g++'
#  alias ld='grc -es --colour=auto ld'
#  alias netstat='grc -es --colour=auto netstat'
#  alias ping='grc -es --colour=auto ping'
#fi


# Replace diff with colordiff if available
#if [ -n `which colordiff` ]; then
#  alias diff='colordiff'
#fi
