#!/bin/bash

# Description : Script to convert RHEL 7 to CentOS 7  
# Author : Harshil Jethava
# Version : 0.1 (beta)
# Date : 05-05-2017
# Email : harshiljethava7atgmaildotcom
# Site : http://harshiljethava.github.io
# License : GNU GPL v3.0
echo 	'''
>_ Migrating RHEL 7 to CentOS  7 ...
>_ Please note that rpm versions keep changing with every package update and might be out of date. 
   So please go to below link and copy latest version package link

>_ [LINK] http://mirror.centos.org/centos/7/os/x86_64/Packages/
	'''
version_check=`awk 'END{print $1}' /etc/*release`
#echo $version_check
if [ $version_check == "CentOS" ] ;
then
	echo ">_ Finding Red Hat Enterprise Linux packages ..."
	redhat_package=`rpm -qa|egrep "rhn|redhat"`
	echo ">_ Press Y/n to remove red hat related packages/dependencies..."
	echo $redhat_package
	read rdp_option
	if [ $rdp_option == 'Y' ] || [ $rdp_option == 'y' ] || [ $rdp_option == 'yes' ] || [ $rdp_option == 'YES' ];then
		echo ">_ Removing Red Hat Enterprise Linux packages..."
		rdp_remove=`yum remove rhnlib redhat-support-tool redhat-support-lib-python >> ~/rhel_centos_conv.log`
		
		###############
		if [ $? -eq 0 ];
		then
			rpm_remove=`rpm -e --nodeps redhat-release-server redhat-logos yum`
			echo ">_ [INFO] Red Hat related packaged removed successfully..."
		else
			echo ">_ [ERROR] Red Hat related packages not removed...\n For more details please see ~/rhel_centos_conv.log"
			exit 1
		fi

		###############
		if [ $?  -eq 0 ];
		then
			echo ">_Removing Red Hat related documents... "
			doc_remove=`rm -rf /usr/share/doc/redhat-release/ /usr/share/redhat-release/`
			echo ">_ [INFO] Redhat related documents removed successfully..."
		else
			echo ">_ [ERROR] Redhat related documents not removed...\nFor more details please see ~/rhel_centos_conv.log"			     
			exit 1
		fi

		if [ $? -eq 0 ];
		then
			temp_dir=`mkdir temp && cd temp`
			rpm_key=`curl -O http://mirror.centos.org/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-7`
			python_urlgrabber=`curl -O http://mirror.centos.org/centos/7/os/x86_64/Packages/python-urlgrabber-3.10-8.el7.noarch.rpm`
			yum_plugin=`curl -O http://mirror.centos.org/centos/7/os/x86_64/Packages/yum-plugin-fastestmirror-1.1.31-40.el7.noarch.rpm`
			centos_logo=`curl -O http://mirror.centos.org/centos/7/os/x86_64/Packages/centos-logos-70.0.6-3.el7.centos.noarch.rpm`
			centos_release=`curl -O http://mirror.centos.org/centos/7/os/x86_64/Packages/centos-release-7-3.1611.el7.centos.x86_64.rpm`
			
			echo ">_ Installing CenOS 7 RPM-GPG Key..."
			rpm_key_install=`rpm --import RPM-GPG-KEY-CentOS-7`
			echo "\n>_ [INFO] CentOS 7 RPM-GPG-Key installed successfully..."
			
			echo ">_ Installing downloaded packages..."
			rpm_pack_install=`rpm -Uvh *.rpm`
			echo ">_ [INFO] Packages installed successfully..."
			
			echo "\n>_ Cleaning yum repo..."
			yum_clean=`yum clean`
			
			echo "\n>_ Updating yum repo..."
			yum_update=`yum update`
			
			echo ">_Updating grub2 config file..."
			grub_update=`grub2-mkconfig -o /boot/grub2/grub.cfg`
			echo ">_ [INFO] grub updated successfully..."
			
			echo "\n\n>_ [INFO] RHEL 7 to CentOS converted successfully...\nPlease restart the system to apply the changes..."		
	else
		echo ">_ [ERROR] Invalid Option...\nTerminating...."
	fi
else
	echo "\n>_ Current OS is not Red Hat Enterprise Linux\nTerminating... "
	exit 1
fi
