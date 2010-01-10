#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   Helper functions for Eclipse.
#
# Dependencies
#   * Commands: ps, awk, rm.
#   * Configs: Functions.
#
# Author
#   nicoulaj - http://www.ju-n.net
# 
# Project
#   dotfiles - http://github.com/nicoulaj/dotfiles
# ------------------------------------------------------------------------------


# "Repairs" damaged Eclipse workspace that prevents Eclipse from booting
# by destroying metadata informations.
# Use File -> Import -> General-> Existing projects into workspace to find
# your projects back.
#
# Arguments
#   1 (required) the path to an Eclipse workspace root.
function eclipse-repair-workspace()
{
  # First make sure Eclipse is not running
  local pid pname first
  first=true
  for pid in $(ps -e | grep "eclipse" | awk '{print $1;}') ; do
    if [ first ];
    then
      echo "It seems Eclipse is running. It is strongly recommended that you shut down all running Eclipse instances before continuing."
      first=false
    fi
    if ask "Kill Eclipse process (pid $pid) ?"; then
      kill "-TERM" $pid
    else
      return 1
    fi
  done
  
  # Then do it the hard way
  local target="${1}/.metadata/.plugins/org.eclipse.core.resources/"
  if [ -d $target ];
  then
    if ask "Destroy workspace projects metadata ?"
    then
      rm -rf $target
    fi
  else
    echo "Error: '$1' is not the root of an Eclipse workspace."
    return 1
  fi
}
