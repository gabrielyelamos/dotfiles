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

PROMPT="%(0?.%{$FG[71]%}.%{$FG[124]%})${SSH_TTY:+[%n@%m]}%{$FX[bold]%}%30<..<"'${vcs_info_msg_0_%%.}'"%<<%(!.❯❯❯.❯)%{$FX[no-bold]%}%{$reset_color%} "
RPROMPT="%{$FG[darkgrey]%}"'$vcs_info_msg_1_'"%{$reset_color%}"

precmd_functions+=vcs_info
