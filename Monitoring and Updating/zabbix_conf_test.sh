#!/bin/bash

# Description : This script will check zabbix_agent.conf file parameter(s) and save zabbix agent which has unmathced parameter(s)
# Author : Harshil Jethava
# Version : 0.1(testing)
# Date : 20-02-2017
# Email : harshiljethava7atgmaildotcom
# Site : http://harshiljethava.github.io
# License : GNU GPL v3.0


conf="cat /root/zabbix_script/zabbix_agentd.conf"
conf_cont=$(eval $conf)
#echo "$conf_cont"
#for((i=0 ; i < ${#conf_cont[@]} ;i++ ))
#do
#	echo -e $i"${conf_cont[i]}"
#done	

for i in $conf_cont
do
	if [ $i == "Hostname=" ];then
		echo -e "$i"
	fi
	if [ $i == "Server=" ];then
		echo -e "$i"
	fi
	if [ $i == "ServerActive=" ];then
		echo -e "$i"
	fi
done
