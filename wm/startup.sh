#!/bin/sh
set -eu

dir_make() {
	for dir in "$@"; do
		mkdir -m700 -p "/tmp/$USER/$dir"
	done
}

mkdir -m750 "/tmp/$USER"
dir_make cache
dir_make mutt/{headers,bodies}
dir_make pacaur
dir_make vim_undo
exec /usr/local/scripts/wm/vi-keyswap.sh

