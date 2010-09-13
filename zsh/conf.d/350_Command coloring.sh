#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Fish style live command coloring.
# ------------------------------------------------------------------------------

recolor-cmd() {
   args=(${(z)BUFFER})
   cmd=$args[1]
   res=$(builtin type $cmd 2>/dev/null)
   [[ -z $res ]]  && return
   case $res in
     *'reserved word'*)  color="magenta";;
     *'an alias'*)       color="cyan";;
     *'shell builtin'*)  color="yellow";;
     *'shell function'*) color='green';;
     *"$cmd is"*)        color="blue";;
     *)                  color="red";;
   esac
   region_highlight=("0 ${#cmd} fg=${color},bold")
}

check-cmd-self-insert() { zle .self-insert && recolor-cmd }
check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }

zle -N self-insert check-cmd-self-insert
zle -N backward-delete-char check-cmd-backward-delete-char
