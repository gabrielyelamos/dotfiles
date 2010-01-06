#######################
##      Progs        ##
#######################

# Simple shortcuts
alias source-bash-profile='source $HOME/.bash_profile'

# Simple shortcuts
alias eclipse='$ECLIPSE_HOME/eclipse'

# ls
alias ls='ls -F --color'
alias ll='ls -al --color'
alias la='ls -AF --color'
alias l.='ls -Fd --color .[[:alnum:]]* 2> /dev/null || echo "No hidden file here..."' # list only hidden files

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ps
alias myps='/bin/ps -u "$USER" -o user,pid,ppid,pcpu,pmem,args|less'

# Subversion
alias svnrmallentries='find . -name .svn -print0 | xargs -0 rm -rf'
alias svnaddall='find "$PWD" -exec svn add {} 2>/dev/null \;'
alias svnlog='svn log -v -r HEAD:0 | less'

# Aptitude
alias upgrade='flagcommand sudo aptitude update && flagcommand sudo aptitude safe-upgrade && flagcommand sudo aptitude autoclean && flagcommand sudo aptitude clean'
alias searchpaquet='apt-cache search'
alias installpaquet='flagcommand sudo aptitude install'

# Flash
alias flashlog='tail -f $HOME/.macromedia/Flash_Player/Logs/flashlog.txt'

# LAMP
alias lamp-start='sudo /etc/init.d/apache2 start && sudo /etc/init.d/mysql start'
alias lamp-restart='sudo /etc/init.d/apache2 restart && sudo /etc/init.d/mysql restart'
alias lamp-reload='sudo /etc/init.d/apache2 reload && sudo /etc/init.d/mysql reload'
alias lamp-stop='sudo /etc/init.d/apache2 stop && sudo /etc/init.d/mysql stop'


#######################
##      Places       ##
#######################

# Displays the top ten biggest folders/files in the current directory
alias topten='du -sk $(/bin/ls -A) | sort -rn | head -10'

# Displays statistics about the system
alias stat="echo ' ' && uname -a && echo ' '&& uptime &&echo ' '&& df && echo ' '"

# Search commands history
alias hgrep='history | grep --color=always'

# Displays a calendar
alias ccal='var=$(cal -m); echo "${var/$(date +%-d)/$(echo -e "\033[1;31m$(date +%-d)\033[0m")}"'

# Displays a tree of the arborescence
alias tree="find . | sed 's/[^/]*\//|   /g;s/| *\([^| ]\)/+--- \1/'"

# Displays the PATH variable
alias path='echo -e ${PATH//:/\\n} | less'

# Safe delete
alias shred='shred -n 35 -z -u -v'

# Tries to unarchive anything thrown at it
extract() {
    ##### Probably done more robustly with file(1) but not as easily
    local FILENAME="${1}"
    local FILEEXTENSION=`echo ${1} | cut -d. -f2-`
    case "$FILEEXTENSION" in
        tar)
            tar xvf "$FILENAME";;
        tar.gz)
            tar xzvf "$FILENAME";;
        tgz)
            tar xzvf "$FILENAME";;
        gz)
            gunzip "$FILENAME";;
        tbz)
            tar xjvf "$FILENAME";;
        tbz2)
            tar xjvf "$FILENAME";;
        tar.bz2)
            tar xjvf "$FILENAME";;
        tar.bz)
            tar xjvf "$FILENAME";;
        bz2)
            bunzip2 "$FILENAME";;
        tar.Z)
            tar xZvf "$FILENAME";;
         Z)
            uncompress "$FILENAME";;
         zip)
            unzip "$FILENAME";;
         rar)
            unrar x "$FILENAME";;
    esac
}

# Syntax highlighting pager based on vim
# Usage: $ - myFile.java
- () {
    /usr/share/vim/vim72/macros/less.sh "$*"
}

# Edit the svn log at the given revision
editsvnlog() {
    svn propedit svn:log --revprop -r$1 --editor-cmd gedit
}

# Inserts a flag with the specified content
# Usage: flag "comment"
# If no comment, inserts the date.
function flag(){
    if [ "$1" == "" ];
    then
        echo -e  "\e[0;31m[===== " `date +"%A %e %B %Y"`, `date +"%H"`h`date +"%M"` " ======]\e[0m"
    else
        echo -e  "\e[0;31m[ " $@ " ]\e[0m"
    fi
}

# Inserts a flag and executes the command
# Example: flagcommand ls
function flagcommand(){
    if [ "$1" == "" ];
    then
        return
    else
        flag $@
        $@
    fi
}

# Change directory and list files
function cds(){
    # only change directory if a directory is specified
    [ -n "${1}" ] && cd $1
    lls
}

# Advanced ls function
# Counts files, subdirectories and directory size and displays details
# about files depending on the available space
function lls () {
	# count files
	echo -n "<`find . -maxdepth 1 -mindepth 1 -type f | wc -l | tr -d '[:space:]'` files>"
	# count sub-directories
	echo -n " <`find . -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d '[:space:]'` dirs/>"
	# count links
	echo -n " <`find . -maxdepth 1 -mindepth 1 -type l | wc -l | tr -d '[:space:]'` links@>"
	# total disk space used by this directory and all subdirectories
	echo " <~`du -sh . 2> /dev/null | cut -f1`>"
	ROWS=`stty size | cut -d' ' -f1`
	FILES=`find . -maxdepth 1 -mindepth 1 |
	wc -l | tr -d '[:space:]'`
	# if the terminal has enough lines, do a long listing
	if [ `expr "${ROWS}" - 6` -lt "${FILES}" ]; then
		ls
	else
		ls -hlAF --full-time
	fi
}

# Display public IP
# Uses whatismyip.com service
function ippub()
{
    wget -O - -q http://www.whatismyip.com | grep -i "<TITLE>Your IP" | awk '{print $4}'
}

# Display private IP
function ippriv()
{
    ifconfig eth0|grep "inet adr"|awk '{print $2}'|awk -F ':' '{print $2}'
}

# Repeats a command every x seconds
# Usage: repeat PERIOD COMMAND
function repeat() {
    local period
    period=$1; shift;
    while (true); do
        eval "$@";
    sleep $period;
    done
}

# Kill a process by name
# Example: killps firefox-bin
function killps()
{
    local pid pname sig="-TERM" # default signal
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(myps | nawk '!/nawk/ && $0~pat { print $2 }' pat=${!#}) ; do
        pname=$(myps | nawk '$2~var { print $6 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig ? "
            then kill $sig $pid
        fi
    done
}

# User friendly ps aux
function psaux {
    [ $# == 1 ] && ps aux | grep $1
}

# Find a file with a pattern in name in the local directory
function ff()
{
    find . -type f -iname '*'$*'*' -ls ;
}

# Swap 2 filenames around
function swap()
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# Move filenames to lowercase
function lowercase()
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

# Correct filenames to lowercase.
#
# Example:
# [yannick@yop ~] fncorrect_lowercase TuTgFdSFqdqsdSDQDdfsdfhKJHsdfsdfKJH 
# ./TuTgFdSFqdqsdSDQDdfsdfhKJHsdfsdfKJH => ./tutgfdsfqdqsdsdqddfsdfhkjhsdfsdfkjh
#
function fncorrect_lowercase()
{
        if [ "$#" = 0 ]
        then
                echo "Usage: fncorrect_lowercase [filenames...]"
                return 0
        fi

        for arg in "$@"
        do
                filename=`basename "$arg"`
                dirname=`dirname "$arg"`
                oldname=`echo "$filename" | sed -e "s/ /\\\\ /"`
                newname=`echo "$filename" | tr A-Z a-z`
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

# Correct spaces in filenames
#
# Example:
# [yannick@yop ~] fncorrect_spaces totot\ tottot\ \ t\ sdf\ sdf\ \ fh\ sfh\ ss\ fj\ s\ fshf\ \ sdfs/
# ./totot tottot  t sdf sdf  fh sfh ss fj s fshf  sdfs => ./totot_tottot__t_sdf_sdf__fh_sfh_ss_fj_s_fshf__sdfs
#
function fncorrect_spaces()
{
    if [ "$#" = 0 ]
    then
        echo "Usage: fncorrect_spaces [filenames...]"
        return 0
    fi

    for arg in "$@"
    do
        filename=`basename "$arg"`
        dirname=`dirname "$arg"`
        oldname=`echo "$filename" | sed -e "s/ /\\\\ /"`
        newname=`echo "$filename" | sed -e : -e s/\ /_/ -e s/%20/_/ -e s/%28/[/ -e s/%29/]/ -e s/%5B/[/ -e s/
%5D/]/ -e t`
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

# Change console window title
windowtitle () {
    echo -ne "\\e]2;$1\\a"
}

# Remove all files created by latex
function unlatex(){
if [ "$1" == "" ]; then
return
fi
i=${1%%.*}
rm -f $i.aux $i.toc $i.lof $i.lot $i.los $i.?*~ $i.loa $i.log $i.bbl $i.blg $i.glo
rm -f $i.odt $i.tns $i.fax $i.bm $i.out $i.nav $i.snm
rm -f $i.mtc* $i.bmt
mv -f $i.dvi .$i.dvi
mv -f $i.ps .$i.ps
mv -f $i.pdf .$i.pdf
rm -f $i.dvi $i.ps $i.pdf
unset i
}

# Creates a backup of the file passed as parameter with the date and time
function bak ()
{                                                                                                  
  cp $1 $1_`date +%H:%M:%S_%d-%m-%Y`                                                               
}  

# Draws a box containing content
# Usage: drawbox width height "line 1" "line 2" ...
function drawbox(){
    # Handle args
    BOXWIDTH=$1
    BOXHEIGHT=$2
    shift 2
    
    # Decorations
    BOXHORIZONTALSYMBOL="-"
    BOXVERTICALSYMBOL="|"
    BOXCORNERSYMBOL="+"
    
    # Calculate dimensions
    MARGIN=$((($TWIDTH-$BOXWIDTH)/2))
    
    # Draw lines
    for ((l=1;l<=$BOXHEIGHT;l++)); do
        line=""
        
        # Before the left border
        for ((c=1;c<=$MARGIN;c++)); do
            line+=" "
        done
        
        # The left border
        if [ $l -eq 1 ] || [ $l -eq $BOXHEIGHT ];
        then
            line+=${BOXCORNERSYMBOL}
        else
            line+=${BOXVERTICALSYMBOL}
        fi
        
        # The content
        if [ $l -ne 1 ] && [ $l -ne $BOXHEIGHT ];
        then
            arglength=0
            # If there is text to put
            if [ $# -ne 0 ];
            then
                arglength=$(expr length "$1")
                line+=$1
            fi
            
            # Fill with blank
            for ((c=$(($MARGIN + $arglength + 1));c<=$(($TWIDTH - $MARGIN - 1));c++)); do
                line+=" "
            done
        else
            for ((c=$(($MARGIN + 1));c<=$(($TWIDTH - $MARGIN - 1));c++)); do
                line+=${BOXHORIZONTALSYMBOL}
            done
        fi
        
        # The right border
        if [ $l -eq 1 ] || [ $l -eq $BOXHEIGHT ];
        then
            line+=${BOXCORNERSYMBOL}
        else
            line+=${BOXVERTICALSYMBOL}
        fi        
        
        # Print the line
        echo -e "$line"
        
        # Go to the next argument
        if [ $l -ne 1 ];
        then
            shift
        fi
    done
    echo    
}

# "Repairs" damaged Eclipse workspace that prevents Eclipse from booting
# by destroying metadata informations. Use File -> Import -> General->
# Existing projects into workspace to find your projects back.
function repairworkspace(){

    # First make sure Eclipse is not running
    local pid pname first
    first=true
    for pid in $(ps -e | grep "eclipse" | awk '{print $1;}') ; do
        if [ first ];
        then
            echo "It seems Eclipse is running. It is strongly recommended that you shut down all running Eclipse instances before continuing."
            first=false
        fi
        if ask "Kill Eclipse process (pid $pid) ?"
            then
            kill "-TERM" $pid
        fi
    done
    
    # Then do it the hard way
    local target
    target=".metadata/.plugins/org.eclipse.core.resources/"
    if [ -d $target ];
    then
        if ask "Destroy workspace projects metadata ?"
        then
            rm -rf $target
        fi
    else
        echo "Error: You must be at the root of an Eclipse workspace."
    fi
}

