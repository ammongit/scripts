#!/bin/sh

case "$(/usr/local/scripts/wm/media/detect-audio-player.sh)" in
    mocp) mocp --toggle-pause ;;
    pianobar) printf 'p' > ~/.config/pianobar/ctl ;;
    vlc) dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause ;;
    *) false ;;
esac
