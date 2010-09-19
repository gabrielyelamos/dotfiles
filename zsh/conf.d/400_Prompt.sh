#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Prompt for the Zsh shell.
# ------------------------------------------------------------------------------

autoload -Uz vcs_info

FMT_BRANCH="%{$fg[green]%}%s/%b%{$reset_color%} %{$fg_bold[green]%}%u%c%{$reset_color%}"
FMT_ACTION="%{$fg[cyan]%}(%a)%{$reset_color%}"
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' check-for-changes true
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%r" "/%S" "${FMT_BRANCH} ${FMT_ACTION}"
zstyle ':vcs_info:*:*' formats "%r" "/%S" "${FMT_BRANCH}"
zstyle ':vcs_info:*:*' nvcsformats "" "%~" ""

PROMPT="${SSH_TTY:+%{$fg[yellow]%\}%n@%m-}%{$reset_color%}%(0?.%{$fg_bold[blue]%}.%{$fg_bold[red]%})"'${vcs_info_msg_0_}'"%{$reset_color%}%(0?.%{$fg[yellow]%}.%{$fg_bold[red]%})%20<..<"'${vcs_info_msg_1_%%.}'"%<<%{$reset_color%} "
RPROMPT='$vcs_info_msg_2_'"%{$reset_color%}"

precmd_functions+=vcs_info
