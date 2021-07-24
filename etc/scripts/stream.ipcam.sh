#!/bin/bash
#The following configuration includes a few interesting ffmpeg commands
# The Amcrest IP5M-T1179EW-28MM outputs really poorly formed h.264 video and AAC audio, so we instruct ffmpeg to ignore errors and substitute in duplicated data frames
# We can then rebuild the audio stream with a new dts; I don't think there's much we can do with the video data
# For some reason ffmpeg also has problems ingesting UDP RTMP video, so we force ffmpeg to ingest as TCP
# The Amcrest IP5M-T1179EW-28MM also doesn't do true 16:9 video - if you select a 16:9 resolution the camera just stretches the 4:3 sensor output - we crop the top and bottonm to 16:9
# Finally, the Amcrest IP5M-T1179EW-28MM has some pretty bad lens distortion, so we use the lenscorrection filter to correct it

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
