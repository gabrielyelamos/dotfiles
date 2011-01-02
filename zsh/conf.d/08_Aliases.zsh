#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et
# ------------------------------------------------------------------------------
# Commands shortcuts and aliases.
# ------------------------------------------------------------------------------


# ls
alias ls='ls                                  --classify --group-directories-first --color=auto'
alias ll='ls -l              --human-readable --classify --group-directories-first --color=auto'
alias la='ls -l --almost-all --human-readable --classify --group-directories-first --color=auto'

# dir
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# shred
alias shred='shred --iterations 30 --zero --remove --verbose'

# Force interactive commands
alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -i'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Shortcuts to open and edit files
alias o='gnome-open'
alias so='gksudo gnome-open'

# Todo.sh
if [[ -n `which todo.sh` ]]; then
  alias todo.sh='env TODO_STORAGE_HOME=$TODO_STORAGE_HOME todo.sh'
  alias t='todo.sh'
  compdef t=todo.sh
fi
