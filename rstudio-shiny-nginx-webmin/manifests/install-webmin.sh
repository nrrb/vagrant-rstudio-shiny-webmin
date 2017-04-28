#!/bin/bash
########
# Webmin
########
wget --quiet https://sourceforge.net/projects/webadmin/files/webmin/1.831/webmin_1.831_all.deb -O webmin_1.831_all.deb
gdebi -n webmin_1.831_all.deb
##############################
# Create admin user for Webmin
##############################
pw=`openssl rand -base64 32 2> /dev/null`
useradd -d /home/kis -m -G sudo -s /bin/false kis
echo kis:$pw | chpasswd
echo $pw > /root/kis_pw.txt
echo "Created user account 'kis' for Webmin access with password '$pw'."
echo "This password is also stored in /root/kis_pw.txt."