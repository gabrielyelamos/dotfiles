#!/usr/bin/env zsh
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

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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
