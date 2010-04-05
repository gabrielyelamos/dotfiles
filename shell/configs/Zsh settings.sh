#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   General settings for the Zsh shell.
# ------------------------------------------------------------------------------

if [[ $SHELL_TYPE == 'zsh' ]]; then

  zstyle ':completion:*' completer _list _oldlist _expand _complete _ignored _match _correct _approximate _prefix
  zstyle ':completion:*' max-errors 1 numeric
  zstyle :compinstall filename '/home/nicoulaj/.zshrc'

  autoload -Uz compinit
  compinit

  HISTFILE=~/.histfile
  HISTSIZE=10000
  SAVEHIST=20000
  setopt appendhistory autocd extendedglob nomatch notify
  unsetopt beep
  bindkey -e

fi
