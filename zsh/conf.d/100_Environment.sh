#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et
# ------------------------------------------------------------------------------
# Constants and environment.
# ------------------------------------------------------------------------------

# Add some directories to $PATH.
PATH=$HOME/bin:$PATH

# Some personal info.
NAME='Julien Nicoulaud'
MAIL='julien.nicoulaud@gmail.com'
GPGKEY='A20BF77D'

# Constants used for Debian packaging.
DEBFULLNAME=$NAME
DEBEMAIL=$MAIL

# Pager: less
PAGER="less"
MANPAGER="less"

# Editor: Geany, default to vim if not available.
EDITOR=`which geany`
EDITOR=${EDITOR:-vim}
VISUAL=`which geany`
VISUAL=${VISUAL:-vim}
CVSEDITOR=`which geany`
CVSEDITOR=${CVSEDITOR:-vim}
SVN_EDITOR=`which geany`
SVN_EDITOR=${SVN_EDITOR:-vim}

# Web browser: ELinks/Google Chrome.
[[ -n "$DISPLAY" ]] && BROWSER="google-chrome" || BROWSER="elinks"
