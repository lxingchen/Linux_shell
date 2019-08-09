#!/bin/bash

IP=$(/sbin/ifconfig|sed -n 2p|awk '{print $2}')
egrep "$IP" user_passwd.txt >> user_passwd.txt >> /dev/null 2>&1

while read line
do
	read ip user pw <<< $(echo $line | egrep "$IP")
	if [ -n "$user" -a -n "$pw" ];then
		echo $pw |passwd --stdin $user >> /dev/null 2>&1
		if [[ $? != 0 ]];then
			echo $IP $user
		fi
	fi
done < user_passwd.txt

#rm -rf user_passwd.txt
