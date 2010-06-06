#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Description
#   Zsh completion settings.
# ------------------------------------------------------------------------------

zstyle ':completion:*' file-sort name
zstyle ':completion:*' use-cache true
zstyle ':completion:*' list-colors ${(s.:.)ZLS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose true
zstyle ':completion:*' squeeze-slashes true

zstyle ':completion:*:*:kill:*' command 'ps -a -w -w -u $USER -o pid,cmd'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
