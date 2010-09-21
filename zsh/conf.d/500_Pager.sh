#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Settings for the pager.
# ------------------------------------------------------------------------------


# Settings for less.
export LESS="--long-prompt --status-column --HILITE-UNREAD --ignore-case --tabs=2 --shift 5 --tilde"
export LESSCHARSET=utf-8
export LESSHISTFILE="$HOME/.lesshst"
export LESSHISTSIZE=100

# If source-highlight available, else fall back to lesspipe.
if [[ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]]; then
  export LESS="$LESS --RAW-CONTROL-CHARS"
  export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
else
  [[ -x /usr/bin/lesspipe ]] && eval $(lesspipe)
fi

# Vim as pager.
[[ -f /usr/share/vim/vimcurrent/macros/less.sh ]] && alias vless='/usr/share/vim/vimcurrent/macros/less.sh'
