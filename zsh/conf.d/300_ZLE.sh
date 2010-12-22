#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Key bindings for the Zsh shell.
# ------------------------------------------------------------------------------

# Use Emacs line editing mode
bindkey -e

# <CTRL><LEFT> => previous word
bindkey '^[[1;5D' emacs-backward-word

# <CTRL><RIGHT> => next word
bindkey '^[[1;5C' emacs-forward-word

# Default: '*?_-.[]~=/&;!#$%^(){}<>'
export WORDCHARS=''

# Custom ZLE Widget to bind F5 => 'source ~/.zshrc'
_refresh() { source ~/.zshrc }
zle -N _refresh
bindkey $terminfo[kf5] _refresh

# Perform history expansion on space
bindkey ' ' magic-space
