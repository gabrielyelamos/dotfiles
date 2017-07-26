#!/bin/sh
# See https://eklitzke.org/using-ssh-agent-and-ed25519-keys-on-gnome

eval $(systemctl --user show-environment | grep SSH_AUTH_SOCK)
export SSH_AUTH_SOCK
