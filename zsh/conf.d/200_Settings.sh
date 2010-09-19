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
[[ -x /usr/bin/lesspipe ]] && eval $(lesspipe)

# Colors in ls
[[ -x /usr/bin/dircolors ]] && eval $(dircolors ~/.dir_colors)
export ZLS_COLORS=$LS_COLORS

# Force refresh the terminal title before each command.
case $TERM in
  xterm*)
    precmd () {print -Pn "\e]0;%~\a"}
    ;;
esac

# Colorize some commands with colorex
[[ -z `alias mvn` ]] && alias @mvn=`which mvn` && alias mvn='colorex --config mvn3 -- mvn'
[[ -z `alias mvn2` ]] && alias @mvn2=`which mvn2` && alias mvn2='colorex --config mvn2 -- mvn2'
[[ -z `alias diff` ]] && alias @diff=`which diff` && alias diff='colorex -- diff'
[[ -z `alias df` ]] && alias @df=`which df` && alias df='colorex -- df'
[[ -z `alias host` ]] && alias @host=`which host` && alias host='colorex -- host'
[[ -z `alias ifconfig` ]] && alias @ifconfig=`which ifconfig` && alias ifconfig='colorex -- ifconfig'
[[ -z `alias md5sum` ]] && alias @md5sum=`which md5sum` && alias md5sum='colorex -- md5sum'
[[ -z `alias ping` ]] && alias @ping=`which ping` && alias ping='colorex -- ping'
[[ -z `alias top` ]] && alias @top=`which top` && alias top='colorex -- top'
[[ -z `alias traceroute` ]] && alias @traceroute=`which traceroute` && alias traceroute='colorex -- traceroute'
[[ -z `alias jonas` ]] && alias @jonas=`which jonas` && alias jonas='colorex -- jonas'
