#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Shell coloring.
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Colors definition.
# ------------------------------------------------------------------------------

autoload colors && colors
typeset -Ag FX FG BG

# Effects.
FX=(
  reset     "[00m"
  bold      "[01m" no-bold      "[22m"
  italic    "[03m" no-italic    "[23m"
  underline "[04m" no-underline "[24m"
  blink     "[05m" no-blink     "[25m"
  reverse   "[07m" no-reverse   "[27m"
)

# 256 colors array (foreground and background).
for color in {0..255}; do
  FG[$color]="[38;5;${color}m"
  BG[$color]="[48;5;${color}m"
done

# Add 16 named colors.
FG[none]=$FG[0];        BG[none]=$BG[0]
FG[darkred]=$FG[1];     BG[darkred]=$BG[1]
FG[darkgreen]=$FG[2];   BG[darkgreen]=$BG[2]
FG[darkyellow]=$FG[3];  BG[darkyellow]=$BG[3]
FG[darkblue]=$FG[4];    BG[darkblue]=$BG[4]
FG[darkmagenta]=$FG[5]; BG[darkmagenta]=$BG[5]
FG[darkcyan]=$FG[6];    BG[darkcyan]=$BG[6]
FG[grey]=$FG[7];        BG[grey]=$BG[7]
FG[darkgrey]=$FG[8];    BG[darkgrey]=$BG[8]
FG[red]=$FG[9];         BG[red]=$BG[9]
FG[green]=$FG[10];      BG[green]=$BG[10]
FG[yellow]=$FG[11];     BG[yellow]=$BG[11]
FG[blue]=$FG[12];       BG[blue]=$BG[12]
FG[magenta]=$FG[13];    BG[magenta]=$BG[13]
FG[cyan]=$FG[14];       BG[cyan]=$BG[14]
FG[lightgrey]=$FG[15];  BG[lightgrey]=$BG[15]


# ------------------------------------------------------------------------------
# Commands output coloring.
# ------------------------------------------------------------------------------

# ls colorizing with dircolors.
DIRCOLORS_INIT_FILE=~/.dir_colors
if [[ -x /usr/bin/dircolors ]]; then
  [[ -e $DIRCOLORS_INIT_FILE ]] && eval $(dircolors $DIRCOLORS_INIT_FILE) || eval $(dircolors)
fi
ZLS_COLORS=$LS_COLORS

# Colors for less.
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Colorizing with grc.
if [[ -x `which grc` ]]; then
  alias @diff='command diff' && alias diff='grc diff'
  alias @make='command make' && alias make='grc make'
  alias @gcc='command gcc' && alias gcc='grc gcc'
  alias @g++='command g++' && alias g++='grc g++'
  alias @ld='command ld' && alias ld='grc ld'
  alias @netstat='command netstat' && alias netstat='grc netstat'
  alias @ping='command ping' && alias ping='grc ping'
  alias @cvs='command cvs' && alias cvs='grc cvs'
  alias @traceroute='command traceroute' && alias traceroute='grc traceroute'
fi

# Colorizing with colorex.
if [[ -x `which colorex` ]]; then
  alias @mvn='command mvn' && alias mvn='colorex --config mvn3 -- mvn'
  alias @mvn2='command mvn2' && alias mvn2='colorex --config mvn2 -- mvn2'
  alias @diff='command diff' && alias diff='colorex -- diff'
  alias @df='command df' && alias df='colorex -- df'
  alias @host='command host' && alias host='colorex -- host'
  alias @ifconfig='command ifconfig' && alias ifconfig='colorex -- ifconfig'
  alias @md5sum='command md5sum' && alias md5sum='colorex -- md5sum'
  alias @ping='command ping' && alias ping='colorex -- ping'
  alias @top='command top' && alias top='colorex -- top'
  alias @traceroute='command traceroute' && alias traceroute='colorex -- traceroute'
  alias @jonas='command jonas' && alias jonas='colorex -- jonas'
fi

# Colorizing with colordiff.
if [[ -x `which colordiff` ]]; then
  alias @diff='command diff' && alias diff='colordiff'
fi

# Colorizing with colorsvn.
if [[ -x `which colorsvn` ]]; then
  alias @svn='command svn' && alias svn='colorsvn'
fi

# Colorizing with colorgcc.
if [[ -x `which colorgcc` ]]; then
  alias @gcc='command gcc' && alias gcc='colorgcc'
fi


# ------------------------------------------------------------------------------
# Command line syntax highlighting.
# ------------------------------------------------------------------------------

if [ -e ~/projects/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  . ~/projects/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
