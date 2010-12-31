#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Shell coloring.
# ------------------------------------------------------------------------------


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
# Syntax highlighting configuration
# ------------------------------------------------------------------------------

ZSH_SYNTAX_HIGHLIGHTING_STYLES=(
  default                       'none'
  unknown-token                 'fg=red,bold'
  reserved-word                 'bold'
  alias                         'bold'
  builtin                       'bold'
  function                      'bold'
  command                       'bold'
  path                          'underline'
  globbing                      'fg=blue'
  single-hyphen-option          'none'
  double-hyphen-option          'none'
  single-quoted-argument        'fg=yellow'
  double-quoted-argument        'fg=yellow'
  dollar-double-quoted-argument 'fg=cyan'
  back-quoted-argument          'fg=magenta'
  back-double-quoted-argument   'fg=magenta'
)
