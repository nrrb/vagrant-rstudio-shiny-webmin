#!/bin/bash
##############
# Shiny Server
##############

# Download and install Shiny server
wget --quiet https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb -O shiny-server-1.5.3.838-amd64.deb
gdebi -n shiny-server-1.5.3.838-amd64.deb
usermod -g rstudio_users shiny