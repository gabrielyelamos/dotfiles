#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et
# ------------------------------------------------------------------------------
# Key bindings for the Zsh shell.
# ------------------------------------------------------------------------------

# Use Emacs line editing mode
bindkey -e

# <ctrl><left> => previous word
bindkey '^[[1;5D' emacs-backward-word

# <ctrl><right> => next word
bindkey '^[[1;5C' emacs-forward-word

# <up> => Backward history search
bindkey "^[[A" up-line-or-search

# <down> => Forward history search
bindkey "^[[B" down-line-or-search

# Default: '*?_-.[]~=/&;!#$%^(){}<>'
export WORDCHARS=''

# Custom ZLE Widget to bind F5 => 'source ~/.zshrc'
_refresh() { source ~/.zshrc }
zle -N _refresh
bindkey $terminfo[kf5] _refresh

# Perform history expansion on space
bindkey ' ' magic-space

# Open current line in editor on <ctrl><x> <e>
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

# Rationalize dots (allows to cd ...../)
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
