#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description:
#     "Modular" bashrc/bash_profile.
#       - First executes every script in header/ to output a custom terminal
#         header or welcome screen.
#       - Then sources the configs in configs/
#         * configs/active/: sources every file found recursively.
#         * configs/prompt/: prompts the user to source every file
#           found recursively.
#
# Usage:
#     The directory structure must be as follows:
#         |-- header
#         |-- configs
#         |   |-- active
#         |   |-- inactive
#         |   |-- prompt
#         |-- bash_profile.sh
#
#     Then make sure bash_profile.sh is sourced at bash startup, for example by
#     setting a symbolic link this way:
#         ln -s /path/to/bash_profile.sh $HOME/.bash_profile
#
# Author
#     Julien Nicoulaud - julien.nicoulaud@gmail.com
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------

# Formatting constants
export BOLD=`tput bold`
export UNDERLINE_ON=`tput smul`
export UNDERLINE_OFF=`tput rmul`
export TEXT_BLACK=`tput setaf 0`
export TEXT_RED=`tput setaf 1`
export TEXT_GREEN=`tput setaf 2`
export TEXT_YELLOW=`tput setaf 3`
export TEXT_BLUE=`tput setaf 4`
export TEXT_MAGENTA=`tput setaf 5`
export TEXT_CYAN=`tput setaf 6`
export TEXT_WHITE=`tput setaf 7`
export BACKGROUND_BLACK=`tput setab 0`
export BACKGROUND_RED=`tput setab 1`
export BACKGROUND_GREEN=`tput setab 2`
export BACKGROUND_YELLOW=`tput setab 3`
export BACKGROUND_BLUE=`tput setab 4`
export BACKGROUND_MAGENTA=`tput setab 5`
export BACKGROUND_CYAN=`tput setab 6`
export BACKGROUND_WHITE=`tput setab 7`
export RESET_FORMATTING=`tput sgr0`


# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------


# Print the header.
function bash-profile_print-header()
{
  # Loop through files in the header folder
  for file in $BASH_PROFILE_LOCATION/header/active*; do

    # If this is a file, execute it
    if [ -f "$file" ]; then
      "$file"
    fi
  done
}

# Ask the user a "yes/no" question. Defaults to "no".
#
# Arguments
#     1 (optional) the question to ask.
function bash-profile_ask() {
  read -s -n1 -p "$@ [y/N] " ans
  case "$ans" in
    y*|Y*)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}


# Source the given file.
#
# Arguments
#     1 (required) the file to source.
#
# Options
#     --ask Prompt the user before.
#           To be put before first argument.
function bash-profile_load-bash-config()
{
  # Handle the --ask option
  if [ $1 = "--ask" ]; then
    shift
    ask=0
  else
    ask=1
  fi

  # Extract a readable name from the file name
  # Example: "/home/user/folder/010_Aliases and functions.sh" => "Aliases and functions"
  config_name=$(expr match "$1" '.*[/_]\([^\.]*\)')
  
  # Ask if needed
  if [ $ask -eq 0 ]; then
    if ! bash-profile_ask "Load $config_name ?"; then
      bash-profile_print-configs-line
      return 1
    fi
  fi
  
  # Source the file
  source $1
  
  # Add the file name to the array of loaded configs and update the display
  _BASH_CONFIGS_LOADED[${#_BASH_CONFIGS_LOADED[@]}]="$config_name"
  bash-profile_print-configs-line
}


# Source the files recursively in the given folder.
#
# Arguments
#     1 (required) the folder to process.
#
# Options
#     --ask Prompt the user before loading each script.
#           To be put before first argument.
function bash-profile_load-folder-bash-configs()
{
  # Handle the --ask option
  if [ $1 = "--ask" ]; then
    shift
    load_opts="--ask"
  else
    load_opts=""
  fi
  
  # Declare a boolean to determine the success of the operation
  success=true
  
  # Check that a valid folder was given
  if [ -d $1 ]; then
  
    # Loop through files in the folder
    for file in $1/*; do
    
      # If this is a file, try loading it
      if [ -f $file ]; then
        bash-profile_load-bash-config $load_opts $file
        
      # If this is a folder, call this function bash-profile_recursively
      elif [ -d $file ]; then
        bash-profile_load-folder-bash-configs "$file"
      fi
    done
    
  # If this is not a valid folder
  else
    echo "${TEXT_RED}${BOLD}'$1' is not a valid folder.${RESET_FORMATTING}"
    success=false
  fi
  
  # If something went wrong, exit
  if ! $success; then
    `exit 1`
  fi
}

# Print the configuration loaded summary.
function bash-profile_print-configs-line()
{
  local _CONFIGS_LINE=""

  # If no configurations loaded, clear the line
  if [ ! ${#_BASH_CONFIGS_LOADED[@]} = 0 ]; then

    # Add the line title
    _CONFIGS_LINE="${TEXT_BLUE}${BOLD}Configs > ${RESET_FORMATTING}"
    
    # For each stored loaded configuration
    for ((i=0;i<${#_BASH_CONFIGS_LOADED[@]};i++)); do
    
      # Add the config name
      _CONFIGS_LINE=${_CONFIGS_LINE}${_BASH_CONFIGS_LOADED[${i}]}
      
      # If this is not the last, add a separator
      if [ ! $i = `expr ${#_BASH_CONFIGS_LOADED[@]} - 1` ]; then
        _CONFIGS_LINE=${_CONFIGS_LINE}" ${TEXT_BLUE}|${RESET_FORMATTING} "
      fi
    done
  fi
  
  # Print the line at the last saved position
  echo -e `tput rc; tput ed`$_CONFIGS_LINE
}

# Load the configurations
function bash-profile_load-configs()
{
  # Save the current cursor position
  tput sc

  # Source scripts in active/
  bash-profile_load-folder-bash-configs "$BASH_PROFILE_LOCATION/configs/active"

  # Source scripts in prompt/ (ask first)
  bash-profile_load-folder-bash-configs --ask "$BASH_PROFILE_LOCATION/configs/prompt"
}

# Print the footer line.
function bash-profile_print-footer()
{
  local _WINDOW_Y=`tput cols`
  local _FOOTER_LINE_CHARACTER="_"
  echo -e ${BOLD}`echo ""|awk '
  {
    _SPACES = '${_WINDOW_Y}'
    while (_SPACES-- > 0) printf ("'${_FOOTER_LINE_CHARACTER}'")
  }'`${RESET_FORMATTING}
}


# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

# Resolve the real location of this file
export BASH_PROFILE_LOCATION="$HOME/$(dirname "$(test -L "$BASH_SOURCE" && readlink "$BASH_SOURCE" || echo "$BASH_SOURCE")")"

# Local variables declarations
declare _BASH_CONFIGS_LOADED

# Switch file separator to handle filenames with spaces
_SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# Print the header
bash-profile_print-header

# Load the configurations
bash-profile_load-configs

# Print the footer
bash-profile_print-footer

# Restore file separator
IFS=$_SAVEIFS

# Unset all variables and functions to ensure their visibility stay local
unset -f bash-profile_print-header
unset -f bash-profile_ask
unset -f bash-profile_load-bash-config
unset -f bash-profile_load-folder-bash-configs
unset -f bash-profile_print-configs-line
unset -f bash-profile_load-configs
unset -f bash-profile_print-footer

# Unset all variables and functions to ensure their visibility stay local
unset _SAVEIFS
unset _BASH_CONFIGS_LOADED

