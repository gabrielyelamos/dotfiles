#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Description
#   General settings for the shell environnement.
# ------------------------------------------------------------------------------



# Settings for less
export LESS="-MWi -x2 --shift 5"
export LESSCHARSET=utf-8
export LESSHISTFILE="-"
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'                           
export LESS_TERMCAP_so=$'\E[01;44;33m'                                 
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
[ -x /usr/bin/lesspipe ] && eval $(lesspipe)

# Colors in ls
[ -x /usr/bin/dircolors ] && eval $(dircolors)
export ZLS_COLORS=$LS_COLORS