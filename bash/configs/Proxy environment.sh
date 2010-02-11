#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Description
#   Propagate the proxy settings to the system and applications. The proxy
#   variables must have been set:
#     $ export PROXY_HOST="proxy"
#     $ export PROXY_PORT="port"
#     $ export NON_PROXY_HOSTS="host1|host2|..."
#   NON_PROXY_HOSTS should at least include "localhost".
#
# Dependencies
#   none.
#
# Author
#   nicoulaj - http://www.ju-n.net
# 
# Project
#   dotfiles - http://github.com/nicoulaj/dotfiles
# ------------------------------------------------------------------------------

# Http proxy
export http_proxy="http://${PROXY_HOST}:${PROXY_PORT}"

# Execution options
export JAVA_OPTS="${JAVA_OPTS} -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} -Dhttp.proxySet=true -Dhttp.nonProxyHosts=\"${NON_PROXY_HOSTS}\""
export MAVEN_OPTS="${MAVEN_OPTS} -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} -Dhttp.proxySet=true -Dhttp.nonProxyHosts=\"${NON_PROXY_HOSTS}\""
export ANT_OPTS="${ANT_OPTS} -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} -Dhttp.proxySet=true -Dhttp.nonProxyHosts=\"${NON_PROXY_HOSTS}\""
