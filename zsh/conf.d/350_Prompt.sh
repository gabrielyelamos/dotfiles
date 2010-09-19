#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Description
#   Prompt for the Zsh shell.
# ------------------------------------------------------------------------------

autoload -Uz colors && colors
autoload -Uz vcs_info

for COLOR in RED GREEN BLUE YELLOW WHITE MAGENTA BLACK CYAN; do
  eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
  eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
PR_RESET="%{${reset_color}%}";

FMT_BRANCH="${PR_GREEN}%s/%b ${PR_BRIGHT_GREEN}%u%c${PR_RESET}"
FMT_ACTION="${PR_CYAN}(%a)${PR_RESET}%"
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' check-for-changes true
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%r" "/%S" "${FMT_BRANCH} ${FMT_ACTION}"
zstyle ':vcs_info:*:*' formats "%r" "/%S" "${FMT_BRANCH}"
zstyle ':vcs_info:*:*' nvcsformats "" "%~" ""

precmd_functions+=vcs_info

PROMPT="${PR_RESET}${SSH_TTY:+${PR_YELLOW}%n@%m${PR_RESET}-}%(0?.$PR_BRIGHT_BLUE.$PR_BRIGHT_RED)"'${vcs_info_msg_0_}'"${PR_RESET}%(0?.$PR_YELLOW.$PR_BRIGHT_RED)%20<..<"'${vcs_info_msg_1_%%.}'"%<<${PR_RESET} "
RPROMPT="${PR_RESET}"'$vcs_info_msg_2_'"${PR_RESET}"
