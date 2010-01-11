#!/bin/bash
# ------------------------------------------------------------------------------
# Description
#   bash-completion script for Maven's "mvn" command.
#
# Usage
#   Locate the bash_completion.d/ folder:
#     $ sudo updatedb && locate bash_completion.d
#   Drop this file there, or create a symbolic link to this file from there.
#
# Author
#   nicoulaj - http://www.ju-n.net
# 
# Project
#   dotfiles - http://github.com/nicoulaj/dotfiles
# ------------------------------------------------------------------------------

#
_maven2_generate_goals()
{
  plugin=$1
  mojos=$2
  for mojo in $mojos
  do
    export goals="$goals $plugin:$mojo"
  done
}

#
_maven2_complete()
{
  local cur goals
  
  # Add Maven default life cycle phases
  goals='clean compile test install package deploy site'
  
  # Commonly used parameters
  goals=$goals'-DartifactId= -DgroupId= -Dmaven.test.skip=true -Dversion= -Dpackaging= -Dclassifier= -Dfile= -Declipse.workspace= -DarchetypeArtifactId= -DarchetypeGroupId= -DarchetypeVersion='
  
  # Maven Eclipse plugin
  goals=$goals _maven2_generate_goals "eclipse" "eclipse configure-workspace clean m2eclipse to-maven install-plugins make-artifacts myeclipse myeclipse-clean rad rad-clean"
  
  # Maven Idea plugin
  goals=$goals _maven2_generate_goals "idea" "clean help idea module project workspace"
  
  # Maven assembly plugin
  goals=$goals _maven2_generate_goals "assembly" "assembly attached directory directory-inline directory-single help single unpack"
  
  # Flexmojos plugin
  goals=$goals _maven2_generate_goals "flexmojos" "asdoc asdoc-report attach-asdoc attach-dita-asdoc axdt compile-swc compile-swf copy-flex-resources dita-asdoc flexbuilder flexcover flexcover-run generate generate-config-swc generate-config-swf instrument instrument-swc manifest optimize sign-air source-view sources test-compile test-run test-swc test-swf trust wrapper"
  
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}
  colonprefixes=${cur%"${cur##*:}"}
  COMPREPLY=( $(compgen -W '$goals'  -- $cur) )
  local i=${#COMPREPLY[*]}
  while [ $((--i)) -ge 0 ]; do
    COMPREPLY[$i]=${COMPREPLY[$i]#"$colonprefixes"}
  done
  return 0
}

# Bind "mvn" completion to _maven2_complete()
complete -F _maven2_complete -o filenames mvn
