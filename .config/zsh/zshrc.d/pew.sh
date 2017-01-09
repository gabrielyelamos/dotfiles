#!/bin/zsh
(( $+commands[pew] )) && {
  export WORKON_HOME=~/.virtualenvs
  export PROJECT_HOME=~/workspace
  source $(pew shell_config)
}

