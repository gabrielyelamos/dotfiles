#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   Helper functions for Gnome.
#
# Dependencies
#   * Commands: gconftool.
#   * Variables: DOTFILES_LOCATION.
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

# Load the given configuration for Gnome-panel.
#
# Arguments
#   1 (required) the name of the config to load. The file will be looked
#                up at $DOTFILES_GNOME_CONFIGS_LOCATION/apps/panel/<name>
gnome-panel-load()
{
    gconftool --load $DOTFILES_GNOME_CONFIGS_LOCATION/apps/panel/$@
}

# Save the current configuration for Gnome-panel.
#
# Arguments
#   1 (required) the name of the config to save. The file will be saved
#                at $DOTFILES_GNOME_CONFIGS_LOCATION/apps/panel/<name>
gnome-panel-save()
{
    gconftool --dump /apps/panel > $DOTFILES_GNOME_CONFIGS_LOCATION/apps/panel/$@
}

# Complete the gnome-panel load and save commands.
_complete-gnome-panel-save-or-load()
{
  # Complete only once
  if [[ $COMP_CWORD -le 1 ]]; then
    cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $( compgen -W "`/bin/ls $DOTFILES_GNOME_CONFIGS_LOCATION/apps/panel`" -- $cur ) )
  fi
}


# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

# Check for the Gnome configs location
if [[ -d $DOTFILES_LOCATION ]]; then
  export DOTFILES_GNOME_CONFIGS_LOCATION=$DOTFILES_LOCATION/gnome
else
  echo "The variable \$DOTFILES_LOCATION is not set or invalid." 2>&1
fi

# Complete the gnome-panel load and save commands.
complete -F _complete-gnome-panel-save-or-load gnome-panel-load
complete -F _complete-gnome-panel-save-or-load gnome-panel-save
