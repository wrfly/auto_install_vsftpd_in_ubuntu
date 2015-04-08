#!/bin/bash
# Via https://www.digitalocean.com/community/tutorials/how-to-configure-vsftpd-to-use-ssl-tls-on-an-ubuntu-vps
#===============================================================================================
#   System Required:  Debian or Ubuntu (32bit/64bit)
#   Description:  Install Vsftpd for Debian or Ubuntu
#   Author: wrfly <mr.wrfly@gmail.com>
#===============================================================================================

clear
echo "#############################################################"
echo "# Install Vsftpd for Debian or Ubuntu (32bit/64bit)"
echo "#"
echo "#                Version 1.0"
echo "#"
echo "#############################################################"
echo ""
sudo -s # Change user to root
apt-get install vsftpd # install vsftpd service
mv /etc/vsftpd.conf /etc/vsftpd.conf.ori # You can delete this file when everything is Ok.
wget 
sudo
add user ftpuser

