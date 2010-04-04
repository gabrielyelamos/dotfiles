#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   A customized prompt.
#
# Dependencies
#   * bash_profile
#   * Commands: svn, git, sed.
#   * Configs: Functions.
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Constants
# ------------------------------------------------------------------------------

# Maximum length of the path displayed in the prompt.
export PROMPT_PATH_MAX_LENGTH=30

# Symbol to display before the path to mark it has been truncated.
export PROMPT_PATH_TRUNCATION_SYMBOL="..."


# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

# Print infos if the directory is a VCS working copy.
#
# Arguments
#   1 (required) the name of the VCS.
#   2 (required) the info to print.
#   3 (required) must be 1 if the working has uncommited changes.
_print_vcs_info()
{
  local result=$TEXT_WHITE$BOLD
  if [[ $3 -eq 1 ]]; then
    result=$BACKGROUND_BLUE$result
  else
    result=$BACKGROUND_GREEN$result
  fi
  result=$result$1"|"$2$RESET_FORMATTING
  echo -n $result
}

# Print infos if the directory is a Git working copy.
_print_git_info()
{
  # Get the status from Git
  local status=$( git status 2>/dev/null )
  
  # If we are in a versionned directory
  if [[ -n $status ]]; then
    _print_vcs_info "GIT" \
                     "$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* //')" \
                     "$( [[ "$status" == *'working directory clean'* ]] || echo 1 )"
  fi
}

# Print infos if the directory is a Subversion working copy.
_print_svn_info()
{
  # Get the version from SVN
  local version=$( svnversion 2>/dev/null )
  
  # If we are in a versionned directory
  if [[ $version != 'export'* ]]; then
    local revision=$( echo $version | sed -e 's/[^0-9]//g' )
	_print_vcs_info "SVN" \
	                 "r$revision" \
	                 "$( test $version == $revision; echo $? )"
  fi
}

# Print the current path truncated.
# See $PROMPT_PATH* constants.
_print_path()
{
  # Truncate the path
  local dir=${PWD##*/}
  pwdmaxlen=$(( ( $PROMPT_PATH_MAX_LENGTH < ${#dir} ) ? ${#dir} : $PROMPT_PATH_MAX_LENGTH ))
  result=${PWD/#$HOME/\~}
  local pwdoffset=$(( ${#result} - pwdmaxlen ))
  if [ ${pwdoffset} -gt "0" ]; then
    result=${result:$pwdoffset:$pwdmaxlen}
    result=$PROMPT_PATH_TRUNCATION_SYMBOL/${result#*/}
  fi
  
  # While here, update the terminal title
  set-terminal-title $result
  
  # Print the result
  echo -n $result
}

# Print the custom prompt.
_print_custom_prompt()
{
  _print_svn_info
  _print_git_info
  _print_path
}


# ------------------------------------------------------------------------------
# Prompt override
# ------------------------------------------------------------------------------

# Define the custom prompt.
PS1=" \[$BOLD\]\$\[$RESET_FORMATTING\] "
add-prompt-command "_print_custom_prompt"
