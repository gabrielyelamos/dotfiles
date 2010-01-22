#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   General settings for the bash environnement.
#
# Dependencies
#   * Commands: most, shopt.
#
# Author
#   nicoulaj - http://www.ju-n.net
# 
# Project
#   dotfiles - http://github.com/nicoulaj/dotfiles
# ------------------------------------------------------------------------------


# Use 'most' as pager, default to 'less' if not available
export PAGER=`which most`
export PAGER=${PAGER:-less}


# Use 'geany' as editor, default to gedit if not available
export EDITOR=`which geany`
export EDITOR=${EDITOR:-gedit}


# Set displayed directories when running '$ cd <TAB>'
export CDPATH='.:..:$OLDPWD:~/projects'


# Add some directories to $PATH
export PATH=$HOME/bin:$PATH


# Make sure bash-completion is activated
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


# Ignore duplicates in history control without overriding Midnight Commander's
# setting for 'ignorespaces'
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups


# Don't keep useless stuff in history
export HISTIGNORE="cd:ls:[bf]g:clear"


# Append to the history file, don't overwrite it
shopt -s histappend


# Number of history lines per session
export HISTSIZE=5000


# Number of total history lines
export HISTFILESIZE=20000


# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# Correct small typos in directories names
shopt -s cdspell


# Fixes Swing apps displaying blank windows when using Compiz.
export AWT_TOOLKIT=MToolkit
