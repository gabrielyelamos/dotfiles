#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   Displays a random quote.
#
# Dependencies
#   * Commands: fortune.
# ------------------------------------------------------------------------------

[[ -n `which fortune` ]] && fortune all -a
