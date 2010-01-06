#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description:
#     
#
# Author
#     Julien Nicoulaud - julien.nicoulaud@gmail.com
# ------------------------------------------------------------------------------


_WINDOW_Y=`tput cols`

# Put a clock on the right
echo -ne `tput sc; tput cup 0 $(expr ${_WINDOW_Y} - 5)``date +"%H"`h`date +"%M"``tput rc`

# Add the user and host names
echo -e "${TEXT_BLUE}${BOLD}$USER@$HOSTNAME >${RESET_FORMATTING}"

