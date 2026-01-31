#!/usr/bin/bash

record() {
	# -s sets size, :0.0+1920,0 captures only the main monitor
	# -c:v sets the codec, '-c:v h264 -qp 0' would be lossless
	ffmpeg -s 1920x1080 -f x11grab -r 60 -i :0.0+1920,0 -f pulse -ac 2 -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor "$HOME/Documents/Videos/$(date '+%Y-%m-%d_%H:%M:%S').mp4" &
	# write pid to tmp file to check if recording is on if the file exists
	echo $! > /tmp/recpid

	notify-send -t 500 -h string:bgcolor:#181926 "recording"
}

end() {
	kill -15 "$(cat /tmp/recpid)" && rm -f /tmp/recpid

	notify-send -t 500 -h string:bgcolor:#e64553 "recording ended"
}

# if the recording pid file exists, end recording. if not, start recording
([[ -f /tmp/recpid ]] && end && exit 0) || record

