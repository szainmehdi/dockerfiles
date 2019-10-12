#!/usr/bin/env bash

# check if the first argument passed in looks like a flag
if [ "$(printf %c "$1")" = '-' ]; then
  set -- /sbin/tini -- composer --ansi "$@"
# check if the first argument passed in is composer
elif [ "$1" = 'composer' ]; then
  set -- /sbin/tini -- "$@" --ansi
# check if the first argument passed in matches a known command
else
  set -- /sbin/tini -- composer --ansi "$@"
fi

exec "$@"