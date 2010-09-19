#!/usr/bin/env zsh
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
autoload -Uz compinit && compinit

# Use cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_completion_cache

# Ignore VCS directories
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/).svn'
zstyle ':completion:*:cd:*' ignored-patterns '(*/).svn'

# Ignore completion functions for commands I don’t have
zstyle ':completion:*:functions' ignored-patterns '_*'

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

# Rationalize dots (allows to cd ...../)
rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}
zle -N rationalise-dot
bindkey . rationalise-dot


# ------------------------------------------------------------------------------
# Package auto-suggestion on "command not found"
# ------------------------------------------------------------------------------

if [ -e /etc/zsh_command_not_found ]; then
  . /etc/zsh_command_not_found
fi
