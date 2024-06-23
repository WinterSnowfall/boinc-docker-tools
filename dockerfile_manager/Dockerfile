FROM debian:testing

# Global environment settings
ENV BOINC_CMD_LINE_OPTIONS="" \
	DEBIAN_FRONTEND=noninteractive

# Set workdir
WORKDIR /var/lib/boinc

# Create the boinc user
RUN useradd -m boinc \
    && chmod 777 /home/boinc
# Install Time Zone Database
RUN apt-get update && apt-get install -y --no-install-recommends tzdata \
# Install BOINC Manager
    boinc-manager

USER boinc

CMD ["/usr/bin/boincmgr"]

