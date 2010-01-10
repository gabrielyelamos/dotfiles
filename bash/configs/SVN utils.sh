#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   Helper functions for Subversion.
#
# Dependencies
#   * Commands: svn, find.
#
# Author
#   nicoulaj - http://www.ju-n.net
# 
# Project
#   dotfiles - http://github.com/nicoulaj/dotfiles
# ------------------------------------------------------------------------------

# Remove all .svn folders recursively
alias svn-disconnect='find . -type d -name '.svn' -print0 | xargs -0 rm -rdf'

# Add all files to versioning recursively
alias svn-add-all='find "$PWD" -exec svn add {} 2>/dev/null \;'

# Display the log at the repository head revision
alias svn-log='svn log -v -r HEAD:0 | most'

# Edit the svn log at the given revision
#
# Arguments
#   1 (required) The number of the revision to edit.
svn-edit-log() {
    svn propedit svn:log --revprop -r$1 --editor-cmd vim
}
