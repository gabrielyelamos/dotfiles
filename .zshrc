#!/usr/bin/env zsh

# Use an anonymous function to avoid variables bleeding in the environment.
() {

  # Zshrc style.
  typeset -A ZSHRC_STYLES
  ZSHRC_STYLES=(
    reset    '[00m'
    border   '[38;5;008m'
    hostname '[38;5;012m'
    conf     '[38;5;007m'
    error    '[38;5;160m'
  )

  # Find main user home.
  ZSH_MAIN_USER_HOME=$HOME
  [[ $ZSH_MAIN_USER_HOME = '/root' ]] && ZSH_MAIN_USER_HOME=${$(command ls /home/*/.zshrc)%\/.zshrc}

  # Zsh directories.
  ZSH_HOME=$ZSH_MAIN_USER_HOME/zsh
  ZSH_CONFS_DIR=$ZSH_HOME/conf.d
  ZSH_COMPS_DIR=$ZSH_HOME/comp.d

  # Zshrc temporary files.
  ZSHRC_ERROR_LOG=/tmp/zshrc_error.log
  ZSHRC_CONF_ERROR_LOG=/tmp/zshrc_conf_error.log
  : > $ZSHRC_ERROR_LOG

  # Print header.
  clear
  echo
  echo -n "$ZSHRC_STYLES[border]──❮ $ZSHRC_STYLES[hostname]$USER@$HOST$ZSHRC_STYLES[border] ❯"
  repeat $(( $COLUMNS - ${#USER} - ${#HOST} - ${#SHELL_TYPE} - 7 )) printf '─'
  echo

  # Update fpath with ZSH_COMPS_DIR.
  if [[ ! -d $ZSH_COMPS_DIR ]]; then
    echo "$ZSHRC_STYLES[error]Invalid ZSH_COMPS_DIR$ZSHRC_STYLES[reset] > " >> $ZSHRC_ERROR_LOG
    echo "  Components directory '$ZSH_COMPS_DIR' could not be found."      >> $ZSHRC_ERROR_LOG
    echo                                                                    >> $ZSHRC_ERROR_LOG
  else
    fpath=($ZSH_COMPS_DIR $fpath)
  fi

  # Load configs in ZSH_CONFS_DIR.
  if [[ ! -d $ZSH_CONFS_DIR ]]; then
    echo "$ZSHRC_STYLES[error]Invalid ZSH_CONFS_DIR$ZSHRC_STYLES[reset] > " >> $ZSHRC_ERROR_LOG
    echo "  Configs directory '$ZSH_CONFS_DIR' could not be found."         >> $ZSHRC_ERROR_LOG
    echo                                                                    >> $ZSHRC_ERROR_LOG
  else
    setopt localoptions extendedglob
    local conf_name conf_color
    for file in $ZSH_CONFS_DIR/*
    do
      : > $ZSHRC_CONF_ERROR_LOG
      source $file &> $ZSHRC_CONF_ERROR_LOG
      if [[ -s $ZSHRC_CONF_ERROR_LOG ]]; then
        echo "$conf_color$conf_name$ZSHRC_STYLES[reset] > "   >> $ZSHRC_ERROR_LOG
        cat $ZSHRC_CONF_ERROR_LOG | sed 's/\(.*\)/\ \ \1/g'   >> $ZSHRC_ERROR_LOG
        echo                                                  >> $ZSHRC_ERROR_LOG
        conf_color=$ZSHRC_STYLES[error]
      else
        conf_color=$ZSHRC_STYLES[conf]
      fi
      conf_name=${${file:t:r}##[0-9]##_}
      echo -n " $ZSHRC_STYLES[border]▪$ZSHRC_STYLES[reset] $conf_color$conf_name$ZSHRC_STYLES[reset]"
    done
    echo
  fi

  # Print footer.
  repeat $COLUMNS printf "$ZSHRC_STYLES[border]─"
  echo

  # Print error log if not empty.
  if [[ -s $ZSHRC_ERROR_LOG ]]; then
    repeat $COLUMNS printf "$ZSHRC_STYLES[error]─$ZSHRC_STYLES[reset]"
    cat $ZSHRC_ERROR_LOG | head --lines=-1
    repeat $COLUMNS printf "$ZSHRC_STYLES[error]─$ZSHRC_STYLES[reset]"
    echo
  fi
  echo

}
