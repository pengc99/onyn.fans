  
#!/bin/bash

while :
do
  ffmpeg -vsync 1 -use_wallclock_as_timestamps 1 -fflags +igndts -rtsp_transport tcp -i "rtsp://<username>:<password>@<IP camera streaming URL>" -metadata title="" -codec:a aac -ar 16000 -b:a 64k -codec:v libx264 -b:v 960k -profile:v baseline -pix_fmt yuv420p -preset veryfast -filter:v fps=15 -filter:v scale=1280:720 -filter:V drawtext="fontsize=20: box=1: boxcolor=black@0.75: boxborderw=5: fontcolor=white: x=5: y=(h-text_h-5): text='%{localtime\:%m/%d/%Y - %T}'" -g 75 -r 15 -maxrate 1024k -bufsize 5120k -f flv <RTMP endpoint>
  sleep 5
done
