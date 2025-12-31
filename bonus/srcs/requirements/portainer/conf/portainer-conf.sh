# !/bin/bash

# Download the LATEST Portainer binary (2.21.x or newer)
cd /tmp
wget https://github.com/portainer/portainer/releases/download/2.21.4/portainer-2.21.4-linux-amd64.tar.gz

# Extract it
tar xvzf portainer-2.21.4-linux-amd64.tar.gz

# Move to /opt
mv portainer /opt/

# Run Portainer with correct data path
exec /opt/portainer/portainer --data /data