#!/bin/bash

# apt-get update  -y && apt-get upgrade -y && apt-get install vsftpd -y

mkdir -p /var/run/vsftpd
mkdir -p /var/run/vsftpd/empty
mkdir -p /home/ftp

set -e  # Exit on any error so we can see what fails


# Your FTP configuration commands here
echo "Setting up FTP configuration..."

whoami


sed -i "s/listen=NO/listen=YES/" /etc/vsftpd.conf
sed -i "s/listen_ipv6=YES/listen_ipv6=NO/" /etc/vsftpd.conf
sed -i "s/#write_enable=YES/write_enable=YES/" /etc/vsftpd.conf



cat >>   /etc/vsftpd.conf << 'EOF'
user_sub_token=root
local_root=/var/www/wordpress
EOF


# cat  /etc/vsftpd.conf 



if  exec vsftpd /etc/vsftpd.conf -obackground=NO  ; then
    echo "All good !"
else
    echo "NADA ! exit status: " $?
fi
