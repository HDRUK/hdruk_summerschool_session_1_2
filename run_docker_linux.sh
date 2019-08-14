#!/bin/bash
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}' )
xhost +

IMAGE='altermeister/hdruk_summerschool_session_1_2'
NAME='hdruk_s12'
FOLDER='/home/<user_name>/data'

# This command will start the container on background mode
CMD="docker run \
    --rm -d \
    --privileged \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -e DISPLAY=unix$DISPLAY \
    --device /dev/dri \
    --name $NAME \
    -v $FOLDER/:/Data/:rw \
    -ti $IMAGE
"

echo "CMD: [$CMD]" >&2
ret= eval $CMD
exit $ret
