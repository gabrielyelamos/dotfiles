#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Shell coloring.
# ------------------------------------------------------------------------------

autoload -Uz colors && colors

# ------------------------------------------------------------------------------
# Commands output coloring.
# ------------------------------------------------------------------------------

# ls colorizing with dircolors.
DIRCOLORS_INIT_FILE=~/.dir_colors
if [[ -x /usr/bin/dircolors ]]; then
  [[ -e $DIRCOLORS_INIT_FILE ]] && eval $(dircolors $DIRCOLORS_INIT_FILE) || eval $(dircolors)
fi
ZLS_COLORS=$LS_COLORS

# Colorizing with colorex.
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

# Colorizing with grc.
# if [ -n `which grc` ]; then
#   alias configure='grc -es --colour=auto ./configure'
#   alias diff='grc -es --colour=auto diff'
#   alias make='grc -es --colour=auto make'
#   alias gcc='grc -es --colour=auto gcc'
#   alias g++='grc -es --colour=auto g++'
#   alias ld='grc -es --colour=auto ld'
#   alias netstat='grc -es --colour=auto netstat'
#   alias ping='grc -es --colour=auto ping'
# fi

# diff colorizing with colordiff.
# if [ -n `which colordiff` ]; then
#   alias diff='colordiff'
# fi


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
