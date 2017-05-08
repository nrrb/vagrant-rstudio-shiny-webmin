#!/bin/bash
################
# RStudio Server
################

# Download and install RStudio and start service
wget https://download2.rstudio.org/rstudio-server-pro-1.0.143-amd64.deb
sudo gdebi -n rstudio-server-pro-1.0.143-amd64.deb

# Config RStudio Server
# https://gabrielebaldassarre.com/2015/07/07/how-to-install-rstudio-server-in-a-production-ready-ubuntu-environment/
cat << 'EOF' >> /etc/rstudio/rserver.conf
rsession-memory-limit-mb=4000
rsession-stack-limit-mb=10
rsession-process-limit=50
www-address=127.0.0.1
auth-required-user-group=rstudio_users
EOF
# https://support.rstudio.com/hc/en-us/articles/200552316-Configuring-the-Server
cat << 'EOF' >> /etc/rstudio/rsession.conf
session-timeout-minutes=30
EOF

# Create rstudio_users group
groupadd rstudio_users

# Create a basic access user account
useradd -d /home/rstudio -m -g rstudio_users -s /bin/false rstudio
################################
# Create default rstudio account
################################
pw=`openssl rand -base64 32 2> /dev/null`
echo "Creating default rstudio account 'rstudio' with password '$pw'."
echo rstudio:$pw | chpasswd
echo $pw > /root/rstudio_pw.txt
echo "This password can also be found in /root/rstudio_pw.txt."

# Restart the RStudio service to put the new settings into effect
service rstudio-server restart

