#!/bin/bash

while :
do
        ffmpeg -framerate 30 -video_size 800x600 -input_format mjpeg -i /dev/video0 -vcodec libx264 -b:v 1024k -r 30 -g 30 -profile:v baseline -pix_fmt yuv420p -preset veryfast -vf drawtext="fontsize=20: box=1: boxcolor=black@0.75: boxborderw=5: fontcolor=white: x=5: y=(h-text_h-5): text='%{localtime\:%m/%d/%Y - %T}'" -f flv <RTMP endpoint>
        sleep 5
done
