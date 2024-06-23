#!/bin/bash

LOCAL_USER=$(whoami)
# update with your actual timezone
TIMEZONE="Etc/UTC"

xhost +local:$LOCAL_USER

# add as a docker launch parameter below if a boinc-client instance 
# is running on the same host as the boinc-manager instance
#-v /opt/appdata/boinc/gui_rpc_auth.cfg:/var/lib/boinc/gui_rpc_auth.cfg \

docker run -ti --rm \
       --name boinc-manager \
       --net=host \
       -h boinc-manager-docker \
       -e DISPLAY \
       -e TZ="$TIMEZONE" \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       -v /opt/appdata/boincmgr:/home/boinc \
       boinc/manager

# ensure the "Run the client?" option is unticked to prevent a
# "Daemon Start Failed" error message on boincmgr startup

xhost -local:$LOCAL_USER

