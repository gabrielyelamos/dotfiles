#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et
# ------------------------------------------------------------------------------
# Key bindings for the Zsh shell.
# ------------------------------------------------------------------------------

# Use Emacs line editing mode
bindkey -e

# Word separators (default '*?_-.[]~=/&;!#$%^(){}<>')
export WORDCHARS=''

# <ctrl><left> => previous word
bindkey '^[[1;5D' emacs-backward-word

# <ctrl><right> => next word
bindkey '^[[1;5C' emacs-forward-word

# <up> => Backward history search
bindkey "^[[A" up-line-or-search

# <down> => Forward history search
bindkey "^[[B" down-line-or-search

# F5 => 'source ~/.zshrc'
autoload source-zshrc
zle -N source-zshrc
bindkey $terminfo[kf5] source-zshrc

# <space> => perform history expansion
bindkey ' ' magic-space

# <ctrl><x> <e> => open current line in editor
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

# ..../ => ../../../
autoload rationalize-dots
zle -N rationalize-dots
bindkey . rationalize-dots
