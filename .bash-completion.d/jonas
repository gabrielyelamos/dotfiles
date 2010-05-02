#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   bash-completion script for the "jonas" command (http://jonas.ow2.org).
# ------------------------------------------------------------------------------

_jonas_make_options()
{
    COMPREPLY=( ${COMPREPLY[@]} \
                $( compgen -W "`echo "-$@" | sed -e 's/\ /\ -/g'`" -- $cur ) \
                $( compgen -P "-" -W "$@" -- $cur ) )
}

_jonas_make_java_options()
{
    COMPREPLY=( ${COMPREPLY[@]} \
                $( compgen -W "`echo "-D$@=" | sed -e 's/\ /=\ -D/g'`" -- $cur ) \
                $( compgen -P "-D" -S "=" -W "$@" -- $cur ) )
}

_jonas()
{
    cur=${COMP_WORDS[COMP_CWORD]}
    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=( $( compgen -W "start stop admin version check" -- $cur ) )
    else
        prev=${COMP_WORDS[COMP_CWORD-1]}
        command=${COMP_WORDS[1]}
        case "$command" in
        start)
            case "$prev" in
                -n|-target)
                    COMPREPLY=()
                    ;;
                *)
                    _jonas_make_options "standby fg bg win tui gui dev clean n target"
                    _jonas_make_java_options "domain.name"
                    ;;
            esac
            ;;
        stop)
            case "$prev" in
                -n|-target)
                    COMPREPLY=()
                    ;;
                *)
                    _jonas_make_options "standby n target"
                    _jonas_make_java_options "domain.name"
                    ;;
            esac
            ;;
        admin)
            jonas_admin_opts="win n registry protocol username password ? a r gc passivate e j l synch debug tt ping"
            case "$prev" in
                -n|-registry|-debug|-timeout)
                    COMPREPLY=()
                    ;;
                -username)
                    COMPREPLY=( $(compgen -W "$USER jonas" $cur ) )
                    ;;
                -password)
                    COMPREPLY=( $(compgen -W "jonas" $cur ) )
                    ;;
                -protocol)
                    COMPREPLY=( $( compgen -W "jrmp iiop irmi" -- $cur ) )
                    ;;
                -a|-r)
                    if [ -z $cur ]; then
                      COMPREPLY=( $(compgen -W "`pwd`" $cur ) )
                    else
                      COMPREPLY=( $(compgen -f -X "!*.ear" $cur ) \
                                  $(compgen -f -X "!*.war" $cur ) \
                                  $(compgen -f -X "!*.jar" $cur ) \
                                  $(compgen -f -X "!*.rar" $cur ) \
                                  $(compgen -d $cur ) )
                    fi
                    ;;
                -ping)
                    _jonas_make_options "$jonas_admin_opts timeout"
                    ;;
                *)
                    _jonas_make_options "$jonas_admin_opts"
                    ;;
            esac
            ;;
        version)
            COMPREPLY=()
            ;;
        check)
            _jonas_make_options "help"
            ;;
        esac
    fi
}

complete -o filenames -F _jonas jonas
