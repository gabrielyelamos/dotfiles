#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et
# ------------------------------------------------------------------------------
# Default applications settings, aliases and file types handling.
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# MIME types handling
# ------------------------------------------------------------------------------

# Zsh MIME types handler.
autoload -U zsh-mime-setup
autoload -U zsh-mime-handler
zsh-mime-setup


# ------------------------------------------------------------------------------
# Directory browsing
# ------------------------------------------------------------------------------

alias ls='ls                                  --classify --group-directories-first --color=auto'
alias ll='ls -l              --human-readable --classify --group-directories-first --color=auto'
alias la='ls -l --almost-all --human-readable --classify --group-directories-first --color=auto'


# ------------------------------------------------------------------------------
# File management
# ------------------------------------------------------------------------------

alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -i'


# ------------------------------------------------------------------------------
# Text editor
# ------------------------------------------------------------------------------

# Geany, default to vim if not available.
EDITOR=`which geany`
EDITOR=${EDITOR:-vim}
VISUAL=`which geany`
VISUAL=${VISUAL:-vim}
CVSEDITOR=`which geany`
CVSEDITOR=${CVSEDITOR:-vim}
SVN_EDITOR=`which geany`
SVN_EDITOR=${SVN_EDITOR:-vim}


# ------------------------------------------------------------------------------
# Web browser
# ------------------------------------------------------------------------------

# Google Chrome/elinks.
[[ -n "$DISPLAY" ]] && BROWSER="google-chrome" || BROWSER="elinks"

# Zsh web browser handler.
autoload -U pick-web-browser
zstyle ':mime:*' x-browsers google-chrome firefox elinks
alias -s html=pick-web-browser


# ------------------------------------------------------------------------------
# Pager
# ------------------------------------------------------------------------------

# less.
PAGER="less"
MANPAGER="less"

# Settings for less.
export LESS="--long-prompt --status-column --HILITE-UNREAD --ignore-case --tabs=2 --shift 5 --tilde"
export LESSCHARSET=utf-8
export LESSHISTFILE="$HOME/.lesshst"
export LESSHISTSIZE=100

# Use source-highlight if available, else fall back to lesspipe.
if [[ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]]; then
  export LESS="$LESS --RAW-CONTROL-CHARS"
  export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
else
  [[ -x /usr/bin/lesspipe ]] && eval $(lesspipe)
fi

# Vim as pager.
[[ -f /usr/share/vim/vimcurrent/macros/less.sh ]] && alias vless='/usr/share/vim/vimcurrent/macros/less.sh'


# ------------------------------------------------------------------------------
# Grep
# ------------------------------------------------------------------------------

# Ignore SCM directories.
if ! $(grep --exclude-dir 2> /dev/null); then
    export GREP_OPTIONS="--color=auto --exclude-dir=.svn --exclude=\*.pyc --exclude-dir=.hg --exclude-dir=.bzr --exclude-dir=.git"
else
    export GREP_OPTIONS="--color=auto --exclude=\*.svn\* --exclude=\*.pyc --exclude=\*.hg\* --exclude=\*.bzr\* --exclude=\*.git\*"
fi


# ------------------------------------------------------------------------------
# Gnome
# ------------------------------------------------------------------------------

alias o='gnome-open'
alias so='gksudo gnome-open'


# ------------------------------------------------------------------------------
# todo.sh
# ------------------------------------------------------------------------------

if [[ -n `which todo.sh` ]]; then
  alias todo.sh='env TODO_STORAGE_HOME=$TODO_STORAGE_HOME todo.sh'
  alias t='todo.sh'
  compdef t=todo.sh
fi


# ------------------------------------------------------------------------------
# Package auto-suggestion on "command not found"
# ------------------------------------------------------------------------------

if [ -e /etc/zsh_command_not_found ]; then
  . /etc/zsh_command_not_found
fi
