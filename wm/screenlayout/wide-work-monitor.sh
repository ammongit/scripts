#!/bin/bash
set -eu

/usr/local/scripts/wm/new-wallpaper.sh

exec xrandr \
	--output eDP1 \
		--primary \
		--mode 1920x1080 \
		--pos 0x536 \
		--rotate normal \
	--output DP1 \
		--off \
	--output DP2 \
		--off
	--output DP1-1 \
		--off \
	--output DP1-2 \
		--mode 2560x1080 \
		--pos 1920x0 \
		--rotate normal \
	--output DP1-3 \
		--off \
	--output HDMI1 \
		--off \
	--output VIRTUAL1 \
		--off
