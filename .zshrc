#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
# Environment
# ------------------------------------------------------------------------------

# Some personal info.
export NAME='Julien Nicoulaud'
export MAIL='julien.nicoulaud@gmail.com'
export GPGKEY='A20BF77D'

# Constants used for Debian packaging.
export DEBFULLNAME=$NAME
export DEBEMAIL=$MAIL

# System "main" user info.
export MAIN_USER_HOME=${${(%):-%N}:A:h} # Resolve from zshrc location, following symlinks.
export MAIN_USER=${MAIN_USER_HOME:t}

# Functions path.
[[ -d $MAIN_USER_HOME/.config/zsh/functions ]] && fpath=($MAIN_USER_HOME/.config/zsh/functions/**/ $fpath)

# Commands path.
[[ -d $MAIN_USER_HOME/bin ]]       && path=($MAIN_USER_HOME/bin $path)             # ~/bin
(( $+commands[gem] )) && path=($(ruby -rubygems -e "puts Gem.user_dir")/bin $path) # Ruby gems


# ----------------------------------------------------------------------------
# Options
# ----------------------------------------------------------------------------

setopt AUTO_CD \
       AUTO_PUSHD \
       CDABLE_VARS \
       NO_CHASE_DOTS \
       CHASE_LINKS \
       PUSHD_IGNORE_DUPS \
       NO_PUSHD_MINUS \
       NO_PUSHD_SILENT \
       PUSHD_TO_HOME \
       ALWAYS_LAST_PROMPT \
       NO_ALWAYS_TO_END \
       AUTO_LIST \
       NO_AUTO_MENU \
       AUTO_NAME_DIRS \
       AUTO_PARAM_KEYS \
       AUTO_PARAM_SLASH \
       AUTO_REMOVE_SLASH \
       NO_BASH_AUTO_LIST \
       COMPLETE_ALIASES \
       COMPLETE_IN_WORD \
       GLOB_COMPLETE \
       HASH_LIST_ALL \
       LIST_AMBIGUOUS \
       NO_LIST_BEEP \
       LIST_PACKED \
       NO_LIST_ROWS_FIRST \
       LIST_TYPES \
       NO_MENU_COMPLETE \
       NO_REC_EXACT \
       BAD_PATTERN \
       NO_BARE_GLOB_QUAL \
       NO_BRACE_CCL \
       NO_CASE_GLOB \
       CASE_MATCH \
       NO_CSH_NULL_GLOB \
       EQUALS \
       EXTENDED_GLOB \
       GLOB \
       NO_GLOB_ASSIGN \
       NO_GLOB_DOTS \
       NO_GLOB_SUBST \
       HIST_SUBST_PATTERN \
       NO_IGNORE_BRACES \
       NO_KSH_GLOB \
       NO_MAGIC_EQUAL_SUBST \
       NO_MARK_DIRS \
       MULTIBYTE \
       NOMATCH \
       NO_NULL_GLOB \
       NO_NUMERIC_GLOB_SORT \
       RC_EXPAND_PARAM \
       REMATCH_PCRE \
       NO_SH_GLOB \
       UNSET \
       NO_WARN_CREATE_GLOBAL \
       APPEND_HISTORY \
       BANG_HIST \
       EXTENDED_HISTORY \
       NO_HIST_ALLOW_CLOBBER \
       NO_HIST_BEEP \
       HIST_EXPIRE_DUPS_FIRST \
       NO_HIST_FCNTL_LOCK \
       HIST_FIND_NO_DUPS \
       NO_HIST_IGNORE_ALL_DUPS \
       HIST_IGNORE_DUPS \
       NO_HIST_IGNORE_SPACE \
       NO_HIST_NO_FUNCTIONS \
       NO_HIST_NO_STORE \
       HIST_REDUCE_BLANKS \
       HIST_SAVE_BY_COPY \
       HIST_SAVE_NO_DUPS \
       HIST_VERIFY \
       INC_APPEND_HISTORY \
       SHARE_HISTORY \
       NO_ALL_EXPORT \
       GLOBAL_EXPORT \
       GLOBAL_RCS \
       RCS \
       ALIASES  \
       CLOBBER \
       CORRECT \
       NO_CORRECT_ALL \
       NO_DVORAK \
       FLOW_CONTROL \
       NO_IGNORE_EOF \
       INTERACTIVE_COMMENTS \
       NO_HASH_CMDS \
       NO_HASH_DIRS \
       NO_MAIL_WARNING \
       PATH_DIRS \
       PRINT_EIGHT_BIT \
       NO_PRINT_EXIT_VALUE \
       NO_RC_QUOTES \
       NO_RM_STAR_SILENT \
       NO_RM_STAR_WAIT \
       SHORT_LOOPS \
       NO_SUN_KEYBOARD_HACK \
       AUTO_CONTINUE \
       AUTO_RESUME \
       BG_NICE \
       CHECK_JOBS \
       HUP \
       LONG_LIST_JOBS \
       MONITOR \
       NOTIFY \
       NO_PROMPT_BANG \
       PROMPT_CR \
       PROMPT_SP \
       PROMPT_PERCENT \
       PROMPT_SUBST \
       NO_TRANSIENT_RPROMPT \
       C_BASES \
       NO_C_PRECEDENCES \
       DEBUG_BEFORE_CMD \
       NO_ERR_EXIT \
       NO_ERR_RETURN \
       EVAL_LINENO \
       EXEC \
       FUNCTION_ARGZERO \
       NO_LOCAL_OPTIONS \
       NO_LOCAL_TRAPS \
       MULTI_FUNC_DEF \
       MULTIOS \
       NO_OCTAL_ZEROES \
       NO_TYPESET_SILENT \
       NO_VERBOSE \
       NO_XTRACE \
       NO_BASH_REMATCH \
       NO_BSD_ECHO \
       NO_CSH_JUNKIE_HISTORY \
       NO_CSH_JUNKIE_LOOPS \
       NO_CSH_JUNKIE_QUOTES \
       NO_CSH_NULLCMD \
       NO_KSH_ARRAYS \
       NO_KSH_AUTOLOAD \
       NO_KSH_OPTION_PRINT \
       NO_KSH_TYPESET \
       NO_KSH_ZERO_SUBSCRIPT \
       NO_POSIX_ALIASES \
       NO_POSIX_BUILTINS \
       NO_POSIX_IDENTIFIERS \
       NO_SH_FILE_EXPANSION \
       NO_SH_NULLCMD \
       NO_SH_OPTION_LETTERS \
       NO_SH_WORD_SPLIT \
       NO_TRAPS_ASYNC \
       NO_BEEP \
       COMBINING_CHARS \
       EMACS \
       NO_OVERSTRIKE \
       NO_SINGLE_LINE_ZLE \
       NO_VI \
       ZLE

# History settings.
export HISTFILE="$MAIN_USER_HOME/.zshhistory"
export HISTFILESIZE=65536
export HISTSIZE=4096
export SAVEHIST=$HISTSIZE

# User activity reporting.
watch=(notme)
LOGCHECK=60

# Display usage statistics for commands running > 5 sec.
REPORTTIME=5

# Hooks.
autoload -U add-zsh-hook && {
  # Force refresh the terminal title before each command.
  update_terminal_title() { print -Pn "\e]0;%~\a"; }
  add-zsh-hook precmd update_terminal_title
}


# ----------------------------------------------------------------------------
# Aliases / default applications settings
# ----------------------------------------------------------------------------

# Shortcuts
alias o='xdg-open'
alias so='gksudo xdg-open'
alias p='pwd'

# ls
alias ls='ls --color=auto --group-directories-first --classify --human-readable'
alias ll='ls --color=auto --group-directories-first --classify --human-readable -l'
alias la='ls --color=auto --group-directories-first --classify --human-readable -l --almost-all'

# cp/mv/rm
alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -i'

# Default editors/browsers.
export EDITOR=vim
export VISUAL=geany
export BROWSER=google-chrome

# Pager
export PAGER=less
export MANPAGER=$PAGER
export LESS='--LONG-PROMPT --HILITE-UNREAD --ignore-case --tabs=2 --shift 5 --tilde'
export LESSCHARSET=utf-8
export LESSHISTFILE="$MAIN_USER_HOME/.lesshst"
export LESSHISTSIZE=2000

# Grep
alias grep='grep --color=auto --exclude="*.pyc" --exclude-dir=".svn" --exclude-dir=".hg" --exclude-dir=".bzr" --exclude-dir=".git"'

# Command not found
[[ -f /etc/zsh_command_not_found ]] && . /etc/zsh_command_not_found

# Zsh MIME types handling.
autoload -U zsh-mime-setup zsh-mime-handler && {
  zsh-mime-setup
  autoload -U pick-web-browser && {
    zstyle ':mime:*' x-browsers google-chrome firefox elinks
    alias -s html=pick-web-browser
  }
}


# ------------------------------------------------------------------------------
# Key bindings / ZLE configuration
# ------------------------------------------------------------------------------

# Use Emacs line editing mode
bindkey -e

# Word separator characters
WORDCHARS=''

# Common key bindings
bindkey '^[[3~'   delete-char-or-list # <del> => delete next char
bindkey '^[[1;5D' emacs-backward-word # <ctrl><left>  => previous word
bindkey '^[[1;5C' emacs-forward-word  # <ctrl><right> => next word
bindkey '^[[3;5~' backward-kill-word  # <ctrl><del>   => delete next word
bindkey ' '       magic-space         # <space> => perform history expansion

# F5 => '. ~/.zshrc'
r() { . $MAIN_USER_HOME/.zshrc }
zle -N r
bindkey $terminfo[kf5] r

# <ctrl><x> <e> => open current line in editor
autoload -U edit-command-line-in-geany && {
  zle -N edit-command-line-in-geany
  bindkey '^Xe' edit-command-line-in-geany
}

# ..../ => ../../../
autoload -U rationalize-dots && {
  zle -N rationalize-dots
  bindkey . rationalize-dots
  bindkey -M isearch . self-insert &>/dev/null # Exclude from isearch
}

# Autoquote URLs pasted in ZLE
autoload -U url-quote-magic && {
  zle -N self-insert url-quote-magic
}

# Save cancelled commands to history
TRAPINT () {
  zle && [[ $HISTNO -eq $HISTCMD ]] && print -rs -- $BUFFER
  return $1
}

# <ctrl><x> <x> => enter a password that will be hidden in the buffer and
# shell history.
autoload -U enter-password && {
  zle -N enter-password
  bindkey '^Xx' enter-password
}

# <up>/<down> => Fish style history substring search
. /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh &>/dev/null || \
. $MAIN_USER_HOME/projects/zsh-history-substring-search/zsh-history-substring-search.zsh &>/dev/null


# ------------------------------------------------------------------------------
# Completion
# ------------------------------------------------------------------------------

autoload -U compinit && {

  # Init completion, ignoring security checks.
  compinit -C

  # Force rehash to have completion picking up new commands in path.
  _force_rehash() { (( CURRENT == 1 )) && rehash; return 1 }
  zstyle ':completion:::::' completer _force_rehash \
                                      _complete \
                                      _ignored \
                                      _gnu_generic \
                                      _approximate
  zstyle ':completion:*'    completer _complete \
                                      _ignored \
                                      _gnu_generic \
                                      _approximate

  # Speed up completion by avoiding partial globs.
  zstyle ':completion:*' accept-exact '*(N)'
  zstyle ':completion:*' accept-exact-dirs true

  # Cache setup.
  zstyle ':completion:*' use-cache on

  # Default colors for listings.
  zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'

  # Separate directories from files.
  zstyle ':completion:*' list-dirs-first true

  # Turn on menu selection only when selections do not fit on screen.
  zstyle ':completion:*' menu true=long select=long

  # Separate matches into groups.
  zstyle ':completion:*:matches' group yes
  zstyle ':completion:*' group-name ''

  # Always use the most verbose completion.
  zstyle ':completion:*' verbose true

  # Treat sequences of slashes as single slash.
  zstyle ':completion:*' squeeze-slashes true

  # Describe options.
  zstyle ':completion:*:options' description yes

  # Completion presentation styles.
  zstyle ':completion:*:options' auto-description '%d'
  zstyle ':completion:*:descriptions' format $'\e[1m -- %d --\e[22m'
  zstyle ':completion:*:messages'     format $'\e[1m -- %d --\e[22m'
  zstyle ':completion:*:warnings'     format $'\e[1m -- No matches found --\e[22m'

  # Ignore hidden files by default
  zstyle ':completion:*:(all-|other-|)files'  ignored-patterns '*/.*'
  zstyle ':completion:*:(local-|)directories' ignored-patterns '*/.*'
  zstyle ':completion:*:cd:*'                 ignored-patterns '*/.*'

  # Don't complete completion functions/widgets.
  zstyle ':completion:*:functions' ignored-patterns '_*'

  # Don't complete uninteresting users.
  zstyle ':completion:*:*:*:users' ignored-patterns adm amanda apache avahi \
    beaglidx bin cacti canna clamav daemon dbus distcache dovecot junkbust  \
    games gdm gkrellmd gopher hacluster haldaemon halt hsqldb ident ftp fax \
    ldap lp mail mailman mailnull mldonkey mysql nagios named netdump news  \
    nfsnobody nobody nscd ntp nut nx openvpn operator pcap postfix postgres \
    privoxy pulse pvm quagga radvd rpc rpcuser rpm shutdown squid sshd sync \
    uucp vcsa xfs www-data avahi-autoipd gitblit http rtkit sabnzbd usbmux  \
    sickbeard systemd-\* nvidia-\* polkitd colord grafana influxdb netdata \
    sonarr uuidd xmms2 lxdm

  # Show ignored patterns if needed.
  zstyle '*' single-ignored show

  # cd style.
  zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd never selects the parent directory (e.g.: cd ../<TAB>)
  zstyle ':completion:*:*:cd:*' tag-order local-directories path-directories

  # kill style.
  zstyle ':completion:*:*:kill:*' command 'ps -a -w -w -u $USER -o pid,cmd --sort=-pid'
  zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=39=32"

  # rm/cp/mv style.
  zstyle ':completion:*:(rm|mv|cp):*' ignore-line yes

  # Hostnames completion.
  zstyle -e ':completion:*:hosts' hosts 'reply=(
    ${(s/ /)${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*[*?]*}}
    ${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}#*[[:blank:]]}}
  )'
  zstyle ':completion:*:*:*:hosts' ignored-patterns 'ip6*' 'localhost*'

  # Use zsh-completions if available.
  [[ -d $MAIN_USER_HOME/projects/zsh-completions ]] && fpath=($MAIN_USER_HOME/projects/zsh-completions/src $fpath)

  # Completion debugging
  bindkey '^Xh' _complete_help
  bindkey '^X?' _complete_debug
}


# ------------------------------------------------------------------------------
# Colors
# ------------------------------------------------------------------------------

# Not all terms like colors stuff...
[[ "$TERM" != (dumb|linux) ]] && {

  # Effects array, 256 colors foreground/background arrays,
  autoload -U colors && colors
  typeset -Ag FX FG BG
  FX=(
    reset     "$(tput sgr0)"
    bold      "$(tput bold)"
    italic    "$(tput sitm)"  no-italic    "$(tput ritm)"
    underline "$(tput smul)"  no-underline "$(tput rmul)"
    blink     "$(tput blink)"
    reverse   "$(tput rev)"   no-reverse   "$(tput rum)"
    standout  "$(tput smso)"  no-standout  "$(tput rmso)"
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

  # Prompt
  autoload -Uz promptinit && promptinit -i
  prompt nicoulaj 30 ${FG[71]} ${FG[172]} ${FG[darkgrey]} ${FG[172]}

  # ls colorizing with dircolors.
  (( $+commands[dircolors] )) && eval $(dircolors $MAIN_USER_HOME/.dir_colors)

  # less: colors
  export LESS_TERMCAP_mb=$FX[bold]$FG[blue]
  export LESS_TERMCAP_md=$FX[bold]$FG[blue]
  export LESS_TERMCAP_me=$FX[reset]
  export LESS_TERMCAP_so=$BG[darkgrey]$FG[lightgrey]
  export LESS_TERMCAP_se=$FX[reset]
  export LESS_TERMCAP_us=$FX[underline]$FG[white]
  export LESS_TERMCAP_ue=$FX[no-underline]$FX[reset]
  export LESS_TERMCAP_mr=$FX[reverse]$FX[bold]
  export LESS_TERMCAP_mh=$FX[bold]

  # less: syntax highlighting
  if (( $+commands[src-hilite-lesspipe.sh] )); then
    export LESS="${LESS} --RAW-CONTROL-CHARS"
    export LESSOPEN="| src-hilite-lesspipe.sh %s"
  elif (( $+commands[lesspipe.sh] )); then
    eval $(lesspipe.sh)
  fi

  # Colorizing with grc.
  (( $+commands[grc] )) && {
    alias @diff='command diff'             && alias diff='grc diff'
    alias @make='command make'             && alias make='grc make'
    alias @gcc='command gcc'               && alias gcc='grc gcc'
    alias @g++='command g++'               && alias g++='grc g++'
    alias @ld='command ld'                 && alias ld='grc ld'
    alias @netstat='command netstat'       && alias netstat='grc netstat'
    alias @ping='command ping'             && alias ping='grc ping'
    alias @cvs='command cvs'               && alias cvs='grc cvs'
    alias @traceroute='command traceroute' && alias traceroute='grc traceroute'
  }

  # Colorizing with rainbow.
  (( $+commands[rainbow] )) && {
    alias @mvn='command mvn'               && alias mvn='rainbow --config mvn3 -- mvn'
    alias @mvn2='command mvn2'             && alias mvn2='rainbow --config mvn2 -- mvn2'
    alias @diff='command diff'             && alias diff='rainbow -- diff'
    alias @df='command df'                 && alias df='rainbow -- df'
    alias @host='command host'             && alias host='rainbow -- host'
    alias @ifconfig='command ifconfig'     && alias ifconfig='rainbow -- ifconfig'
    alias @md5sum='command md5sum'         && alias md5sum='rainbow -- md5sum'
    alias @ping='command ping'             && alias ping='rainbow -- ping'
    alias @top='command top'               && alias top='rainbow -- top'
    alias @traceroute='command traceroute' && alias traceroute='rainbow -- traceroute'
    alias @jonas='command jonas'           && alias jonas='rainbow -- jonas'
  }

  # Colorizing with color(diff|svn|cvs|gcc|make).
  (( $+commands[colordiff] )) && alias @diff='command diff' && alias diff='colordiff'
  (( $+commands[colorsvn] ))  && alias @svn='command svn'   && alias svn='colorsvn'
  (( $+commands[colorcvs] ))  && alias @cvs='command cvs'   && alias cvs='colorcvs'
  (( $+commands[colormake] )) && alias @make='command make' && alias make='colormake'
  (( $+commands[colorgcc] ))  && [[ -d /usr/lib/colorgcc/bin ]] && path=(/usr/lib/colorgcc/bin $path)

  # zsh-syntax-highlighting
  . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh &>/dev/null || \
  . $MAIN_USER_HOME/projects/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh &>/dev/null && {
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
    ZSH_HIGHLIGHT_PATTERNS+=('rm -fr *' 'fg=white,bold,bg=red')
  }
}


# ------------------------------------------------------------------------------
# Site-specific stuff
# ------------------------------------------------------------------------------

# Distro-specific stuff
if grep -q 'Arch Linux' /etc/issue &> /dev/null && [[ -d $MAIN_USER_HOME/bin/arch ]]; then
  path=($MAIN_USER_HOME/bin/arch $path)
elif grep -Pq '(Ubuntu|Debian)' /etc/issue &> /dev/null && [[ -d $MAIN_USER_HOME/bin/debian ]]; then
  path=($MAIN_USER_HOME/bin/debian $path)
elif grep -Pq '(Red Hat|CentOS)' /etc/issue &> /dev/null && [[ -d $MAIN_USER_HOME/bin/rhel ]]; then
  path=($MAIN_USER_HOME/bin/rhel $path)
fi

# Local/modularized stuff.
for conf ($MAIN_USER_HOME/.config/zsh/zshrc.d/*.(|ba|z|tc|k)sh(#q.N)) source $conf


# ------------------------------------------------------------------------------
# Performance
# ------------------------------------------------------------------------------

# Recompile if needed.
autoload -U zrecompile && zrecompile -p $MAIN_USER_HOME/.{zcompdump,zshrc} &>/dev/null

# vim: ft=zsh sw=2 ts=2 et
