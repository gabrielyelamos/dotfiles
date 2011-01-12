#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et
# ------------------------------------------------------------------------------
# Prompt for the Zsh shell.
# ------------------------------------------------------------------------------

# Customizable parameters.
PROMPT_PATH_MAX_LENGTH=30
PROMPT_SUCCESS_COLOR=$FG[71]
PROMPT_FAILURE_COLOR=$FG[124]
PROMPT_VCS_INFO_COLOR=$FG[darkgrey]
PROMPT_VCS_CHANGES_COLOR=$FG[172]

# Load required modules and register hook.
autoload vcs_info add-zsh-hook && add-zsh-hook precmd vcs_info

# Set vcs_info parameters.
zstyle ':vcs_info:*' enable hg bzr svn git
zstyle ':vcs_info:*:*' check-for-changes true # Can be slow on big repos.
zstyle ':vcs_info:*:*' unstagedstr " ●"
zstyle ':vcs_info:*:*' actionformats "%S" "%r/%s/%b (%a)" "%u"
zstyle ':vcs_info:*:*' formats "%S" "%r/%s/%b" "%u"
zstyle ':vcs_info:*:*' nvcsformats "%~" "" ""

# Define prompts.
PROMPT="%(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})${SSH_TTY:+[%n@%m]}%{$FX[bold]%}%$PROMPT_PATH_MAX_LENGTH<..<"'${vcs_info_msg_0_%%.}'"%<<%(!.❯❯❯.❯)%{$FX[no-bold]%}%{$FX[reset]%} "
RPROMPT="%{$PROMPT_VCS_INFO_COLOR%}"'$vcs_info_msg_1_'"%{$FX[reset]%}%{$PROMPT_VCS_CHANGES_COLOR%}"'$vcs_info_msg_2_'"%{$FX[reset]%}"
