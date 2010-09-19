#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Shell events hooks.
# ------------------------------------------------------------------------------

# Hooks initialization
typeset -ga precmd_functions
typeset -ga preexec_functions
typeset -ga chpwd_functions

# Force refresh the terminal title before each command.
update_terminal_title () {print -Pn "\e]0;%~\a"}
precmd_functions+=update_terminal_title
