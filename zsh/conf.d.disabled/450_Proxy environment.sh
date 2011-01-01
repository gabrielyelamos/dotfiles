#!/usr/bin/env bash
# vim: ft=zsh sw=2 ts=2 et
# ------------------------------------------------------------------------------
# Description
#   Propagate the proxy settings to the system and applications. The proxy
#   variables must have been set:
#     $ export PROXY_HOST="proxy"
#     $ export PROXY_PORT="port"
#     $ export NON_PROXY_HOSTS="host1|host2|..."
#   NON_PROXY_HOSTS should at least include "localhost".
# ------------------------------------------------------------------------------

if [[ -n $PROXY_HOST ]]; then

  # Assign a default value to the port if not set
  PROXY_PORT=${PROXY_PORT:-80}

  # Default proxy variable
  http_proxy="http://${PROXY_HOST}:${PROXY_PORT}"
  https_proxy=$http_proxy
  ftp_proxy=$http_proxy

  # Execution options
  JAVA_OPTS="${JAVA_OPTS} -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} -Dhttp.proxySet=true -Dhttp.nonProxyHosts=\"${NON_PROXY_HOSTS}\""
  MAVEN_OPTS="${MAVEN_OPTS} -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} -Dhttp.proxySet=true -Dhttp.nonProxyHosts=\"${NON_PROXY_HOSTS}\""
  ANT_OPTS="${ANT_OPTS} -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} -Dhttp.proxySet=true -Dhttp.nonProxyHosts=\"${NON_PROXY_HOSTS}\""

fi
