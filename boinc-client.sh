#!/bin/bash

# update with your actual timezone
TIMEZONE="Etc/UTC"
# required to allow inbound boinc-manager connections
CLIENT_OPTIONS="--allow_remote_gui_rpc"
# specify a password for inbound boinc-manager connections
CLIENT_PASSWORD="CHANGEME"

if [ $# -ge 1 ]
then
    docker stop boinc-client 2>/dev/null
    docker rm boinc-client 2>/dev/null
    ./docker_build-client.sh $1
else
    echo "No client architecture specified!"
    exit 1
fi

### x64 (CPU only) ###
if [ $1 == "x64" ]
then
    docker run -d \
           --name boinc-client \
           --net=host \
           -v /opt/appdata/boinc:/var/lib/boinc \
           -e TZ="$TIMEZONE" \
           -e BOINC_GUI_RPC_PASSWORD="$CLIENT_PASSWORD" \
           -e BOINC_CMD_LINE_OPTIONS="$CLIENT_OPTIONS" \
           boinc/client:x64
### arm64v8 ###
elif [ $1 == "arm64" ]
then
    docker run -d \
           --name boinc-client \
           --net=host \
           -v /opt/appdata/boinc:/var/lib/boinc \
           -e TZ="$TIMEZONE" \
           -e BOINC_GUI_RPC_PASSWORD="$CLIENT_PASSWORD" \
           -e BOINC_CMD_LINE_OPTIONS="$CLIENT_OPTIONS" \
           boinc/client:arm64v8
### x64 + Nvidia GPU ###
elif [ $1 == "nvidia" ]
then
    docker run -d \
           --name boinc-client \
           --gpus all \
           --net=host \
           -v /opt/appdata/boinc:/var/lib/boinc \
           -e TZ="$TIMEZONE" \
           -e BOINC_GUI_RPC_PASSWORD="$CLIENT_PASSWORD" \
           -e BOINC_CMD_LINE_OPTIONS="$CLIENT_OPTIONS" \
           boinc/client:nvidia
else
    echo "Invalid option!"
    exit 2
fi

