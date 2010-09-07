#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Description
#   Prompt for the Zsh shell.
# ------------------------------------------------------------------------------


autoload -Uz vcs_info

# Usage: color TEXT [COLOR_GOOD] [COLOR_BAD]
# Will color text with COLOR_GOOD.
# If COLOR_BAD is given, it will be used when there is an error.
# 0 = Black
# 1 = Red
# 2 = Green
# 3 = Yellow
# 4 = Blue
# 5 = Magenta
# 6 = Cyan
# 7 = White
color()
{
  local text=$1; shift
  case $# in
    2) echo "%(0?.%F{$1}.%F{$2})${text}%f" ;;
    1) echo "%F{$1}${text}%f" ;;
    *) echo "$text" ;;
  esac
}

local str_action='%a'
local str_branch_changes='%b %u %c'
local str_path='%2~'
local str_prompt='›'
local str_staged_changes='+'
local str_unstaged_changes='!'
local str_vcs='%s'

str_action=$(color $str_action 5  )
str_branch_changes=$(color $str_branch_changes 2)
str_path=$(color $str_path 4 1 )
str_staged_changes=$(color $str_staged_changes 2  )
str_unstaged_changes=$(color $str_unstaged_changes 1  )
str_vcs=$(color $str_vcs 5)

zstyle ':vcs_info:*' enable git hg bzr svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr     "$str_staged_changes"
zstyle ':vcs_info:*' unstagedstr   "$str_unstaged_changes"
zstyle ':vcs_info:*' formats       "${str_vcs} ${str_branch_changes} "
zstyle ':vcs_info:*' actionformats "${str_vcs} ${str_branch_changes} $str_action "

precmd_functions+='vcs_info'

PROMPT="%B$str_path $str_prompt %b"
RPROMPT="%B"'${vcs_info_msg_0_}'"%b"
