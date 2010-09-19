#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Shell MIME types handling settings.
# ------------------------------------------------------------------------------

autoload -U zsh-mime-setup
autoload -U zsh-mime-handler
zsh-mime-setup

autoload -U pick-web-browser
zstyle ':mime:*' x-browsers google-chrome firefox elinks
alias -s html=pick-web-browser
