#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Settings for the pager.
# ------------------------------------------------------------------------------


# Settings for less.
export LESS="--long-prompt --status-column --HILITE-UNREAD --ignore-case --tabs=2 --shift 5 --tilde"
export LESSCHARSET=utf-8
export LESSHISTFILE="$HOME/.lesshst"
export LESSHISTSIZE=100

# Lesspipe for browsing archives.
[[ -x /usr/bin/lesspipe ]] && eval $(lesspipe)

# Vim as pager.
[[ -f /usr/share/vim/vimcurrent/macros/less.sh ]] && alias vless='/usr/share/vim/vimcurrent/macros/less.sh'
