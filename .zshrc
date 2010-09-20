#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Initialization file for Zsh.
# ------------------------------------------------------------------------------

ZSH_CONFS_DIR=~/zsh/conf.d
ZSH_COMPS_DIR=~/zsh/comp.d

autoload -Uz colors && colors
setopt EXTENDED_GLOB

clear
echo
echo -ne "──❮ $fg[yellow]$USER@$HOST$reset_color ❯"
repeat $(( $COLUMNS - ${#USER} - ${#HOST} - ${#SHELL_TYPE} - 7 )) printf '─'
echo
if [[ ! -d $ZSH_CONFS_DIR ]]; then
  echo -e "$fg_bold[red]Confs directory '$ZSH_CONFS_DIR' could not be found.$reset_color"
else
  : > /tmp/zshrc_configs_out.log
  for file in $ZSH_CONFS_DIR/*
  do
    : > /tmp/zshrc_config_out.log
    source $file &> /tmp/zshrc_config_out.log
    local config_name=${${file:t:r}##[0-9]##_}
    if [[ -s /tmp/zshrc_config_out.log ]]; then
      conf_color=$fg_bold[red]
      echo "$fg_bold[blue]$config_name$reset_color > "        >> /tmp/zshrc_configs_out.log
      (cat /tmp/zshrc_config_out.log | sed -e "s/\(.*\)/\ \ \1/g"; echo) >> /tmp/zshrc_configs_out.log
    fi
    echo -n " $fg[blue]▪$reset_color $conf_color$config_name$reset_color"
  done
  echo
fi
repeat $COLUMNS printf "─"
echo
if [[ -s /tmp/zshrc_configs_out.log ]]; then
  repeat $COLUMNS printf "$fg_bold[red]─$reset_color"
  cat /tmp/zshrc_configs_out.log | head --lines=-1
  repeat $COLUMNS printf "$fg_bold[red]─$reset_color"
  echo
fi
echo
