#!/bin/bash

# Description : This script will check status of zabbix agent(s) through telnet which are affected by NDC and create a list of agentd# 		     in text file.
# Author : Harshil Jethava
# Version : 0.1(testing)
# Date : 10-02-2017
# Email : harshiljethava7atgmaildotcom
# Site : http://harshiljethava.github.io
# License : GNU GPL v3.0

# create array variable to store value from mysql query
declare -a host_list

#host_file='cat host_list.txt'

#mysql query to fetch list of error servers 
#mysql_ndc="mysql -u root --password=MYSQL_PASSWORD --database=DATABASE -e 'MYSQL_QUERY' "

# loop to store fetched value from mysql query to array variable
while read query
do
	host_list+=("$query")
done < <(mysql -u root --password=Qwe@123 --database=zabbix -e 'select hostid  from zabbix.hosts')

# print list of errored servers (testing purpose only !)
echo -e ${host_list[*]} 

# store errored servers list in text file
eval 'echo -e ${host_list[*]} >> host_list.txt'

#host_list=$(eval 'cat host_list.txt')
host_list=("192.168.43.86" "127.0.0.1" "localhost" )

#telnet='telnet 127.0.0.1 22   2> telnet_list.txt >> /dev/null'

# find length of host_list variable array  (testing purpose only !)
echo -e "LENGTH : "${#host_list[@]}

#assign port value for telnet 
port=22
#telnet 127.0.0.1 3306  < /dev/null 2>&1 | grep  Escape | wc -l
telnet_save='telnet ${host_list[$i]} $port < /dev/null 2>&1 | grep Escape | wc -l  '
# loop to telnet errored server from text file to port
for((i=0;i< ${#host_list[@]};i++))
do
	#echo -e "in"
	#echo $i
	#test=$(eval 'telnet ${host_list[$i]} $port &> host_list.txt; echo $?' )
	flag=$(eval $telnet_save)
	if [ $flag -eq 1 ];then
		echo -e "Up " $flag
		echo ${host_list[i]}
		eval "echo ${host_list[i]} >> filtered_host.txt"
	else
		echo -e "Down " $flag
	fi
	#echo $flag
	#echo -e "TEST"$test
	continue
	echo $flag
done
