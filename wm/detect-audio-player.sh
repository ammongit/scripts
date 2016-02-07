#!/bin/sh

detect_mocp() {
    case "$(mocp --info 2>&1 | grep State)" in
        'State: PLAY') return 0 ;;
        'State: PAUSE') return 0 ;;
        'State: STOP') return 1 ;;
        *) return 1 ;;
    esac
}

detect_vlc() {
    case "$(qdbus org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player PlaybackStatus)" in
        'Playing') return 0 ;;
        'Paused') return 0 ;;
        'Stopped') return 1 ;;
        *) return 1 ;;
    esac
}

detect_pianobar() {
    pgrep -U "$UID" pianobar > /dev/null
}

if detect_pianobar; then
    printf "pianobar"
elif detect_mocp; then
    printf "mocp"
elif detect_vlc; then
    printf "vlc"
else
    printf "(unknown)"
fi

