#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   Utilitary functions for Bash.
#
# Dependencies
#   * bash_profile
#   * Commands: awk, sed, vim, ps, du, grep, shred, python, xclip.
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Command overrides / shortcuts
# ------------------------------------------------------------------------------


# ls
alias ls='ls -F --color=auto'
alias ll='ls -alh --color=auto'
alias la='ls -AF --color=auto'
alias l.='ls -Fd --color=auto .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."'


# dir
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'


# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# shred
alias shred='shred -n 35 -z -u -v'


# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'


# ps
alias ps-u='ps -u "$USER" -o user,pid,ppid,pcpu,pmem,args | most'


# Aptitude
alias apt-upgrade='flag-command sudo aptitude update && flag-command sudo aptitude safe-upgrade && flag-command sudo aptitude autoclean && flag-command sudo aptitude clean'
alias apt-search='flag-command apt-cache search'
alias apt-install='flag-command sudo aptitude install'


# ------------------------------------------------------------------------------
# New commands
# ------------------------------------------------------------------------------


# Reload bash_profile.
alias source-bash-profile='source $HOME/.bash_profile'


# Display the top ten biggest folders/files in the current directory.
alias topten='du -sk `ls -A` | sort -rn | head -10'


# Display statistics about the system.
alias stat="echo ' ' && uname -a && echo ' '&& uptime &&echo ' '&& df && echo ' '"


# Search commands history.
alias hgrep='history | grep'


# Tail the Flash Player log
alias flash-log='tail -f $HOME/.macromedia/Flash_Player/Logs/flashlog.txt'


# Displays the PATH variable with one line per entry.
alias path='echo -e ${PATH//:/\\n} | most'


# Change the console window title.
#
# Arguments
#   1 (required) the new title
set-terminal-title ()
{
  echo -ne "\\e]2;$1\\a"
}


# Insert a flag (a visual marker) with the specified content. If no content
# passed, insert the date.
#
# Arguments
#   1 (optional) the comment to print
#
# Usage
#   $ flag [COMMENT]
function flag()
{
  echo -ne "${BACKGROUND_BLUE}${TEXT_WHITE}${BOLD} "
  if [ -z $1 ]; then
    echo -ne  "`date +"%A %e %B %Y"`, `date +"%H"`h`date +"%M"`"
  else
    echo -ne  "$@"
  fi
  echo -e " ${RESET_FORMATTING}"
}


# Insert a flag (a visual marker) and execute the given command.
#
# Arguments
#   1 (required) the command to run
#
# Usage
#   $ flag <COMMAND>
function flag-command()
{
  if [ -n $1 ]; then
    flag $@
    $@
    return $?
  fi
  return 1
}


# Run a command and display a popup showing the success/failure.
#
# Arguments
#     @ (optional) the command to run
function notify-command()
{
  # Execute the command
  $@

  # Get the result
  result=$?

  # Try to use 'notify-send'
  if [ `which notify-send` ]; then
    case $result in
      0)
        notify-send -i info "OK" "The command $@ ran successfully."
        ;;
      *)
        notify-send -i error -u critical "KO" "The command $@ failed."
        ;;
    esac
  else
    echo "notify-send is not available."
    echo "It is available in the 'libnotify-bin' package."
    return 1
  fi
}

# Ask the user a "yes/no" question. Defaults to "no".
#
# Arguments
#     1 (optional) the question to ask.
function ask()
{
  read -p "$@ [y/N] " ans
  case "$ans" in
    y*|Y*)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}


# Repeat a command every x seconds.
#
# Arguments
#   1 (required) the period
#   2 (required) the command to run
#
# Usage
#   $ repeat <PERIOD> <COMMAND>
function repeat()
{
  local period
  period=$1; shift;
  while (true); do
    eval "$@";
    sleep $period;
  done
}


# Try to unarchive a file.
#
# Arguments
#   1 (required) the file
function extract()
{
  local filename="${1}"
  local extension=`echo ${1} | cut -d. -f2-`
  case "$extension" in
    tar)
      tar xvf "$filename";;
    tar.gz)
      tar xzvf "$filename";;
    tgz)
      tar xzvf "$filename";;
    gz)
      gunzip "$filename";;
    tbz)
      tar xjvf "$filename";;
    tbz2)
      tar xjvf "$filename";;
    tar.bz2)
      tar xjvf "$filename";;
    tar.bz)
      tar xjvf "$filename";;
    bz2)
      bunzip2 "$filename";;
    tar.Z)
      tar xZvf "$filename";;
    Z)
      uncompress "$filename";;
    zip)
      unzip "$filename";;
    rar)
      unrar x "$filename";;
  esac
}


# Syntax highlighting pager based on vim.
- ()
{
    /usr/share/vim/vimcurrent/macros/less.sh "$*"
}


# Display public IP.
function ip-public()
{
  curl icanhazip.com
}


# Display private IP.
function ip-private()
{
  ifconfig eth0 | grep "inet adr" | awk '{print $2}' | awk -F ':' '{print $2}'
}


# Swap 2 filenames.
#
# Arguments
#   1 (required) the first file
#   2 (required) the second file
function swap()
{
  local TMPFILE=tmp.$$
  mv "$1" $TMPFILE
  mv "$2" "$1"
  mv $TMPFILE "$2"
}


# Create a backup copy of the file with the date and time.
#
# Arguments
#   1 (required) the file to backup
function bak ()
{
  cp $1 $1_`date +%H:%M:%S_%d-%m-%Y`
}


# Replace spaces with underscores in filenames.
#
# Arguments
#   @ (required) the files to treat
function remove-spaces()
{
  # Check arguments validity
  if [ "$#" = 0 ]
  then
    echo "Usage: remove-spaces [filenames...]"
    return 0
  fi

  # Treat each file
  for arg in "$@"
  do
    filename=`basename "$arg"`
    dirname=`dirname "$arg"`
    oldname=`echo "$filename" | sed -e "s/ /\\\\ /"`
    newname=`echo "$filename" | sed -e : -e s/\ /_/ -e s/%20/_/ -e s/%28/[/ -e s/%29/]/ -e s/%5B/[/ -e s/%5D/]/ -e t`
    if [ ! -e "$dirname/$oldname" ];
    then
      echo "$dirname/$oldname does not exists."
    elif [ "$oldname" = "$newname" ]
    then
      echo "$dirname/$oldname needs no change, skipping..."
    elif [ -e "$dirname/$newname" ]
    then
      echo "$dirname/$newname exists, skipping..."
    else
      mv "$dirname/$oldname" "$dirname/$newname"
      echo "$dirname/$oldname => $dirname/$newname"
    fi
  done
}


# Kill a process by name.
#
# Arguments
#   0 (optional) the signal to send
#   1 (required) a string to look for
#
# Example
#   $ ps-kill fire
#   Kill process 10161 </usr/lib/firefox-3.5.7/firefox> with signal -TERM ?  [y/N] y
function ps-kill()
{
  local pid pname sig="-TERM"
  if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: ps-kill [-SIGNAL] pattern"
    return;
  fi
  if [ $# = 2 ]; then sig=$1 ; fi
  for pid in $(ps-u | nawk '!/nawk/ && $0~pat { print $2 }' pat=${!#}) ; do
    pname=$(ps-u | nawk '$2~var { print $6 }' var=$pid )
    if ask "Kill process $pid <$pname> with signal $sig ? "
      then kill $sig $pid
    fi
  done
}


# Share the current directory with a web server.
function webshare()
{
  # Resolve host IPs
  local private_ip=`ip-private`
  local public_ip=`ip-public`

  # Displays the server IPs
  echo -e "${TEXT_BLUE}Setting up a web server at the following adresses:"
  echo -e "Local: http://${private_ip}:8000"
  echo -e "Public: http://${public_ip}:8000${RESET_FORMATTING}"

  # Copy the IPs in the clipboard
  echo "http://${private_ip}:8000 /// http://${public_ip}:8000" | xclip -sel clip

  # Start the web server
  python -m SimpleHTTPServer
}


# Go to the documentation of the command.
#
# Arguments
#   1 (required) the command to lookup
function doc
{
  if [ -d "/usr/share/doc/$1" ]; then
    cd "/usr/share/doc/$1" && ls
  else
    echo "No doc found for '$1'."
    return 1
  fi
}


# Generate PDF files from man pages.
#
# Arguments
#   1 (required) the command to lookup
man-pdf () {
  man -t $@ | ps2pdf - $@.pdf
}


# Colorized log.
log-view()
{
  ccze -A < $1 | less -R
}


# Colorized log.
log-tail()
{
  tail -f $1 | ccze
}

# Import and install the GPG key.
#
# Arguments
#   1 (required) the key to import
#
# Example
#   $ import-gpg-key 2EE5793634EF4A35
import-gpg-key()
{
  gpg --keyserver hkp://keyserver.ubuntu.com:11371 --recv-key $1 &&
  gpg -a --export $1 | sudo apt-key add -
}
