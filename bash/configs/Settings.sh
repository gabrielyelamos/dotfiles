#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   General settings for the bash environnement.
#
# Dependencies
#   * Commands: most, shopt.
# ------------------------------------------------------------------------------


# Charset
# export LC_ALL="fr_FR.UTF-8"
# export LC_CTYPE="fr_FR.UTF-8"
# export LANG=fr_FR.UTF-8


# Pager: less
export PAGER_VIM="/bin/sh -c \"unset PAGER;col -b -x | vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' -c 'map <SPACE> <C-D>' -c 'map b <C-U>' -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""
export PAGER="less"
export MANPAGER="less"


# Editor: Geany, default to vim if not available.
export EDITOR=`which geany`
export EDITOR=${EDITOR:-vim}
export VISUAL=`which geany`
export VISUAL=${VISUAL:-vim}
export CVSEDITOR=`which geany`
export CVSEDITOR=${CVSEDITOR:-vim}
export SVN_EDITOR=`which geany`
export SVN_EDITOR=${SVN_EDITOR:-vim}


# Settings for less
export LESS="-MWi -x2 --shift 5"
export LESSCHARSET=utf-8
export LESSHISTFILE="-"
if [ "$UID" != 0 ]; then
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"  
  export LESS_TERMCAP_mb=$'\E[01;31m'
  export LESS_TERMCAP_md=$'\E[01;31m'
  export LESS_TERMCAP_me=$'\E[0m'
  export LESS_TERMCAP_se=$'\E[0m'                           
  export LESS_TERMCAP_so=$'\E[01;44;33m'                                 
  export LESS_TERMCAP_ue=$'\E[0m'
  export LESS_TERMCAP_us=$'\E[01;32m'
fi


# Web browser: elinks/Firefox.
export BROWSER="elinks"
if [ "$DISPLAY" ]; then
  export BROWSER="firefox"
fi


# Set displayed directories when running '$ cd <TAB>'.
export CDPATH='.:..:$OLDPWD:~/projects'


# Add some directories to $PATH.
export PATH=$HOME/bin:$PATH


# Make sure bash-completion is activated.
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


# Ignore duplicates in history control without overriding Midnight Commander's
# setting for 'ignorespaces'
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups


# Don't keep useless stuff in history.
export HISTIGNORE="cd:ls:[bf]g:clear"


# Append to the history file, don't overwrite it.
shopt -s histappend


# Allow to share history between terms at each command.
PROMPT_COMMAND="$PROMPT_COMMAND; history -a; history -n"


# Number of history lines per session.
export HISTSIZE=10000


# Number of total history lines.
export HISTFILESIZE=20000


# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# Correct small typos in directories names.
shopt -s cdspell


# Allows to 'cd' variables that contain a path.
shopt -s cdable_vars


# Save multi-line commands in the same history entry.
shopt -s cmdhist


# Do not auto-complete an empty line.
shopt -s no_empty_cmd_completion


# Fixes Swing apps displaying blank windows when using Compiz.
export AWT_TOOLKIT=MToolkit


# <CTRL>+D must be pressed twice to exit the shell.
export IGNOREEOF=1


# Update $LS_COLORS.
eval `dircolors -b`
