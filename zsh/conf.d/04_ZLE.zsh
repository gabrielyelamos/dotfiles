#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et
# ------------------------------------------------------------------------------
# Key bindings / ZLE configuration.
# ------------------------------------------------------------------------------

# Use Emacs line editing mode
bindkey -e

# Word separators (default '*?_-.[]~=/&;!#$%^(){}<>')
WORDCHARS=''

# <ctrl><left> => previous word
bindkey '^[[1;5D' emacs-backward-word

# <ctrl><right> => next word
bindkey '^[[1;5C' emacs-forward-word

# <up>/<down> => Fizsh history search
autoload -U fizsh-history-search-backward
zle -N fizsh-history-search-forward fizsh-history-search-backward
zle -N fizsh-history-search-backward
bindkey '\e[A' fizsh-history-search-backward
bindkey '\e[B' fizsh-history-search-forward

# F5 => 'source ~/.zshrc'
autoload source-zshrc
zle -N source-zshrc
bindkey $terminfo[kf5] source-zshrc

# <space> => perform history expansion
bindkey ' ' magic-space

# <ctrl><x> <e> => open current line in editor
autoload edit-command-line-in-geany
zle -N edit-command-line-in-geany
bindkey '^Xe' edit-command-line-in-geany

# ..../ => ../../../
autoload rationalize-dots
zle -N rationalize-dots
bindkey . rationalize-dots

# Autoquote URLs pasted in ZLE
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Save cancelled commands to history
TRAPINT () {
  zle && print -s -- $BUFFER
  return $1
}
