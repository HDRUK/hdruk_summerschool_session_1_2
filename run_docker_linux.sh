#!/bin/bash
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}' )
xhost +

IMAGE='altermeister/hdruk_summerschool_session_1_2'
NAME='hdruk_s2'
FOLDER='/home/<<USER>>/data' # PLEASE CHANGE

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

# try and stop in case it is already running
CMD_STOP="docker stop ${NAME}"
printf "CMD_STOP: $CMD_STOP\n" >&2
ret_stop= eval $CMD_STOP
printf "\n\n"

echo "CMD: $CMD" >&2
ret= eval $CMD
printf "\n\n"

echo "Now start the image using the following command:"
printf "\n"
echo "docker exec -it ${NAME} /bin/bash"


exit $ret
