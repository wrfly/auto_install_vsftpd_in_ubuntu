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

sudo apt-get install vsftpd # install vsftpd service

##Download the Config File.
cd /tmp
wget https://codeload.github.com/Wrfly/auto_install_vsftpd_in_ubuntu/zip/master
unzip master
rm master
cd auto_install_vsftpd_in_ubuntu-master/

sudo mv /etc/vsftpd.conf ./vsftpd.conf.bak # You can delete this file when everything is Ok.
sudo cp vsftpd.conf /etc/vsftpd.conf

#Create an FTP User
read -p "Please Enter an Ftp User name:" ftpuser
sudo useradd $ftpuser
sudo chown root:root /home/$ftpuser

sudo mkdir /home/$ftpuser/files
sudo chown $ftpuser:$ftpuser /home/$ftpuser/files

#Configure SSL with vsftpd
sudo cp vsftpd.pem /etc/ssl/private/vsftpd.pem

sudo service vsftpd restart

##
# How To Connect to the Server with FileZilla

# Most modern FTP clients can be configured to use SSL and TLS encryption. We will be demonstrating how to connect using FileZilla due to its cross platform support.

# In the configuration panel, you should see a button on the far left to open "Site Manager". Click this:

# FileZilla Open Site Manager

# Click on "New Site" in the bottom right corner of the window interface that appears:

# FileZilla New Site

# Name the new configuration. Fill out the IP address. Under the "Encryption" drop down menu, select "Require explicit FTP over TLS".

# For "Logon Type", select "Normal". Fill in the ftp user you created in the "User" field, and also the password.

# Click "Connect" at the bottom of the interface.

# You will be asked to accept the TLS certificate:

# Just click "Accept".

# You should now be connected with your server with TLS/SSL encryption.

#Enjoy it !
##
