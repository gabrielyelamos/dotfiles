#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et
# ------------------------------------------------------------------------------
# Auto-fu: https://github.com/hchbaw/auto-fu.zsh
# ------------------------------------------------------------------------------

if [[ -f ~/projects/auto-fu.zsh/auto-fu.zsh ]]; then
  . ~/projects/auto-fu.zsh/auto-fu.zsh
  zle-line-init () {auto-fu-init;}; zle -N zle-line-init
  zstyle ':completion:*' completer _oldlist _complete
  zstyle ':auto-fu:var' postdisplay ''
else
  echo "auto-fu is not installed."
fi
