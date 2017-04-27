#!/bin/bash
apt-get update

sh install-rstudio-shiny-prereqs.sh
sh install-rstudio-server.sh
sh install-shiny-server.sh
sh install-mysql-server.sh
sh install-nginx.sh
sh install-webmin.sh