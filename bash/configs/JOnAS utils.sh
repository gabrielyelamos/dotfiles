#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   Helper functions for JOnAS (http://jonas.ow2.org).
#
# Dependencies
#   * bash_profile
#   * Commands: jonas.
#   * Configs: Functions.
#
# Author
#   nicoulaj - http://www.ju-n.net
# 
# Project
#   dotfiles - http://github.com/nicoulaj/dotfiles
# ------------------------------------------------------------------------------

# Output JONAS_ROOT and JONAS_BASE variables
alias jonasenv='echo "[\$JONAS_ROOT] $JONAS_ROOT" && echo "[\$JONAS_BASE] $JONAS_BASE"'

# Start JOnAS
alias jonasstart='flagcommand jonas start'
alias jonasstop='flagcommand jonas stop'
