# Http proxy
export http_proxy="http://${PROXY_HOST}:${PROXY_PORT}"

# Execution options
export JAVA_OPTS="${JAVA_OPTS} -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} -Dhttp.proxySet=true -Dhttp.nonProxyHosts=localhost|*.frec.bull.fr"
export MAVEN_OPTS="${MAVEN_OPTS} -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} -Dhttp.proxySet=true -Dhttp.nonProxyHosts=localhost|*.frec.bull.fr"
export ANT_OPTS="${ANT_OPTS} -Dhttp.proxyHost=${PROXY_HOST} -Dhttp.proxyPort=${PROXY_PORT} -Dhttp.proxySet=true"

