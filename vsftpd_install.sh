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

echo "What can I do for you, sir?"
echo ""
echo "Install vsftpd service(1)?"
echo "Add a ftpuser(2)?"
echo "Remove vsftpd service(3)?"
echo "Or delete a ftpuser(4)?"
read choice

case "$choice" in
	1)
type vsftpd >/dev/null 2>&1 && { echo >&2 "It seems that you have allready installed vsftpd, Aborting."; exit 0; }

sleep 1 # Just for fun.

echo "Please wait for a minute to install vsftpd, don't warry, everything will be okay."

sudo apt-get install vsftpd > install.log # install vsftpd service

echo "Install complete."

sleep 1

#Config vsftpd service
mkdir tmp
sudo mv /etc/vsftpd.conf tmp/vsftpd.conf.bak # You can delete this file if everything is Ok.
sudo cp vsftpd.conf /etc/vsftpd.conf

#Create an FTP User
echo "#############################################################"
echo "#####                Ftp user name needed                ####"
echo "#############################################################"

read -p "Please Enter an Ftp User name:" ftpuser

sudo useradd $ftpuser

sudo passwd $ftpuser

sudo mkdir  -p /home/$ftpuser/files

sudo chown root:root /home/$ftpuser

sudo chown $ftpuser:$ftpuser /home/$ftpuser/files

#Configure SSL with vsfrtpd
read -p "Now, we will configure SSL with vsftpd \
Do you want use a default certificates or create some SSL certificates yourself(y/n)?" y_n;
if [[ $y_n -eq y || $y_n -eq Y ]]; then
	sudo cp vsftpd.pem /etc/ssl/private/vsftpd.pem
else
	sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
fi


sudo service vsftpd restart

echo "Vsftpd service installed succussfully!" -n
read -p "Do you know how to connect to the server with FileZilla?(y-to show details, n-to skip)" y_n
if [[ $y_n -eq y || $y_n -eq Y ]]; then
	clear
	echo "
##
# How To Connect to the Server with FileZilla

# Most modern FTP clients can be configured to use SSL and TLS encryption. 

# We will be demonstrating how to connect using FileZilla due to its cross platform support.

# In the configuration panel, you should see a button on the far left to open \"Site Manager\". Click this:

# FileZilla Open Site Manager

# Click on \"New Site\" in the bottom right corner of the window interface that appears:

# FileZilla New Site

# Name the new configuration. Fill out the IP address. Under the \"Encryption\" drop down menu, select \"Require explicit FTP over TLS\".

# For \"Logon Type\", select \"Normal\". Fill in the ftp user you created in the \"User\" field, and also the password.

# Click \"Connect\" at the bottom of the interface.

# You will be asked to accept the TLS certificate:

# Just click \"Accept\".

# You should now be connected with your server with TLS/SSL encryption.

# Enjoy it !
##
"
else
	exit 0
fi
		;;
	2)
read -p "Please Enter an Ftp User name:" ftpuser

sudo useradd $ftpuser

sudo passwd $ftpuser

sudo mkdir  -p /home/$ftpuser/files

sudo chown root:root /home/$ftpuser

sudo chown $ftpuser:$ftpuser /home/$ftpuser/files
;;
	3)
sudo apt-get remove vsftpd
;;
	4)
read -p "Please Enter an Ftp User name:" ftpuser
sudo userdel $ftpuser
cp /home/$ftpuser/ /home/ftpuser_file_del
rm -rf /home/$ftpuser
;;
	default)
	echo "Nothing changed."
	exit 0;
esac