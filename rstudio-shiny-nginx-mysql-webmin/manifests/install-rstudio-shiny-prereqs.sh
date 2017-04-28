#!/bin/bash
#################################
# RStudio and Shiny Prerequisites
#################################
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

