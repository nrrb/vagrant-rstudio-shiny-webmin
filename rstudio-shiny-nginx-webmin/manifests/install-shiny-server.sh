#!/bin/bash
##############
# Shiny Server
##############

# Download and install Shiny server
wget --quiet https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb -O shiny-server-1.5.3.838-amd64.deb
gdebi -n shiny-server-1.5.3.838-amd64.deb
usermod -g rstudio_users shiny

# Create a default ShinyApps folder in the template home folder
mkdir /etc/skel/ShinyApps

# Create a new Shiny configuration file to point to user folders
mv /etc/shiny-server/shiny-server.conf /etc/shiny-server/shiny-server.conf.bak
cat << 'EOF' >> /etc/shiny-server/shiny-server.conf
run_as :HOME_USER:;
sanitize_errors false;
preserve_logs true;

# Define a server that listens on port 3838
server {
  listen 3838 127.0.0.1;

  # Define a location at the base URL
  location / {
    user_dirs;
  }
}
EOF
