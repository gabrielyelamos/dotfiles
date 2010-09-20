#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Prompt for the Zsh shell.
# ------------------------------------------------------------------------------

autoload -Uz vcs_info

FMT_BRANCH="%{$fg_bold[grey]%}%r/%s/%b%{$reset_color%} %{$fg_bold[grey]%}%u%c%{$reset_color%}"
FMT_ACTION="%{$fg_bold[grey]%}(%a)%{$reset_color%}"
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' check-for-changes true
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%S" "${FMT_BRANCH} ${FMT_ACTION}"
zstyle ':vcs_info:*:*' formats "%S" "${FMT_BRANCH}"
zstyle ':vcs_info:*:*' nvcsformats "%2~" ""

PROMPT="${SSH_TTY:+%{$fg[green]%\}[%n@%m]}%{$reset_color%}%(0?.%{$fg_bold[green]%}.%{$fg[red]%})%20<..<"'${vcs_info_msg_0_%%.}'"%<<❯%{$reset_color%} "
RPROMPT='$vcs_info_msg_1_'"%{$reset_color%}"

precmd_functions+=vcs_info
