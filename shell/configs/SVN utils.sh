#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   Helper functions for Subversion.
#
# Dependencies
#   * Commands: svn, find.
# ------------------------------------------------------------------------------


# Remove all .svn folders recursively.
alias svn-disconnect='find . -type d -name '.svn' -print0 | xargs -0 rm -rdf'


# Add all files to versioning recursively.
alias svn-add-all='find "$PWD" -exec svn add {} 2>/dev/null \;'


# Display the log at the repository head revision.
alias svn-log='svn log -v -r HEAD:0 | $PAGER'


# Edit the svn log at the given revision.
#
# Arguments
#   1 (required) The number of the revision to edit.
svn-edit-log() {
    svn propedit svn:log --revprop -r$1 --editor-cmd $EDITOR
}


# Update and display the log between the two revisions.
#
# Arguments
#   1 (optionnal) The revision.
svn-up-and-log()
{
  local old_revision=`svn_revision $@`
  local first_update=$((${old_revision} + 1))
  svn up -q $@
  if [ $(svn_revision $@) -gt ${old_revision} ]; then
    svn log -v -rHEAD:${first_update} $@
  else
    echo "No changes."
  fi
}
