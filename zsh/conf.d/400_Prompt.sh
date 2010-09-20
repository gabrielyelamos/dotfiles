#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Prompt for the Zsh shell.
# ------------------------------------------------------------------------------

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' check-for-changes true
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%S" "%r/%s/%b %u%c (%a)"
zstyle ':vcs_info:*:*' formats "%S" "%r/%s/%b %u%c"
zstyle ':vcs_info:*:*' nvcsformats "%30<..<%~%<<" ""

PROMPT="${SSH_TTY:+%{$fg[green]%\}[%n@%m]}%{$reset_color%}%(0?.%{$fg_bold[green]%}.%{$fg[red]%})%30<..<"'${vcs_info_msg_0_%%.}'"%<<%(!.❯❯❯.❯)%{$reset_color%} "
RPROMPT="%{$fg_bold[grey]%}"'$vcs_info_msg_1_'"%{$reset_color%}"

precmd_functions+=vcs_info
