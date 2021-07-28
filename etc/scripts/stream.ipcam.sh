#!/bin/bash
#The following configuration includes a few interesting ffmpeg commands
# The Amcrest IP5M-T1179EW-28MM also doesn't do true 16:9 video - if you select a 16:9 resolution the camera just stretches the 4:3 sensor output - we crop the top and bottonm to 16:9
# Finally, the Amcrest IP5M-T1179EW-28MM has some pretty bad lens distortion, so we use the lenscorrection filter to correct it

while :
do
  ffmpeg \
    -hide_banner \
    -thread_queue_size 512 \
    -fflags +discardcorrupt \
    -i "rtsp://<username>:<password>@<RTMP source>" \
    -metadata title="" \
    -codec:v libx264 \
    -b:v 512k \
    -profile:v baseline \
    -pix_fmt yuv420p \
    -preset medium \
    -filter:v \
      "fps=15, \
      lenscorrection=cx=0.5:cy=0.5:k1=-0.33:k2=0.105:, \
      crop=iw:iw*9/16, \
      scale=1280:720, \
      drawtext=fontsize=20: box=1: boxcolor=black@0.75: boxborderw=5: fontcolor=white: x=5: y=(h-text_h-5): text='%{localtime\:%m/%d/%Y - %T}', \
    freezedetect" \
    -g 75 \
    -r 15 \
    -maxrate 512k \
    -bufsize 2560k \
    -an \
    -f flv <RTMP endpoint>
  sleep 5
done
