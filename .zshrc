#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Initialization file for ZSH.
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------


# Print a line.
#
# Arguments
#     1 (required) the character repeated to draw the line.
#     2 (optional) the length of the line to print.
shellrc_print-line ()
{
  local line_length=${2:-$(tput cols)}
  echo -ne `echo ""|awk '
  {
    _SPACES = '${line_length}'
    while (_SPACES-- > 0) printf ("'$1'")
  }'`
  echo
}


# Print the top line.
shellrc_print-top-line()
{
  echo -ne "──❮ `set_color brown`$USER@$HOST`set_color normal` ❯"
  shellrc_print-line '─' $(( `tput cols` - ${#USER} - ${#HOST} - ${#SHELL_TYPE} - 7 ))
}


# Execute the header scripts.
shellrc_exec-headers ()
{
  local file

  # Loop through files in the header folder
  # (Trick: replace spaces in filenames with '&' to enter the for loop)
  for file in `find $HOME/zsh/header.d/* ! -name '.*' -xtype f | sort | sed -e "s/ /\\&/g"`
  do

	# Restore spaces
	file=`echo $file | sed -e "s/\\&/ /g"`
        
    # If this is a file, execute it
    if [[ -f "$file" ]]; then
      eval "$file"
    fi
  done
}


# Source the given file.
#
# Arguments
#     1 (required) the file to source.
shellrc_load-config ()
{
  # Extract a readable name from the file name
  # Example: "/home/user/folder/010_Aliases and functions.sh" => "Aliases and functions"
  local config_name="$(expr match "`echo $@`" '.*[/_]\([^\.]*\)')"

  # Source the file
  source "`echo $@`" &> /tmp/shellrc_config_out.log

  # Append the output to the report if needed
  if [[ -s /tmp/shellrc_config_out.log ]]; then
    echo "`set_color -o blue`$config_name`set_color normal` > " >> /tmp/shellrc_configs_out
    (cat /tmp/shellrc_config_out.log | sed -e "s/\(.*\)/\ \ \1/g"; echo) >> /tmp/shellrc_configs_out
  fi

  # Update the configurations line
  if [[ -z "${SHELLRC_CONFIGS_LINE}" ]]; then
    export SHELLRC_CONFIGS_LINE="`set_color -o blue`Configs▸`set_color normal` $config_name"
  else
    export SHELLRC_CONFIGS_LINE=${SHELLRC_CONFIGS_LINE}" `set_color blue`▪`set_color normal` $config_name"
  fi
}


# Source the files recursively in the given folder.
#
# Arguments
#     1 (required) the folder to process.
#
# Options
#     --ask Prompt the user before loading each script.
#           To be put before first argument.
shellrc_load-folder-configs ()
{
  local file
  
  # Declare a boolean to determine the success of the operation
  local success=true
  
  # Escape spaces in the folder name
  local folder=`echo $1 | sed -e "s/ /\\ /g"`
  
  # Check that a valid folder was given
  if [[ -d "$folder" ]]; then
    
    # Check the folder is not empty
    if [ `ls "$folder" | wc -l` -ne 0 ]; then
    
      # Loop through files in the folder
      # (Trick: replace spaces in filenames with '&' to enter the for loop)
      for file in `find $folder/* ! -name '.*' -xtype f | sort | sed -e "s/ /\\&/g"`
      do
      
        # Restore spaces
        file=`echo $file | sed -e "s/\\&/ /g"`

        # Try loading the config
        shellrc_load-config $file
        
      done
      
    fi

  # If this is not a valid folder
  else
    echo -e "`set_color -o red`'$1' not found or invalid.`set_color normal`"
    success=false
  fi

  # If something went wrong, exit
  if ! $success; then
    `exit 1`
  fi
}


# Load the configurations
shellrc_load-configs ()
{
  # Source confs
  shellrc_load-folder-configs "$HOME/zsh/conf.d"
  [[ -n $SHELLRC_CONFIGS_LINE ]] && echo -e "$SHELLRC_CONFIGS_LINE"
}


# Print the configurations output report.
shellrc_print-configs-output ()
{
  if [[ -s /tmp/shellrc_configs_out ]]; then
    shellrc_print-line "`set_color red`─"
    cat /tmp/shellrc_configs_out | head --lines=-1
    shellrc_print-line "`set_color red`─"
  fi
}


# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

# Local variables declarations
SHELLRC_CONFIGS_LINE=""

# Clear the terminal
clear

# Clean traces from a previous execution
rm -f /tmp/shellrc_configs_out

# Blank line
echo

# Print the top line
shellrc_print-top-line

# Load the configurations
shellrc_load-configs

# Print the footer line
shellrc_print-line "─"

# Print the configurations output
shellrc_print-configs-output

# Blank line
echo

# Unset all variables and functions to ensure their visibility stay local
unset SHELLRC_CONFIGS_LINE
unset -f shellrc_print-line
unset -f shellrc_print-top-line
unset -f shellrc_exec-headers
unset -f shellrc_load-config
unset -f shellrc_load-folder-configs
unset -f shellrc_load-configs
unset -f shellrc_print-configs-output
