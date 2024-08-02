#!/usr/bin/env bash

set -eEuo pipefail

function debug() {
  >&2 echo "$0: $@"
}

if [[ -z "$APP" ]]; then
  debug "missing APP environment variable"
  exit 1
fi

# use 85% of the container's available memory
JAVA_HEAP_PERCENT=${JAVA_HEAP_PERCENT:-85}
JAVA_HEAP_OPTS=""

# TAP sets the CONTAINER_MEM_MB environment variable
if [ -n "${CONTAINER_MEM_MB:-}" ]; then
  JAVA_HEAP_MB=$(($CONTAINER_MEM_MB * $JAVA_HEAP_PERCENT / 100))

  debug "Setting JVM heap size to ${JAVA_HEAP_PERCENT}% of ${CONTAINER_MEM_MB}m = ${JAVA_HEAP_MB}m"
  JAVA_HEAP_OPTS="-Xms${JAVA_HEAP_MB}m -Xmx${JAVA_HEAP_MB}m"
fi

export JAVA_OPTS="$JAVA_HEAP_OPTS ${APP_JAVA_OPTS:-}"

debug "Starting app: $@"

"/$APP/bin/$APP" $@

debug "App exited with code: $?"