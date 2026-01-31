#!/usr/bin/bash

FOLDER=/mnt/2tb/torrents/

playvideo() { \
	NAME="$(echo "$(command ls -R $FOLDER | grep '.mp4\|.mov\|.mkv\|.webm')" | dmenu -i -c -l 15)" || exit 0
	NAME="$(echo $NAME | sed 's/[[]/\\[/g' | sed 's/[]]/\\]/g')"
	echo $NAME
	LOCATION="$(find $FOLDER -name "$(echo $NAME)" 2>/dev/null)"
	echo $LOCATION
	mpv "$LOCATION" #>/dev/null 2>&1
}

playvideo
