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

# Colorizing with grc.
if [[ -n `which grc` ]]; then
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
if [[ -n `which colorex` ]]; then
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
if [[ -n `which colordiff` ]]; then
  alias @diff='command diff' && alias diff='colordiff'
fi


# ------------------------------------------------------------------------------
# Fish style live command coloring.
# ------------------------------------------------------------------------------

# Token types styles.
# See http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#SEC135
ZLE_RESERVED_WORD_STYLE='bold'
ZLE_ALIAS_STYLE='bold'
ZLE_BUILTIN_STYLE='bold'
ZLE_FUNCTION_STYLE='bold'
ZLE_COMMAND_STYLE='bold'
ZLE_COMMAND_UNKNOWN_TOKEN_STYLE='fg=red,bold'
ZLE_TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'start' 'time' 'strace')

# Recolorize the current ZLE buffer.
colorize-zle-buffer() {
  region_highlight=()
  colorize=true
  start_pos=0
  for arg in ${(z)BUFFER}; do
    ((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
    ((end_pos=$start_pos+${#arg}))
    if $colorize; then
      colorize=false
      res=$(LC_ALL=C builtin type $arg 2>/dev/null)
      case $res in
        *'reserved word'*)  style=$ZLE_RESERVED_WORD_STYLE;;
        *'an alias'*)       style=$ZLE_ALIAS_STYLE;;
        *'shell builtin'*)  style=$ZLE_BUILTIN_STYLE;;
        *'shell function'*) style=$ZLE_FUNCTION_STYLE;;
        *"$cmd is"*)        style=$ZLE_COMMAND_STYLE;;
        *)                  style=$ZLE_COMMAND_UNKNOWN_TOKEN_STYLE;;
      esac
      region_highlight+=("$start_pos $end_pos $style")
    fi
    [[ ${${ZLE_TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
    start_pos=$end_pos
  done
}

# Bind the function to ZLE events.
colorize-hook-self-insert() { builtin zle .self-insert && colorize-zle-buffer }
colorize-hook-backward-delete-char() { builtin zle .backward-delete-char && colorize-zle-buffer }

zle -N self-insert colorize-hook-self-insert
zle -N backward-delete-char colorize-hook-backward-delete-char
