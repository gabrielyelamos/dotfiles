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

# Pipe some commands to colorex
mvn(){ `which -a mvn | grep '^\/' | head -1` $@ 2>&1 | colorex --config=maven3 }
omvn(){ `which -a mvn | grep '^\/' | head -1` $@ }
mvn2(){ `which -a mvn2 | grep '^\/' | head -1` $@ 2>&1 | colorex --config=maven2 }
omvn2(){ `which -a mvn2 | grep '^\/' | head -1` $@ }
diff(){ `which -a diff | grep '^\/' | head -1` $@ 2>&1 | colorex --config=diff }
ping(){ `which -a ping | grep '^\/' | head -1` $@ 2>&1 | colorex --config=ping}
top(){ `which -a top | grep '^\/' | head -1` $@ 2>&1 | colorex --config=top }
traceroute(){ `which -a traceroute | grep '^\/' | head -1` $@ 2>&1 | colorex --config=traceroute }
