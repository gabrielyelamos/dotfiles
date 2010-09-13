#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Fish style live command coloring.
# ------------------------------------------------------------------------------

ZLE_RESERVED_WORD_STYLE='fg=white,bold'
ZLE_ALIAS_STYLE='fg=white,bold'
ZLE_BUILTIN_STYLE='fg=white,bold'
ZLE_FUNCTION_STYLE='fg=white,bold'
ZLE_COMMAND_STYLE='fg=white,bold'
ZLE_COMMAND_UNKNOWN_TOKEN_STYLE='fg=red,bold'

colorize-zle-buffer() {
  colorize=true
  start_pos=0
  for arg in ${(z)BUFFER}; do
    ((end_pos=$start_pos+${#arg}+1))
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
    if [[ $arg = '|' ]] || [[ $arg = 'sudo' ]]; then
      colorize=true
    fi
    start_pos=$end_pos
  done
}

colorize-hook-self-insert() { builtin zle .self-insert && colorize-zle-buffer }
colorize-hook-backward-delete-char() { builtin zle .backward-delete-char && colorize-zle-buffer }

zle -N self-insert colorize-hook-self-insert
zle -N backward-delete-char colorize-hook-backward-delete-char
