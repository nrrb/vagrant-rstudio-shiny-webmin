#!/bin/bash
##############
# MySQL Server
##############
# Creating a random 32-character password for the MySQL root account
pw=`openssl rand -base64 32 2> /dev/null`
echo "Setting MySQL root password to '$pw'."
echo $pw > /root/mysql_root_pw.txt
echo "MySQL root password stored in /root/mysql_root_pw.txt."
# http://stackoverflow.com/questions/7739645/install-mysql-on-ubuntu-without-password-prompt
debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password password $pw"
debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password_again password $pw"
apt-get -y install mysql-server-5.7
