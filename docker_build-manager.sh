#!/bin/bash

#docker rmi boinc/manager 2>/dev/null
docker pull debian:testing

cd dockerfile_manager
docker build -t boinc/manager .
cd ..

