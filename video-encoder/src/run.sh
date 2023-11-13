#!/usr/bin/bash

chmod 777 $2
mkdir -p $2
mkdir -p $2

ffmpeg \
  -i $1 \
  -vcodec libx264 \
  -movflags faststart \
  -vprofile baseline \
  -level 3.0 \
  -g 150 \
  -b:v 512k \
  -s 768x432 \
  -acodec aac \
  -b:a 64k \
  -ar 44100 \
  -flags +loop-global_header \
  -map 0 \
  -f segment \
  -segment_format mpegts \
  -segment_time 3 \
  -segment_list $2/playlist.m3u8 $2/v%03d.ts

