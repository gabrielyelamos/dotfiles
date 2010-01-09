#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   Helper functions for JOnAS (http://jonas.ow2.org).
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
alias jonasstart='flag jonas start'
alias jonasstop='flag jonas stop'
