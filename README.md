# boinc-docker-tools

Various scripts and tooling around building and running BOINC client and BOINC manager in docker containers based on Debian Testing. The following flavors are currently supported:
- boinc-client x64
- boinc-client arm64v8
- boinc-ciient x64 + nvidia (CUDA & OpenCL)
- boinc-manager x64

## What do I need?

Docker and dependencies (containerd, runc etc.), in whatever form it comes with your distro. As a note, on Debian and friends the docker package is very intuitively called `docker.io`.

## How do I use these things?

* After installing docker you'll need to add your user to the docker group.
  
    `sudo usermod -aG docker <your_username>`
  
    Will do the trick, afterwards you'll need a restart of the docker demon (or your system).

* Secondly, you need to make sure all the .sh scripts have their execute permissions set, otherwise nothing will work. Note that execute permissions also need to be added to the scripts that are in the `bin` folders.

* Now you're set to fetch the latest Debian Testing docker image and construct containers on an architecture of your choice. To do that simply run:
  
    `docker_build-client.sh <architecture>`

    For the boinc-client, where `<architecture>` can be either x64, arm64v8 or nvidia. Alternatively, for boinc-manager, simply run:

    `docker_build-manager.sh`

    Note that you do not need to explicitly run `docker_build-client.sh` if you intend to use the below startup scripts, as in the case of boinc-client the runner script will (re)build the container for you.

* Sample scripts have been provided for launching the above containers, namely a persistent container for boinc-client and a perishable one for boinc-manager. Please inspect these scripts and adjust startup variables as needed, such as `TIMEZONE` and `CLIENT_PASSWORD`, then run:
  
    `boinc-client.sh <architecture>`

    To rebuild and start the boinc-client container, where `<architecture>` can be either x64, arm64v8 or nvidia. Respectively:

    `boinc-manager.sh`

    To start the boinc-manager container.

    Note that for boinc-manager the "Run the client?" option needs to be unticked in order to prevent a "Daemon Start Failed" error message on startup.
