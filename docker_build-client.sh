#!/bin/bash

if [ $# -ge 1 ]
then
    # x64 (CPU only)
    if [ $1 == "x64" ]
    then
        echo "Updating docker base image (x64)..."
        docker pull debian:testing
        cd dockerfile_x64
        docker build -t boinc/client:x64 -f Dockerfile .
    # arm64v8
    elif [ $1 == "arm64" ]
    then
        echo "Updating docker base image (arm64)..."
        docker pull arm64v8/debian:testing
        cd dockerfile_arm64v8
        docker build -t boinc/client:arm64v8 -f Dockerfile .
    # x64 + Nvidia GPU
    elif [ $1 == "nvidia" ]
    then
        echo "Updating docker base image (nvidia)..."
        docker pull debian:testing
        cd dockerfile_nvidia
        docker build -t boinc/client:nvidia -f Dockerfile .
    else
        echo "Invalid option!"
        exit 2
    fi
else
    echo "No client architecture specified!"
    exit 1
fi

cd ..

