# Use the official ubuntu base image
FROM ubuntu:latest

# Update the package lists
RUN apt-get update

# Install necessary dependencies
RUN apt-get install -y ffmpeg python3 python3-pip

# Install youtube-dl
RUN pip3 install --upgrade youtube-dl

# Copy the local m3u8 file or specify the YouTube video URL
ARG INPUT_FILE
ENV INPUT_FILE="http://playertest.longtailvideo.com/adaptive/wowzaid3/playlist.m3u8"

# Set the RTMP server URL
ARG RTMP_URL
ENV RTMP_URL=${RTMP_URL}

# Set the stream key for the RTMP server
ARG STREAM_KEY
ENV STREAM_KEY=${RTMP_KEY}

# Run the streaming command
CMD ffmpeg -i "$INPUT_FILE" -c:v libx264 -preset veryfast -tune zerolatency -b:v 900k -c:a aac -b:a 128k -f flv "${RTMP_URL}/${STREAM_KEY}"
