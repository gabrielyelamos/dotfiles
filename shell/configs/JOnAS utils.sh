#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   Helper functions for JOnAS (http://jonas.ow2.org).
#
# Dependencies
#   * bash_profile
#   * Commands: jonas.
#   * Configs: Functions.
# ------------------------------------------------------------------------------

# Output JONAS_ROOT and JONAS_BASE variables
alias jonas-env='echo "[\$JONAS_ROOT] $JONAS_ROOT" && echo "[\$JONAS_BASE] $JONAS_BASE"'

# Start JOnAS
alias jonas-start='flag-command jonas start'
alias jonas-stop='flag-command jonas stop'

# Update PATH
export PATH=$JONAS_ROOT/bin:$PATH
