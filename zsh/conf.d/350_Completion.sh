#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Description
#   Shell completion settings.
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Bash completion compatibility
# ------------------------------------------------------------------------------

# Activate Bash auto-completion
autoload -U bashcompinit
bashcompinit
#bash_source() {
#  alias shopt=':'
#  alias _expand=_bash_expand
#  alias _complete=_bash_comp
#  emulate -L sh
#  setopt kshglob noshglob braceexpand
#  source "$@"
#}
#have() {
#  unset have
#  (( ${+commands[$1]} )) && have=yes
#}
#for conf in /etc/bash_completion.d/*; do
#  bash_source "$conf"
#done


# ------------------------------------------------------------------------------
# Zsh completion
# ------------------------------------------------------------------------------

# Activate auto-completion
autoload -Uz compinit
compinit

zstyle ':completion:*' file-sort name
zstyle ':completion:*' use-cache true
zstyle ':completion:*' list-colors ${(s.:.)ZLS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose true
zstyle ':completion:*' squeeze-slashes true

zstyle ':completion:*:*:kill:*' command 'ps -a -w -w -u $USER -o pid,cmd --sort=-pid'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
