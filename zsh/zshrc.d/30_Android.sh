#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et
# ------------------------------------------------------------------------------
# Settings for Android development.
# ------------------------------------------------------------------------------

ANDROID_HOME=/opt/android/android-sdk-linux_x86
[[ -d $ANDROID_HOME ]] && PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

