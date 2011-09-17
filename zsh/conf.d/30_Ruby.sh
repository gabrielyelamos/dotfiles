#!/usr/bin/env zsh
# vim: ft=zsh sw=2 ts=2 et
# ------------------------------------------------------------------------------
# Settings for Ruby.
# ------------------------------------------------------------------------------


RUBY_VERSION=1.8

# Update PATH to use Ruby gems.
[[ -d ~/.gem/ruby/$RUBY_VERSION/bin ]] && export PATH=~/.gem/ruby/$RUBY_VERSION/bin:$PATH
[[ -d /var/lib/gems/$RUBY_VERSION/bin ]] && export PATH=/var/lib/gems/$RUBY_VERSION/bin:$PATH

# RVM
[[ -s ~/.rvm/scripts/rvm ]] && source ~/.rvm/scripts/rvm
