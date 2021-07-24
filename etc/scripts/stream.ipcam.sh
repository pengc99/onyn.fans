#!/bin/bash
#The following configuration includes ffmpeg lenscorrection filter settings for the Amcrest IP5M-T1179EW-28MM IP POE camera

while :
do
  ffmpeg \
    -err_detect ignore_err \
    -vsync 1 \
    -use_wallclock_as_timestamps 1 \
    -fflags +igndts \
    -rtsp_transport tcp \
    -i "rtsp://<username>:<password>@<RTMP source>" \
    -metadata title="" \
    -codec:a aac \
    -ar 16000 \
    -b:a 64k \
    -codec:v libx264 \
    -b:v 960k \
    -profile:v baseline \
    -pix_fmt yuv420p \
    -preset veryfast \
    -filter:v \
      "fps=15, \
      lenscorrection=cx=0.5:cy=0.5:k1=-0.33:k2=0.105:, \
      scale=960:720, \
      drawtext=fontsize=20: box=1: boxcolor=black@0.75: boxborderw=5: fontcolor=white: x=5: y=(h-text_h-5): text='%{localtime\:%m/%d/%Y - %T}'" \
    -g 75 \
    -r 15 \
    -maxrate 1024k \
    -bufsize 5120k \
    -f flv <RTMP endpoint>
  sleep 5
done
