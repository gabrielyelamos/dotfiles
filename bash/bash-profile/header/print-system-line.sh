#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description:
#
#
# Author
#     Julien Nicoulaud - julien.nicoulaud@gmail.com
# ------------------------------------------------------------------------------


# Add the line title
echo -ne "${TEXT_BLUE}${BOLD}System >${RESET_FORMATTING}"

# Add RAM percentage used
echo -ne " RAM `free -mto | grep Mem: | awk '{print int($3/$2*100)}'`%"

# Loop through partitions
# (discard tmp and cdrom partitions)
df -HT | tail -n +2 | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{print $6 " " $7}' | while read output;
  do
    
    # Add a separator
    echo -ne " ${TEXT_BLUE}|${RESET_FORMATTING} "
    usage=$(echo $output | awk '{print $1}' | cut -d'%' -f1)
    partition=$(echo $output | awk '{print $2 }')
    
    # If usage greater than 80%, emphasize the text
    if [ $usage -ge 80 ]; then
      echo -ne "${TEXT_RED}${BOLD}"
    fi
    
    # Add the info
    echo -ne "$partition $usage%${RESET_FORMATTING}"
  done
  
echo

