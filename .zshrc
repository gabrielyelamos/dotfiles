#!/usr/bin/env zsh

# FIXME Auto "guess" main user
MAIN_USER=nicoulaj
ZSH_CONFS_DIR=/home/$MAIN_USER/zsh/conf.d
ZSH_COMPS_DIR=/home/$MAIN_USER/zsh/comp.d

clear
echo
echo -ne "[38;5;008m──❮ [38;5;012m$USER@$HOST[38;5;008m ❯"
repeat $(( $COLUMNS - ${#USER} - ${#HOST} - ${#SHELL_TYPE} - 7 )) printf '─'
echo
if [[ ! -d $ZSH_COMPS_DIR ]]; then
  echo -e "[38;5;009mComponents directory '$ZSH_COMPS_DIR' could not be found.[00m"
else
  fpath=($ZSH_COMPS_DIR $fpath)
fi
if [[ ! -d $ZSH_CONFS_DIR ]]; then
  echo -e "[38;5;009mConfs directory '$ZSH_CONFS_DIR' could not be found.[00m"
else
  : > /tmp/zshrc_configs_out.log
  for file in $ZSH_CONFS_DIR/*
  do
    : > /tmp/zshrc_config_out.log
    source $file &> /tmp/zshrc_config_out.log
    local config_name=${${file:t:r}##[0-9]##_}
    local conf_color="[38;5;007m"
    if [[ -s /tmp/zshrc_config_out.log ]]; then
      conf_color="[38;5;160m"
      echo "[38;5;009m$config_name[00m > " >> /tmp/zshrc_configs_out.log
      (cat /tmp/zshrc_config_out.log | sed -e "s/\(.*\)/\ \ \1/g"; echo) >> /tmp/zshrc_configs_out.log
    fi
    echo -n " [38;5;008m▪[00m $conf_color$config_name[00m"
  done
  echo
fi
repeat $COLUMNS printf "[38;5;008m─"
echo
if [[ -s /tmp/zshrc_configs_out.log ]]; then
  repeat $COLUMNS printf "[38;5;160m─[00m"
  cat /tmp/zshrc_configs_out.log | head --lines=-1
  repeat $COLUMNS printf "[38;5;160m─[00m"
  echo
fi
echo
