#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et
# ------------------------------------------------------------------------------
# Shell completion settings.
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Other shells completion compatibility
# ------------------------------------------------------------------------------

# Activate Bash auto-completion
autoload -U bashcompinit
bashcompinit


# ------------------------------------------------------------------------------
# Zsh completion
# ------------------------------------------------------------------------------

# Activate auto-completion
autoload -Uz compinit && compinit -u

# Force rehash to have completion picking up new commands in $path.
autoload _force_rehash
zstyle ':completion:::::' completer _force_rehash _complete _approximate

# Use cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_completion_cache

# Ignore VCS directories
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)(.svn|.git|.hg)'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)(.svn|.git|.hg)'

# Ignore completion functions for commands I don’t have
zstyle ':completion:*:functions' ignored-patterns '_*'

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs www-data \
        avahi-autoipd

# Show ignored patterns if needed
zstyle '*' single-ignored show

# cd style
zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd never selects the parent directory (e.g.: cd ../<TAB>)
zstyle ':completion:*:*:cd:*' tag-order local-directories path-directories


zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' file-sort name
zstyle ':completion:*' list-colors ${(s.:.)ZLS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*' verbose true
zstyle ':completion:*' squeeze-slashes true

# kill style
zstyle ':completion:*:*:kill:*' command 'ps -a -w -w -u $USER -o pid,cmd --sort=-pid'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=39=32"

zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes

# Hostnames completion, using /etc/hosts and known_hosts
[[ -r ~/.ssh/known_hosts ]] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[[ -r /etc/hosts ]] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=( "$_ssh_hosts[@]" "$_etc_hosts[@]" `hostname` localhost )
zstyle ':completion:*:hosts' hosts $hosts
