#!/bin/bash

#docker rmi boinc/manager 2>/dev/null
docker pull debian:testing

cd dockerfile-manager
docker build -t boinc/manager .
cd ..

