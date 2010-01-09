#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   A customized prompt.
#
# Author
#   nicoulaj - http://www.ju-n.net
# 
# Project
#   dotfiles - http://github.com/nicoulaj/dotfiles
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Tweak prompt
# ------------------------------------------------------------------------------

# Calculate prompt elements
function bash_prompt_command() {

    # Truncate pwd
    # How many characters of the $PWD should be kept
    local pwdmaxlen=30
    # Indicate that there has been dir truncation
    local trunc_symbol="..."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
    
    # Display clock only if it has changed
    MINUTE=$(date +%M)
    if [ $(($MINUTE - $OLD_MINUTE)) -ne "0" ]
    then
        CLOCK="$(date +%H:%M)|"
    else
        CLOCK=""
    fi   
    OLD_MINUTE=$MINUTE
    
    # Versionned directories features
    local vcs base_dir sub_dir ref
    sub_dir() {
        local sub_dir
        sub_dir=$(readlink -f "${PWD}")
        sub_dir=${sub_dir#$1}
        echo ${sub_dir#/}
    }
    function git_dir() {
        base_dir=$(git-rev-parse --show-cdup 2>/dev/null) || return 1
        base_dir=$(readlink -f "$base_dir/..")
        sub_dir=$(git-rev-parse --show-prefix)
        sub_dir=${sub_dir%/}
        ref=$(git-symbolic-ref -q HEAD || git-name-rev --name-only HEAD 2>/dev/null)
        ref=${ref#refs/heads/}
        vcs="git"
    }
    function svn_dir() {
    [ -d ".svn" ] || return 1
        base_dir="."
        while [ -d "$base_dir/../.svn" ]; do base_dir="$base_dir/.."; done
        base_dir=$(readlink -f "$base_dir")
        sub_dir=$(sub_dir "${base_dir}")
        ref=$(svn info "$base_dir" | awk '/^URL/ { sub(".*/","",$0); r=$0 } /^Revision/ { sub("[^0-9]*","",$0); print r":"$0 }')
        vcs="svn"
    }
    function svk_dir() {
        [ -f ~/.svk/config ] || return 1
        base_dir=$(awk '/: *$/ { sub(/^ */,"",$0); sub(/: *$/,"",$0); if (match("'${PWD}'", $0?(/|$)")) { print $0; d=1; } } /depotpath/ && d == 1 { sub(".*/","",$0); r=$0 } /revision/ && d == 1 { print r ":" $2; exit 1 }' ~/.svk/config) && return 1
        ref=${base_dir##*
        }
        base_dir=${base_dir%%
        *}
        sub_dir=$(sub_dir "${base_dir}")
        vcs="svk"
    }
    function hg_dir() {
        base_dir="."
        while [ ! -d "$base_dir/.hg" ]; do base_dir="$base_dir/.."; [ $(readlink -f "${base_dir}") = "/" ] && return 1; done
        base_dir=$(readlink -f "$base_dir")
        sub_dir=$(sub_dir "${base_dir}")
        ref=$(< "${base_dir}/.hg/branch")
        vcs="hg"
    }
    git_dir ||
    svn_dir ||
    #svk_dir ||
    #hg_dir ||
    base_dir="$PWD"
    if [ -n "$vcs" ]; then
    __vcs_prefix="[$vcs]"
    __vcs_base_dir="$NEW_PWD"
    __vcs_ref="[$ref]"
    __vcs_sub_dir="${sub_dir}"
    else
    __vcs_prefix=""
    __vcs_base_dir="${NEW_PWD}"
    __vcs_ref=""
    __vcs_sub_dir=""
    fi

# Set Window title
# windowtitle ${NEW_PWD}

}

# Construct new prompt
function bash_prompt() {
    PS1="${debian_chroot:+($debian_chroot)}\[$BACKGROUND_BLACK\]\$CLOCK\[$BACKGROUND_GREEN\]\[$BOLD\]\$__vcs_prefix\[$RESET_FORMATTING\]\[$BACKGROUND_BLACK\]\$NEW_PWD\[$RESET_FORMATTING\]\$ "
}

# Build new prompt
OLD_MINUTE="-1"
PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt
