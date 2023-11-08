#!/bin/bash
TMPBG=$HOME/.tmp/screen.png
LOCK=$HOME/Pictures/i3lock/lock.png
RES=5120x1440 # hard coded this, because it's just faster than asking xrandr for current resolution

# Screengrab and blur
ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "boxblur=4:1,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG
# Lock screen
i3lock -i $TMPBG
# Clean up
rm $TMPBG
