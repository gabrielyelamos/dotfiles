#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   Utilitary functions for managing encrypted folders with TrueCrypt.
#
# Dependencies
#   * bash_profile
#   * Configs: Functions.
#   * Commands: truecrypt.
# ------------------------------------------------------------------------------


# Location of the encrypted volume file.
export PRIVATE_FOLDER_VOLUME_FILE=$HOME/documents/private.tc


# Mount point of the encrypted volume.
export PRIVATE_FOLDER_MOUNT_POINT=$HOME/documents/private


# Mount/unmount a TrueCrypt volume.
#
# Arguments
#   1 (required) The location of the encrypted volume file.
#   2 (required) The mount point of the encrypted volume.
function toggle-truecrypt-folder()
{
  if [ ! -d $2 ]; then
    flag Mounting $2
    mkdir -vp $2
    truecrypt --text --protect-hidden=no --keyfiles='' $1 $2
  else
    flag Unmounting $2
    truecrypt --text --dismount $1
    rm -vrf $2
  fi
}

# Mount/unmount the private folder.
function toggle-private()
{
  toggle-truecrypt-folder "$PRIVATE_FOLDER_VOLUME_FILE" "$PRIVATE_FOLDER_MOUNT_POINT"
}
