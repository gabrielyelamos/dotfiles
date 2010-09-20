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
# ------------------------------------------------------------------------------


# Print a summary of the proxy-related environment variables.
function proxy-check ()
{
  echo "`set_color -o blue`\$http_proxy`set_color normal` $http_proxy"
  echo "`set_color -o blue`\$PROXY_HOST`set_color normal` $PROXY_HOST"
  echo "`set_color -o blue`\$PROXY_PORT`set_color normal` $PROXY_PORT"
  echo "`set_color -o blue`\$NON_PROXY_HOSTS`set_color normal` $NON_PROXY_HOSTS"
}


# Update the environment variables
if [[ -n $PROXY_HOST ]]; then
  
  # Assign a default value to the port if not set
  if [[ -z $PROXY_PORT ]]; then
    PROXY_PORT=80
  fi
  
  # Default proxy variable
  http_proxy="http://${PROXY_HOST}:${PROXY_PORT}"

  # Execution options
  JAVA_OPTS="${JAVA_OPTS} -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} -Dhttp.proxySet=true -Dhttp.nonProxyHosts=\"${NON_PROXY_HOSTS}\""
  MAVEN_OPTS="${MAVEN_OPTS} -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} -Dhttp.proxySet=true -Dhttp.nonProxyHosts=\"${NON_PROXY_HOSTS}\""
  ANT_OPTS="${ANT_OPTS} -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} -Dhttp.proxySet=true -Dhttp.nonProxyHosts=\"${NON_PROXY_HOSTS}\""

fi
