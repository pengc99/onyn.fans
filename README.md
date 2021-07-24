# onyn.fans

Responsive HLS live streaming page for a webcam. Works on mobile and desktop. Includes manifest as a progressive web app.

The /etc directory contains Docker container configuration files and starter scripts for sending the RTMP push stream to the server, including one script for USB based cameras and one for RTMP based IP cameras. 

Live demo at https://onyn.fans

This script uses several external scripts and resources:
* https://github.com/videojs/video.js
* https://github.com/prateekrastogi/videojs-landscape-fullscreen
* https://hub.docker.com/r/alfg/nginx-rtmp
* http://ffmpeg.org/

***

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.
