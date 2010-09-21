#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Initialization file for Zsh.
# ------------------------------------------------------------------------------

ZSH_CONFS_DIR=~/zsh/conf.d
ZSH_COMPS_DIR=~/zsh/comp.d

autoload colors && colors
setopt EXTENDED_GLOB

typeset -Ag FX FG BG
FX=(
  reset     "[00m"
  bold      "[01m" no-bold      "[22m"
  italic    "[03m" no-italic    "[23m"
  underline "[04m" no-underline "[24m"
  blink     "[05m" no-blink     "[25m"
  reverse   "[07m" no-reverse   "[27m"
)
for color in {0..255}; do
  FG[$color]="[38;5;${color}m"
  BG[$color]="[48;5;${color}m"
done
FG[none]=$FG[0];        BG[none]=$BG[0]
FG[darkred]=$FG[1];     BG[darkred]=$BG[1]
FG[darkgreen]=$FG[2];   BG[darkgreen]=$BG[2]
FG[darkyellow]=$FG[3];  BG[darkyellow]=$BG[3]
FG[darkblue]=$FG[4];    BG[darkblue]=$BG[4]
FG[darkmagenta]=$FG[5]; BG[darkmagenta]=$BG[5]
FG[darkcyan]=$FG[6];    BG[darkcyan]=$BG[6]
FG[grey]=$FG[7];        BG[grey]=$BG[7]
FG[darkgrey]=$FG[8];    BG[darkgrey]=$BG[8]
FG[red]=$FG[9];         BG[red]=$BG[9]
FG[green]=$FG[10];      BG[green]=$BG[10]
FG[yellow]=$FG[11];     BG[yellow]=$BG[11]
FG[blue]=$FG[12];       BG[blue]=$BG[12]
FG[magenta]=$FG[13];    BG[magenta]=$BG[13]
FG[cyan]=$FG[14];       BG[cyan]=$BG[14]
FG[lightgrey]=$FG[15];  BG[lightgrey]=$BG[15]

clear
echo
echo -ne "$FG[darkgrey]──❮ $FG[blue]$USER@$HOST$FG[darkgrey] ❯"
repeat $(( $COLUMNS - ${#USER} - ${#HOST} - ${#SHELL_TYPE} - 7 )) printf '─'
echo
if [[ ! -d $ZSH_COMPS_DIR ]]; then
  echo -e "$FG[red]Components directory '$ZSH_COMPS_DIR' could not be found.$reset_color"
else
  fpath=($ZSH_COMPS_DIR $fpath)
fi
if [[ ! -d $ZSH_CONFS_DIR ]]; then
  echo -e "$FG[red]Confs directory '$ZSH_CONFS_DIR' could not be found.$reset_color"
else
  : > /tmp/zshrc_configs_out.log
  for file in $ZSH_CONFS_DIR/*
  do
    : > /tmp/zshrc_config_out.log
    source $file &> /tmp/zshrc_config_out.log
    local config_name=${${file:t:r}##[0-9]##_}
    local conf_color=$FG[grey]
    if [[ -s /tmp/zshrc_config_out.log ]]; then
      conf_color=$FG[160]
      echo "$FG[red]$config_name$reset_color > " >> /tmp/zshrc_configs_out.log
      (cat /tmp/zshrc_config_out.log | sed -e "s/\(.*\)/\ \ \1/g"; echo) >> /tmp/zshrc_configs_out.log
    fi
    echo -n " $FG[darkgrey]▪$reset_color $conf_color$config_name$reset_color"
  done
  echo
fi
repeat $COLUMNS printf "$FG[darkgrey]─"
echo
if [[ -s /tmp/zshrc_configs_out.log ]]; then
  repeat $COLUMNS printf "$FG[160]─$reset_color"
  cat /tmp/zshrc_configs_out.log | head --lines=-1
  repeat $COLUMNS printf "$FG[160]─$reset_color"
  echo
fi
echo
