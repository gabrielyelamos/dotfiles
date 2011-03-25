#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et

# Show a splash screen.
ZSHRC_SPLASH_MESSAGE='Loading...'
zmodload zsh/curses
zcurses init
zcurses addwin splash-screen 3 $(( ${#ZSHRC_SPLASH_MESSAGE} + 4 )) $(( ( $LINES / 2 ) - 1 )) $(( ( $COLUMNS - ${#ZSHRC_SPLASH_MESSAGE} - 4 ) / 2 ))
zcurses border splash-screen
zcurses move splash-screen 1 2
zcurses string splash-screen $ZSHRC_SPLASH_MESSAGE
zcurses refresh splash-screen

# Options required for zshrc.
setopt localoptions extendedglob

# Zshrc style.
typeset -A ZSHRC_STYLES; ZSHRC_STYLES=(
  reset    '[00m'
  border   '[38;5;008m'
  hostname '[38;5;012m'
  conf     '[38;5;007m'
  error    '[38;5;160m'
)

# Resolve real zshrc location (if symlinked from /root).
ZSH_HOME=${${HOME:#\/root}:-${$(command ls /home/*/.zshrc)%\/.zshrc}}/zsh

# Zshrc temporary files.
ZSHRC_ERROR_LOG=/tmp/zshrc_conf_error.log

# Variables used to generate the displayed header.
local header='' errors=''

# Add an horizontal rule.
header+="\n$ZSHRC_STYLES[border]──❮ $ZSHRC_STYLES[hostname]$USER@$HOST$ZSHRC_STYLES[border] ❯"
repeat $(( $COLUMNS - ${#USER} - ${#HOST} - ${#SHELL_TYPE} - 7 )) header+='─'
header+="\n"

# Update fpath with ZSH_COMPS_DIR.
ZSH_COMPS_DIR=$ZSH_HOME/comp.d
if [[ ! -d $ZSH_COMPS_DIR ]]; then
  errors+="$ZSHRC_STYLES[error]✘ Invalid ZSH_COMPS_DIR$ZSHRC_STYLES[conf]\nComponents directory '$ZSH_COMPS_DIR' could not be found.\n"
else
  fpath=($ZSH_COMPS_DIR/**/ $fpath)
fi

# Load configs in ZSH_CONFS_DIR.
ZSH_CONFS_DIR=$ZSH_HOME/conf.d
if [[ ! -d $ZSH_CONFS_DIR ]]; then
  local invalid_conf_dir_message="❮ Invalid configs directory ❯"
  repeat $(( ( $COLUMNS - ${#invalid_conf_dir_message} ) / 2 )) header+=" "
  header+="$ZSHRC_STYLES[error]$invalid_conf_dir_message$ZSHRC_STYLES[reset]"
  errors+="$ZSHRC_STYLES[error]✘ Invalid ZSH_CONFS_DIR$ZSHRC_STYLES[conf]\n"
  errors+="Configs directory '$ZSH_CONFS_DIR' could not be found.\n"
else
  if ! command ls $ZSH_CONFS_DIR/*.*sh &> /dev/null; then
    local empty_conf_dir_message="❮ No config found ❯"
    repeat $(( ( $COLUMNS - ${#empty_conf_dir_message} ) / 2 )) header+=" "
    header+="$ZSHRC_STYLES[conf]$empty_conf_dir_message$ZSHRC_STYLES[reset]"
  else
    local conf_name conf_color
    for conf_file in $ZSH_CONFS_DIR/*.*sh; do
      conf_name=${${conf_file:t:r}##[0-9]##_}
      : > $ZSHRC_ERROR_LOG
      source $conf_file &> $ZSHRC_ERROR_LOG
      if [[ -s $ZSHRC_ERROR_LOG ]]; then
        conf_color=$ZSHRC_STYLES[error]
        errors+="$conf_color✘ $conf_name$ZSHRC_STYLES[conf]\n$(cat $ZSHRC_ERROR_LOG)\n"
      else
        conf_color=$ZSHRC_STYLES[conf]
      fi
      header+=" $ZSHRC_STYLES[border]▪$ZSHRC_STYLES[reset] $conf_color$conf_name$ZSHRC_STYLES[reset]"
    done
  fi
fi

# Add an horizontal rule.
header+="\n$ZSHRC_STYLES[border]"
repeat $COLUMNS header+="─"
header+="$ZSHRC_STYLES[reset]\n"

# Add the errors report.
if [[ -n $errors ]]; then
  header+="$ZSHRC_STYLES[error]"
  repeat $COLUMNS header+="─"
  header+="$ZSHRC_STYLES[reset]\n$errors$ZSHRC_STYLES[error]"
  repeat $COLUMNS header+="─"
  header+="$ZSHRC_STYLES[reset]\n"
fi

# Hide the splash screen.
zcurses delwin splash-screen
zcurses end

# Display the generated header.
clear
print $header
