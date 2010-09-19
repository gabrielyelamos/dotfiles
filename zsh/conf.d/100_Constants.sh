#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Constants.
# ------------------------------------------------------------------------------

# Add some directories to $PATH.
export PATH=$HOME/bin:$PATH

# Add some directories to $fpath. 
fpath=(~/zsh/comp.d $fpath)
#autoload -U ~/zsh/comp.d/*

# Constants used for Debian packaging.
export DEBFULLNAME='Julien Nicoulaud'
export DEBEMAIL='julien.nicoulaud@gmail.com'
export GPGKEY='A20BF77D'

# Pager: less
export PAGER="less"
export MANPAGER="less"

# Editor: Geany, default to vim if not available.
export EDITOR=`which geany`
export EDITOR=${EDITOR:-vim}
export VISUAL=`which geany`
export VISUAL=${VISUAL:-vim}
export CVSEDITOR=`which geany`
export CVSEDITOR=${CVSEDITOR:-vim}
export SVN_EDITOR=`which geany`
export SVN_EDITOR=${SVN_EDITOR:-vim}

# Web browser: elinks/Firefox.
export BROWSER="elinks"
if [ "$DISPLAY" ]; then
  export BROWSER="google-chrome"
fi
