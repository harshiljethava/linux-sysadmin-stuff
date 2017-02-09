#!/bin/bash

# Description : This script will help you to do automate essential tasks of zabbix 3.2  
# Author : Harshil Jethava
# Version : 0.1
# Date : 10-02-2017
# Email : harshiljethava7atgmaildotcom
# Site : http://harshiljethava.github.io
# License : GNU GPL v3.0

echo '''>_ Please select options 
	
	1) check status of zabbix_server 
	2) check status of zabbix_agentd 
	3) start  zabbix_server service 
	4) start zabbix_agentd service 
	5) stop  zabbix_server service 
	6) stop zabbix_agentd service
	7) Change parameters of  /etc/zabbix_server.conf file  
	8) Change parameters of  /etc/zabbix_agentd.conf file 
	9) Display logs of zabbix_server 
	10) Display logs of zabbix_agentd
	11) Check queue count of server 
	12) Start MariaDB server
	13) Start Apache server 
	14) Check status of MariaDB server
	15) Check status of Apache server
	16) Stop MariaDB server
	17) Stop Apache server
 	18) Backup zabbix server
	19) scp zabbix database to remote server
	20) check and update yum repo'''

GREEN='\033[0;32m'


while [ $options ]
echo -e "\n\n>_ Please select option ... Press Ctrl+C to exit"
read options
do
	echo -e ">_ Are you using RHEL/CentOS 7.x ? [Y/n] "
	read version
	
	if [ $version == 'Y' ] || [ $version == 'y' ] || [ $version == 'yes' ] || [ $version == 'YES' ];then

	
		if [ $options -eq 1 ]; then
				echo -e "${GREEN}>_ Checking status of zabbix-server... ${GREEN}"	
				zbx_ser_stu='systemctl status zabbix-server'
				eval $zbx_ser_stu 2> /dev/null
				echo ""
		
		# ========================================================================== #
		
		elif [ $options -eq 2 ]; then
                echo -e "${GREEN}>_ Checking status of zabbix-agentd..."
                zbx_agt_stu='systemctl status zabbix-agent'
                eval $zbx_agt_stu

        elif [ $options -eq 3 ]; then
			echo -e "${GREEN}>_ Starting zabbix_server... ${GREEN}\n"
            zbx_ser_str='systemctl start zabbix-server'
            eval $zbx_ser_str 2> /dev/null

		# ========================================================================== #

        elif [ $options -eq 4 ]; then
            echo -e "${GREEN}>_ Starting zabbix_agentd... ${GREEN}\n"
            zbx_agt_str='systemctl start zabbix-agent'
            eval $zbx_agt_str 2> /dev/null
			
		# ========================================================================== #

		elif [ $options -eq 5 ]; then
			echo -e "${GREEN}>_ Stopping zabbix_server... ${GREEN}\n"
            zbx_ser_stp='systemctl stop zabbix-server'
            eval $zbx_ser_stp 2> /dev/null
		
		# ========================================================================== #

        elif [ $options -eq 6 ]; then
            echo -e "${GREEN}>_ Stopping zabbix_agentd... ${GREEN}\n"
            zbx_agt_stp='systemctl stop zabbix-agent'
            eval $zbx_agt_stp 2> /dev/null

        # ========================================================================== #

        elif [ $options -eq 7 ]; then
            echo -e "${GREEN}>_ Which parameter you want to change in /etc/zabbix/zabbix_server.conf ?? ${GREEN}\n"
            echo '''
			1) ListenPort
			2) SourceIP
			3) LogFile
			4) LogFileSize
			5) DebugLevel
			6) PidFile
			7) StartVMwareCollectors 
			8) VMwarePerfFrequency
			9) VMwareFrequency
			10) VMwareCacheSize
			11) VMwareTimeout
			12) Timeout '''
			read opt_zbx_ser
            eval $zbx_ser_parm 2> /dev/null

        # ========================================================================== #

        elif [ $options -eq 8 ]; then
        	echo -e "${GREEN}>_ Which parameter you want to change in /etc/zabbix/zabbix_agentd.conf ?? ${GREEN}\n"
        	echo '''
                        1) PidFile
                        2) LogFile
                        3) LogFileSize
                        4) DebugLevel
                        5) EnableRemoteCommands
                        6) LogRemoteCommands
                        7) Server & ServerActive
                        8) ListenPort
                        9) ListenIP
                        10) StartAgents
                        11) ServerActive
                        12) Hostname '''
			read opt_zbx_agt
        	eval $zbx_agt_stp 2> /dev/null
        else
        	$options 2> /dev/null
			echo -e "INVALID OPTIONS !!! Please run again script &  select appropriate options "
			exit 1
		fi
		
		# ========================================================================== #

	elif [ $version == 'N' ] || [ $version == 'n' ] || [ $version == 'no' ] || [ $version == 'NO' ];then

		if [ $options -eq 1 ]; then
			echo -e "${GREEN}>_ Checking status of zabbix-server... ${GREEN}" 
			zbx_ser_stu='ps -ef | grep -i zabbix_server'
			eval $zbx_ser_stu 2> /dev/null
	
		# ========================================================================== #
		
		elif [ $options -eq 2 ]; then
			echo -e "${GREEN}>_ Checking status of zabbix-agentd... ${GREEN}\n"
            zbx_agt_stu='ps -ef | grep -i zabbix_agentd'
			eval $zbx_agt_stu 2> /dev/null

		# ========================================================================== #

		elif [ $options -eq 3 ]; then
			echo -e "${GREEN}>_ Starting zabbix_server... ${GREEN}\n"
            zbx_ser_str='/usr/sbin/zabbix_server -c /etc/zabbix/zabbix_server.conf'
            eval $zbx_ser_str 2> /dev/null                
		
		# ========================================================================== #

        elif [ $options -eq 4 ]; then
            echo -e "${GREEN}>_ Starting zabbix_agentd... ${GREEN}\n"
            zbx_agt_str='/usr/sbin/zabbix_agentd -c /etc/zabbix/zabbix_agentd.conf'
            eval $zbx_agt_str 2> /dev/null
			
		# ========================================================================== #

		elif [ $options -eq 5 ]; then
			echo -e "${GREEN}>_ Stopping zabbix_server... ${GREEN}\n"
            zbx_ser_stp='killall zabbix_server'
            eval $zbx_ser_stp 2> /dev/null
		
		# ========================================================================== #

        elif [ $options -eq 6 ]; then
            echo -e "${GREEN}>_ Stopping zabbix_agentd... ${GREEN}\n"
            zbx_agt_stp='killall zabbix_agentd'
            eval $zbx_agt_stp 2> /dev/null

		# ========================================================================== #

        elif [ $options -eq 7 ]; then
            echo -e "${GREEN}>_ Which parameter you want to change in /etc/zabbix/zabbix_server.conf ?? ${GREEN}\n"
            echo '''
			1) ListenPort
			2) SourceIP
			3) LogFile
			4) LogFileSize
			5) DebugLevel
			6) PidFile
			7) StartVMwareCollectors 
			8) VMwarePerfFrequency
			9) VMwareFrequency
			10) VMwareCacheSize
			11) VMwareTimeout
			12) Timeout '''
			read opt_zbx_ser
            eval $zbx_ser_parm 2> /dev/null

        # ========================================================================== #

        elif [ $options -eq 8 ]; then
        	echo -e "${GREEN}>_ Which parameter you want to change in /etc/zabbix/zabbix_agentd.conf ?? ${GREEN}\n"
        	echo '''
                        1) PidFile
                        2) LogFile
                        3) LogFileSize
                        4) DebugLevel
                        5) EnableRemoteCommands
                        6) LogRemoteCommands
                        7) Server & ServerActive
                        8) ListenPort
                        9) ListenIP
                        10) StartAgents
                        11) ServerActive
                        12) Hostname '''
			read opt_zbx_agt
        	eval $zbx_agt_stp 2> /dev/null
               
		# ========================================================================== #

        elif [ $options -eq 9 ]; then
            echo -e "${GREEN}>_ Displaying log(s)  of zabbix_server${GREEN}\n"
            zbx_ser_log='/tmp/zabbix_server.log'
            eval $zbx_ser_log

		# ========================================================================== #

        elif [ $options -eq 10 ]; then
            echo -e "${GREEN}>_ Displaying logs(s) of zabbix_agentd${GREEN}\n"
            zbx_agt_log='/tmp/zabbix_agentd.log'
            eval $zbx_agt_log 2> /dev/null

        # ========================================================================== #

        elif [ $options -eq 11 ]; then
        	echo -e "queue count of zabbix server is : "
        	queue_count = "mysql -u root -p -e 'mysql query'"
        	eval $queue_count
        
      	# ========================================================================== #

        elif [ $options -eq 12 ]; then
        	echo -e "Starting MariaDB server... "
        	mdb_str = "/etc/init.d/mysqld start"
        	eval $mdb_str

        # ========================================================================== #

        elif [ $options -eq 13 ]; then
        	echo -e "Starting Apache server ... "
        	apache_str = "/etc/init.d/httpd  start"
        	eval $apache_str

        # ========================================================================== #

        elif [ $options -eq 14 ]; then
        	echo -e "Checking status of MariaDB server... "
        	mdb_stu = "/etc/init.d/mysqld status"
        	eval $mdb_stu

        # ========================================================================== #

        elif [ $options -eq 15 ]; then
        	echo -e "Checking status of Apache server... "
        	apache_stu = "/etc/init.d/httpd start status"
        	eval $apache_stu

       	# ========================================================================== #

        elif [ $options -eq 16 ]; then
        	echo -e "Stopping MariaDB server... "
        	mdb_stp = "/etc/init.d/mysqld stop"
        	eval $mdb_stp

        # ========================================================================== #

        elif [ $options -eq 17 ]; then
        	echo -e "Stopping Apache server... "
        	apache_stp = "/etc/init.d/httpd stop"
        	eval $apache_stp

        # ========================================================================== #

        elif [ $options -eq 18 ]; then
        	DATE=`date +%Y%m%d%T`
        	echo -e ">_ Backup zabbix server ... "
        	echo -e ">_ Enter MariaDB user"
        	read mdb_user
        	#echo -e "Enter MariaDB password"
        	#read mdb_passwd
        	echo -e ">_ Enter absolute path to store zabbix backup file(s)"
        	read bak_path
        	zbx_db='zabbix'
        	printf ">_ For user $mdb_user "
        	zbx_db_bak='mysqldump -u $mdb_user -p $mdb_passwd --databases  $zbx_db >> $bak_path/zabbix-bak_$DATE.sql'
        	echo -e ">_ BE PATIENT !!! Creating backup of Zabbix database on $bak_path ... "
        	eval $zbx_db_bak
        	echo -e ">_ Backup File : $bak_path/zabbix-bak_$DATE.sql"
  	      	echo -e ">_ Zabbix database backup created Successfully !!!"

 		# ========================================================================== #

        elif [ $options -eq 19 ]; then    	
      		echo -e ">_ Securely copying local zabbix database to remote server ..."
      		echo -e ">_ Enter local zabbix database file name with absolute path"
      		read local_zbx_db  
      		echo ">_ Enter remote server ip/Hostname"
      		read remote_host
      		echo ">_ Enter remote user"
      		read remote_user
      		echo ">_ Enter remote server path to store zabbix database file"
      		read remote_path
      		zbx_scp="scp $local_zbx_db $remote_user@$remote_host:$remote_path"
      		eval $zbx_scp
      		echo ">_ Zabbix database file has been copied to $remote_path on $remote_host"

      	# ========================================================================== #

        elif [ $options -eq 20 ]; then
        	TIME='date +%T'
        	yum_update_tmp="touch /tmp/yum_tmp$TIME"
        	eval $yum_update_tmp
        	#hostname="bin/hostname"
        	#eval $hostname
        	echo -e "Checking available update(s) for yum repo..."
        	yum_update='yum update' 
        	eval $yum_update 
        	
        	update_num="cat $yum_update_tmp | egrep '(.i386|.x86_64|.noarch.|.src)' | wc -l "
        	eval $update_num
        	update="cat $yum_update_tmp | egrep '(.i386|.x86_64|.noarch.|.src)'"
        	eval $update
        	echo -e "

        	>_ There are $update_num available on localhost
        	+++++++++++++++++++++++++++++++++++++++++++++++
        	>_ Available update(s) are :
        	$update
        	+++++++++++++++++++++++++++++++++++++++++++++++

        	>_ Would you like to install all update(s) with dependencies ? [Y/n]
        	"
        	yum_update='yum update -y'
        	eval $yum_update 
        	echo -e ">_ yum repo update Successfully !!!"
      	fi

	else
		$options 2> /dev/null
		echo -e "INVALID OPTIONS !!! Please run again script &  select appropriate options "
		exit 1
			
	fi
done

