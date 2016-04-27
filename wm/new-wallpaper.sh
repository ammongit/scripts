#!/usr/bin/env bash
set -eu

SPREAD=bg-fill              # Strategy for displaying wallpapers. See "man feh".
DIR=~/Pictures/Wallpapers   # Wallpaper directory. Section refers to the subdirectory.
SECTION="$(cat /usr/local/scripts/dat/wallpaper_section)"

[[ $# -gt 0 ]] && SECTION="$1"
[[ -n $DISPLAY ]] && export DISPLAY=:0

feh --recursive --randomize --"$SPREAD" "$DIR/$SECTION"

