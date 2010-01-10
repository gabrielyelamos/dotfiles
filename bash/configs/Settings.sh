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


# Use 'most' as pager
export PAGER="/usr/bin/most"


# Use 'geany' as editor
export EDITOR="/usr/bin/geany"


# Set displayed directories when running '$ cd <TAB>'
export CDPATH='.:..:~/projects'


# Add some directories to $PATH
export PATH=$HOME/bin:$PATH


# Ignore duplicates in history control without overriding Midnight Commander's
# setting for 'ignorespaces'
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups


# Append to the history file, don't overwrite it
shopt -s histappend


# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# Correct small typos in directories names
shopt -s cdspell


# Fixes Swing apps displaying blank windows when using Compiz.
export AWT_TOOLKIT=MToolkit
