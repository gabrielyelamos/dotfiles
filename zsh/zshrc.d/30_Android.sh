#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et
# ------------------------------------------------------------------------------
# Settings for Android development.
# ------------------------------------------------------------------------------

ANDROID_HOME=/opt/android/android-sdk-linux_x86
if [[ -d $ANDROID_HOME ]]; then
  PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH
else
  echo "Android SDK is not installed at $ANDROID_HOME."
fi
