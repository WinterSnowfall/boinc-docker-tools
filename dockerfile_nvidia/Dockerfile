FROM debian:testing

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

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
# Install pre-requisite packages
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates gpg && \
# Setup apt sources for nvidia-container-toolkit
    curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && \
    curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
        sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
        tee /etc/apt/sources.list.d/nvidia-container-toolkit.list && \
# Install Time Zone Database
    apt-get update && apt-get install -y --no-install-recommends tzdata \
# Install Nvidia Container Toolkit
    nvidia-container-toolkit \
# Install OpenCL loader libraries
    ocl-icd-libopencl1 \
# Install BOINC Client
    boinc-client && \
# Configure Nvidia OpenCL
    mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd && \
# Clear pre-requisite packages and apt configurations
    apt-get remove -y curl gpg && \
    apt-get autoremove -y && \
    rm -rf /etc/apt/sources.list.d/nvidia-container-toolkit.list \
           /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg

USER boinc

CMD ["start-boinc.sh"]

