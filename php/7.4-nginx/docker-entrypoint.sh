#!/usr/bin/env sh

# check if the first argument passed in is composer
if [ $# -gt 0 ]; then
  exec docker-fpm-entrypoint "$@"
# check if the first argument passed in matches a known command
else
  exec /init
fi