#!/bin/bash
apt-get update

sh install-rstudio-shiny-prereqs.sh
sh install-rstudio-server-pro.sh
sh install-shiny-server-pro.sh
sh install-mysql-server.sh
sh install-nginx.sh
sh install-webmin.sh
