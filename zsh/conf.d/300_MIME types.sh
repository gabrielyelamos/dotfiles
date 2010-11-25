#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Shell MIME types handling settings.
# ------------------------------------------------------------------------------

# Breaks todo.sh completion
# autoload -U zsh-mime-setup && zsh-mime-setup

autoload -U zsh-mime-handler

autoload -U pick-web-browser
zstyle ':mime:*' x-browsers google-chrome firefox elinks
alias -s html=pick-web-browser
