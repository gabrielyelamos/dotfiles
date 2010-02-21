#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   Helper functions for Gnome.
#
# Dependencies
#   * Commands: gconftool.
#
# Author
#   nicoulaj - http://www.ju-n.net
# 
# Project
#   dotfiles - http://github.com/nicoulaj/dotfiles
# ------------------------------------------------------------------------------

export GNOME_CONFIGS_LOCATION=~/projects/dotfiles/gnome

# Load the given configuration for Gnome-panel.
#
# Arguments
#   1 (required) the name of the config to load. The file will be looked
#                up at $GNOME_CONFIGS_LOCATION/apps/panel/<name>.xml
gnome-panel-load()
{
    gconftool --load $GNOME_CONFIGS_LOCATION/apps/panel/$@.xml
}

# Save the current configuration for Gnome-panel.
#
# Arguments
#   1 (required) the name of the config to save. The file will be saved
#                at $GNOME_CONFIGS_LOCATION/apps/panel/<name>.xml
gnome-panel-save()
{
    gconftool --dump /apps/panel > $GNOME_CONFIGS_LOCATION/apps/panel/$@.xml
}
