#!/usr/bin/env bash

# check if the first argument passed in looks like a flag
if [ "$(printf %c "$1")" = '-' ]; then
  set -- /sbin/tini -- laravel --ansi "$@"
# check if the first argument passed in is laravel
elif [ "$1" = 'laravel' ]; then
  set -- /sbin/tini -- "$@" --ansi
# check if the first argument passed in matches a known command
else
  set -- /sbin/tini -- laravel --ansi "$@"
fi

exec "$@"