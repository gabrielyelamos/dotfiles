#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   Helper functions for Maven.
#
# Dependencies
#   * bash_profile
#   * Commands: mvn.
#
# Author
#   nicoulaj - http://www.ju-n.net
# 
# Project
#   dotfiles - http://github.com/nicoulaj/dotfiles
# ------------------------------------------------------------------------------

# Wrapper function for Maven's mvn command.
#mvn-color()
#{
#  # Filter mvn output using sed
#  mvn $@ | sed -e "s/\(\[INFO\]\ \-.*\)/${TEXT_BLUE}${BOLD}\1/g" \
#               -e "s/\(\[INFO\]\ \[.*\)/${RESET_FORMATTING}${BOLD}\1${RESET_FORMATTING}/g" \
#               -e "s/\(\[INFO\]\ BUILD SUCCESSFUL\)/${BOLD}${TEXT_GREEN}\1${RESET_FORMATTING}/g" \
#               -e "s/\(\[WARNING\].*\)/${BOLD}${TEXT_YELLOW}\1${RESET_FORMATTING}/g" \
#               -e "s/\(\[ERROR\].*\)/${BOLD}${TEXT_RED}\1${RESET_FORMATTING}/g" \
#               -e "s/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/${BOLD}${TEXT_GREEN}Tests run: \1${RESET_FORMATTING}, Failures: ${BOLD}${TEXT_RED}\2${RESET_FORMATTING}, Errors: ${BOLD}${TEXT_RED}\3${RESET_FORMATTING}, Skipped: ${BOLD}${TEXT_YELLOW}\4${RESET_FORMATTING}/g"
#
#  # Make sure formatting is reset
#  echo -ne ${RESET_FORMATTING}
#}

export SOURCE_HIGHLIGHT_ADDONS_DIR=$HOME/projects/dotfiles/source-highlight

mvn-color()
{
  mvn $@ | source-highlight --lang-def=$SOURCE_HIGHLIGHT_ADDONS_DIR/maven2.lang --outlang-def=esc.outlang --style-file=$SOURCE_HIGHLIGHT_ADDONS_DIR/terminal.style -o STDOUT
}

# Override the mvn command with the colorized one.
alias default-mvn=`which mvn`
alias mvn="mvn-color"
