#!/bin/bash


# Download the latest Portainer binary
cd /tmp
wget https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz

# Extract it
tar xvzf portainer-2.19.4-linux-amd64.tar.gz

# Move to /opt
mv portainer /opt/

# Create data directory
mkdir -p /opt/portainer/data

# Run Portainer
/opt/portainer/portainer --data /opt/portainer/data
