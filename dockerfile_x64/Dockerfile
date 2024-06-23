FROM debian:testing

# Global environment settings
ENV BOINC_GUI_RPC_PASSWORD="CHANGEME" \
    BOINC_REMOTE_HOST="127.0.0.1" \
    BOINC_CMD_LINE_OPTIONS="" \
	DEBIAN_FRONTEND=noninteractive

# Copy files
COPY bin/ /usr/bin/

# Set workdir
WORKDIR /var/lib/boinc

# BOINC RPC port
EXPOSE 31416

# Create the boinc user
RUN useradd -m boinc \
    && chmod 777 /home/boinc
# Install Time Zone Database
RUN apt-get update && apt-get install -y --no-install-recommends tzdata \
# Install BOINC Client
    boinc-client

USER boinc

CMD ["start-boinc.sh"]

