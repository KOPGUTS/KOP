#!/bin/sh
DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
export HOME="$DIR/home"
exec "$DIR/bin/opencode" "$@"
