#!/bin/bash
apt-get update
# Install package prerequisites
apt-get install -y software-properties-common libapparmor1 libdbd-mysql libmysqlclient-dev \
        libssl-dev python-software-properties upstart psmisc python g++ make vim whois \
        mc libcairo2-dev default-jdk gdebi-core libcurl4-gnutls-dev wget

# Add CRAN Repository
add-apt-repository "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
apt-get update

# Upgrade system
apt-get -y upgrade
apt-get -y autoremove

# For VirtualBox, install host additions
apt-get install -y dkms

# Install R base and packages
apt-get install -y r-base r-base-dev

# Install R packages
Rscript /vagrant/usefulpackages.R

################
# RStudio Server
################

# Download and install RStudio and start service
wget https://download2.rstudio.org/rstudio-server-1.0.143-amd64.deb -O rstudio-server-1.0.143-amd64.deb
gdebi -n rstudio-server-1.0.143-amd64.deb

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
# CHANGEME
echo rstudio:CHANGEME | chpasswd

# Restart the RStudio service to put the new settings into effect
service rstudio-server restart

##############
# Shiny Server
##############

# Download and install Shiny server
wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb
gdebi -n shiny-server-1.5.3.838-amd64.deb
usermod -g rstudio_users shiny

##############
# MySQL Server
##############

# CHANGEME
# http://stackoverflow.com/questions/7739645/install-mysql-on-ubuntu-without-password-prompt
debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password password CHANGEME'
debconf-set-selections <<< 'mysql-server-5.7 mysql-server/root_password_again password CHANGEME'
apt-get -y install mysql-server-5.7

############################
# nginx reverse proxy server
############################
apt-get install -y nginx
rm /etc/nginx/sites-enabled/default
# http://deanattali.com/2015/05/09/setup-rstudio-shiny-server-digital-ocean/
cat << 'EOF' >> /etc/nginx/sites-available/rstudio-shiny
http {
  server {
    listen 80;
    
    location / {
      proxy_pass http://localhost:8787;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection "upgrade";
    }

    location /shiny/ {
        proxy_pass http://localhost:3838;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
  }
}
EOF
ln -s /etc/nginx/sites-available/rstudio-shiny /etc/nginx/sites-enabled/rstudio-shiny
systemctl restart nginx