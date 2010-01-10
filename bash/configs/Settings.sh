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

# Use 'most' for pager
export PAGER="/usr/bin/most"

# Fixes Swing apps displaying blank windows when using Compiz.
export AWT_TOOLKIT=MToolkit

# Ignore duplicates in history control without overriding Midnight Commander's
# setting for 'ignorespaces'
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
