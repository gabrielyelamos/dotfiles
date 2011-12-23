#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et

# ------------------------------------------------------------------------------
# Environment
# ------------------------------------------------------------------------------

# Some personal info.
NAME='Julien Nicoulaud'
MAIL='julien.nicoulaud@gmail.com'
GPGKEY='A20BF77D'

# Constants used for Debian packaging.
DEBFULLNAME=$NAME
DEBEMAIL=$MAIL

# Places.
NICOULAJ_HOME=${${(%):-%N}:A:h}
ZSH_HOME=$NICOULAJ_HOME/zsh
GNOME_PANEL_CONFS_DIR=$NICOULAJ_HOME/.gnome-panel-confs
DROPBOX_DIR=$NICOULAJ_HOME/Dropbox
TODO_STORAGE_DIR=$DROPBOX_DIR/todo
DOCUMENTS_DIR=$NICOULAJ_HOME/documents
PRIVATE_DIR=$DOCUMENTS_DIR/private
DOWNLOADS_DIR=$DOCUMENTS_DIR/downloads


# ----------------------------------------------------------------------------
# Path
# ----------------------------------------------------------------------------

# Zsh functions path.
fpath=($ZSH_HOME/functions/**/ $fpath)

# Commands path.
PATH=$NICOULAJ_HOME/bin:$PATH


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
       CORRECT_ALL \
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

# File where history is saved.
HISTFILE="$NICOULAJ_HOME/.zshhistory"

# Size of the history.
HISTFILESIZE=65536
HISTSIZE=4096
SAVEHIST=$HISTSIZE

# User activity reporting

# Report login/logout events for everybody except me.
watch=(notme)

# Time (seconds) between checks for login/logout activity.
LOGCHECK=60

# Display usage statistics for commands running > 5 sec.
REPORTTIME=5


# ------------------------------------------------------------------------------
# Shell events hooks
# ------------------------------------------------------------------------------

# Hooks initialization
autoload add-zsh-hook

# Force refresh the terminal title before each command.
update_terminal_title() {
  print -Pn "\e]0;%~\a"
}
add-zsh-hook precmd update_terminal_title

# Append current working directory as a comment in history lines.
history_append_cwd() {
  print -sr "${1%%$'\n'} # ${PWD}"
  fc -p
}
#add-zsh-hook zshaddhistory history_append_cwd

# Strip out passwords from commands before inserting in history.
history_strip_passwords() {
  # Strip out -Dgpg.passphrase option value (Maven)
  print -sr "${${1%%$'\n'}//(#b)(gpg.passphrase=)*[:space:]/$match[1]}"
  fc -p
}
#add-zsh-hook zshaddhistory history_strip_passwords


# ------------------------------------------------------------------------------
# MIME types handling
# ------------------------------------------------------------------------------

# Zsh MIME types handler.
autoload -U zsh-mime-setup
autoload -U zsh-mime-handler
zsh-mime-setup


# ------------------------------------------------------------------------------
# Directory browsing
# ------------------------------------------------------------------------------

alias ls='ls                                  --classify --group-directories-first --color=auto'
alias ll='ls -l              --human-readable --classify --group-directories-first --color=auto'
alias la='ls -l --almost-all --human-readable --classify --group-directories-first --color=auto'


# ------------------------------------------------------------------------------
# File management
# ------------------------------------------------------------------------------

alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias rm='nocorrect rm -i'


# ------------------------------------------------------------------------------
# Text editor
# ------------------------------------------------------------------------------

EDITOR=vim
VISUAL=geany
BROWSER=google-chrome

# Zsh web browser handler.
autoload -U pick-web-browser
zstyle ':mime:*' x-browsers google-chrome firefox elinks
alias -s html=pick-web-browser


# ------------------------------------------------------------------------------
# Pager
# ------------------------------------------------------------------------------

PAGER=less
MANPAGER=$PAGER

# Settings for less.
LESS="--LONG-PROMPT --HILITE-UNREAD --ignore-case --tabs=2 --shift 5 --tilde"
LESSCHARSET=utf-8
LESSHISTFILE="$HOME/.lesshst"
LESSHISTSIZE=100

# Use source-highlight if available, else fall back to lesspipe.
if [[ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]]; then
  LESS="${LESS} --RAW-CONTROL-CHARS"
  LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
else
  [[ -x /usr/bin/lesspipe ]] && eval $(lesspipe)
fi

# Vim as pager.
[[ -f /usr/share/vim/vimcurrent/macros/less.sh ]] && alias vless='/usr/share/vim/vimcurrent/macros/less.sh'


# Grep
GREP_OPTIONS="--color=auto \
              --exclude=\*.pyc \
              --exclude-dir=.svn \
              --exclude-dir=.hg \
              --exclude-dir=.bzr \
              --exclude-dir=.git"


# Gnome
alias o='gnome-open'
alias so='gksudo gnome-open'


# ------------------------------------------------------------------------------
# Package auto-suggestion on "command not found"
# ------------------------------------------------------------------------------

[[ -f /etc/zsh_command_not_found ]] && . /etc/zsh_command_not_found


# ------------------------------------------------------------------------------
# Misc
# ------------------------------------------------------------------------------

# todo.sh
(( $+commands[todo.sh] )) && {
  alias todo.sh='env TODO_STORAGE_DIR="$TODO_STORAGE_DIR" todo.sh'
  alias t='todo.sh'
}

# plowshare
(( $+commands[plowdown] )) && {
  alias plowdel='noglob plowdel'
  alias plowdown='noglob plowdown'
  alias plowlist='noglob plowlist'
  alias plowup='noglob plowup'
}

# ArchLinux specific aliases
alias upgrade='yaourt -Syyu --aur --devel'


# ------------------------------------------------------------------------------
# Key bindings / ZLE configuration
# ------------------------------------------------------------------------------


# Activate completion.
autoload -Uz compinit && compinit -u

# Use Emacs line editing mode
bindkey -e

# Word separators (default '*?_-.[]~=/&;!#$%^(){}<>')
WORDCHARS=''

# Sometimes <DEL> is not bound correctly
bindkey '^[[3~' delete-char-or-list 

# <ctrl><left> => previous word
bindkey '^[[1;5D' emacs-backward-word

# <ctrl><right> => next word
bindkey '^[[1;5C' emacs-forward-word

# <up>/<down> => Fish style history substring search
[[ -f $NICOULAJ_HOME/.config/modules/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && . $NICOULAJ_HOME/.config/modules/zsh-history-substring-search/zsh-history-substring-search.zsh

# F5 => 'source ~/.zshrc'
source-zshrc() { source $NICOULAJ_HOME/.zshrc }
zle -N source-zshrc
bindkey $terminfo[kf5] source-zshrc

# <space> => perform history expansion
bindkey ' ' magic-space

# <ctrl><x> <e> => open current line in editor
autoload edit-command-line-in-geany
zle -N edit-command-line-in-geany
bindkey '^Xe' edit-command-line-in-geany

# ..../ => ../../../
autoload rationalize-dots
zle -N rationalize-dots
bindkey . rationalize-dots
bindkey -M isearch . self-insert 2>/dev/null

# Display a symbol while waiting for completion matches to be generated
expand-or-complete-with-symbol() {
  echo -n "▶"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-symbol
bindkey "^I" expand-or-complete-with-symbol

# Autoquote URLs pasted in ZLE
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Save cancelled commands to history
TRAPINT () {
  zle && print -s -- $BUFFER
  return $1
}

# <ctrl><x> <x> => enter a password that will be hidden in the buffer and
# shell history.
autoload enter-password
zle -N enter-password
bindkey '^Xx' enter-password

# Completion debugging
bindkey '^Xh' _complete_help
bindkey '^X?' _complete_debug


# ------------------------------------------------------------------------------
# Shell coloring
# ------------------------------------------------------------------------------

# Not all terms like colors stuff...
[[ "$TERM" != (dumb|linux) ]] && {

  # ----------------------------------------------------------------------------
  # Colors definition
  # ----------------------------------------------------------------------------
  
  autoload colors && colors
  typeset -Ag FX FG BG
  
  # Effects.
  FX=(
    reset     "[00m"
    bold      "[01m" no-bold      "[22m"
    italic    "[03m" no-italic    "[23m"
    underline "[04m" no-underline "[24m"
    blink     "[05m" no-blink     "[25m"
    reverse   "[07m" no-reverse   "[27m"
  )
  
  # 256 colors array (foreground and background).
  for color in {0..255}; do
    FG[$color]="[38;5;${color}m"
    BG[$color]="[48;5;${color}m"
  done
  
  # Add 16 named colors.
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


  # ----------------------------------------------------------------------------
  # Commands output coloring
  # ----------------------------------------------------------------------------

  # ls colorizing with dircolors.
  (( $+commands[dircolors] )) && eval $(dircolors ~/.dir_colors)

  # Colors for less.
  export LESS_TERMCAP_mb=$FX[bold]$FG[blue]
  export LESS_TERMCAP_md=$FX[bold]$FG[blue]
  export LESS_TERMCAP_me=$FX[reset]
  export LESS_TERMCAP_se=$FX[reset]
  export LESS_TERMCAP_so=$BG[darkgrey]$FG[lightgrey]
  export LESS_TERMCAP_ue=$FX[reset]
  export LESS_TERMCAP_us=$FG[blue]

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

  # Colorizing with colorex.
  (( $+commands[colorex] )) && {
    alias @mvn='command mvn'               && alias mvn='colorex --config mvn3 -- mvn'
    alias @mvn2='command mvn2'             && alias mvn2='colorex --config mvn2 -- mvn2'
    alias @diff='command diff'             && alias diff='colorex -- diff'
    alias @df='command df'                 && alias df='colorex -- df'
    alias @host='command host'             && alias host='colorex -- host'
    alias @ifconfig='command ifconfig'     && alias ifconfig='colorex -- ifconfig'
    alias @md5sum='command md5sum'         && alias md5sum='colorex -- md5sum'
    alias @ping='command ping'             && alias ping='colorex -- ping'
    alias @top='command top'               && alias top='colorex -- top'
    alias @traceroute='command traceroute' && alias traceroute='colorex -- traceroute'
    alias @jonas='command jonas'           && alias jonas='colorex -- jonas'
  }

  # Colorizing with color(diff|svn|cvs|gcc|make).
  (( $+commands[colordiff] )) && alias @diff='command diff' && alias diff='colordiff'
  (( $+commands[colorsvn] ))  && alias @svn='command svn'   && alias svn='colorsvn'
  (( $+commands[colorcvs] ))  && alias @cvs='command cvs'   && alias cvs='colorcvs'
  (( $+commands[colormake] )) && alias @make='command make' && alias make='colormake'
  (( $+commands[colorgcc] ))  && [[ -d /usr/lib/colorgcc/bin ]] && export PATH="/usr/lib/colorgcc/bin:$PATH"

  # Colorizing with highlight.
  (( $+commands[highlight] )) && {
    function cat sed awk grep() {
      local syntax=""
      for file in $@; do
        if [[ -f $file ]]; then
          case $file in
            *.java) syntax="java";;
            *.php)  syntax="php";;
            *.py)   syntax="python";;
            *.diff) syntax="diff";;
            *.awk)  syntax="awk";;
            *.c)    syntax="c";;
            *.css)  syntax="css";;
            *.js)   syntax="js";;
            *.jsp)  syntax="jsp";;
            *.xml)  syntax="xml";;
            *.sql)  syntax="sql";;
            *.pl)   syntax="pl";;
            httpd.*|/etc/apache*/*|/etc/httpd/*) syntax="httpd";;
          esac
        fi
      done
      if [[ -n $syntax ]]; then
        command $0 $@ | highlight --ansi --syntax=$syntax
      else
        command $0 $@
      fi
    }
  }


  # ----------------------------------------------------------------------------
  # Prompt
  # ----------------------------------------------------------------------------

  autoload -Uz promptinit && promptinit -i
  prompt nicoulaj 30 ${FG[71]} ${FG[124]} ${FG[darkgrey]} ${FG[172]}


  # ----------------------------------------------------------------------------
  # Command line syntax highlighting
  # ----------------------------------------------------------------------------

  [[ -f $NICOULAJ_HOME/.config/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && {
    . $NICOULAJ_HOME/.config/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
  }
}


# ------------------------------------------------------------------------------
# Completion
# ------------------------------------------------------------------------------

# Force rehash to have completion picking up new commands in $path.
_force_rehash() { (( CURRENT == 1 )) && rehash; return 1 }
zstyle ':completion:::::' completer _force_rehash \
                                    _complete \
                                    _ignored \
                                    _gnu_generic \
                                    _approximate

# Default to parsing "--help" for command that have completion functions.
zstyle ':completion:*' completer _complete \
                                 _ignored \
                                 _gnu_generic \
                                 _approximate

# Speed up completion by avoiding partial globs.
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' accept-exact-dirs true

# Cache setup.
zstyle ':completion:*' use-cache on
#zstyle ':completion:*' cache-path $ZSH_HOME/cache

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
zstyle ':completion:*:messages' format $'\e[1m -- %d --\e[22m'
zstyle ':completion:*:warnings' format $'\e[1m -- No matches found --\e[22m'

# Ignore hidden files by default
zstyle ':completion:*:(all-|other-|)files' ignored-patterns '(.|*/.)*'
zstyle ':completion:*:(local-|)directories' ignored-patterns '(.|*/.)*'
zstyle ':completion:*:cd:*' ignored-patterns '(.|*/.)*'

# Don't complete completion functions/widgets.
zstyle ':completion:*:functions' ignored-patterns '_*'

# Don't complete uninteresting users.
zstyle ':completion:*:*:*:users' ignored-patterns adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
                                                  dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
                                                  hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
                                                  mailman mailnull mldonkey mysql nagios named netdump news \
                                                  nfsnobody nobody nscd ntp nut nx openvpn operator pcap postfix \
                                                  postgres privoxy pulse pvm quagga radvd rpc rpcuser rpm shutdown \
                                                  squid sshd sync uucp vcsa xfs www-data avahi-autoipd

# Show ignored patterns if needed.
zstyle '*' single-ignored show

# cd style.
zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd never selects the parent directory (e.g.: cd ../<TAB>)
zstyle ':completion:*:*:cd:*' tag-order local-directories path-directories

# kill style.
zstyle ':completion:*:*:kill:*' command 'ps -a -w -w -u $USER -o pid,cmd --sort=-pid'
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=39=32"

# man style.
zstyle ':completion:*:manuals' separate-sections true

# rm/cp/mv style.
zstyle ':completion:*:(rm|mv|cp):*' ignore-line yes

# Hostnames completion.
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${${${${(f)"$(<~/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}
  ${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*[*?]*}
  ${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}#*[[:blank:]]}}
)'
zstyle ':completion:*:*:*:hosts' ignored-patterns 'ip6*' 'localhost*'

# Completion functions development.
bindkey "^Xh" _complete_help


# ------------------------------------------------------------------------------
# Config fragments
# ------------------------------------------------------------------------------

# Load configs in $ZSH_HOME/conf.d.
for conf ($ZSH_HOME/zshrc.d/*.(|ba|z|tc|k)sh) source $conf


# ------------------------------------------------------------------------------
# Compilation
# ------------------------------------------------------------------------------

# Recompile if needed.
autoload -U zrecompile
[[ -f $NICOULAJ_HOME/.zshrc ]] && zrecompile -p $NICOULAJ_HOME/.zshrc
[[ -f $NICOULAJ_HOME/.zcompdump ]] && zrecompile -p $NICOULAJ_HOME/.zcompdump
