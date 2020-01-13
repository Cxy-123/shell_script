#!/bin/bash

for IP in $(awk '/^[^#]/{print $1}' host.info);do
    USER=$(awk -v ip=$IP 'ip==$1{print $2}' host.info)
    PORT=$(awk -v ip=$IP 'ip==$1{print $3}' host.info)
    ssh $USER@$IP "df -h"  > /tmp/mem.disk
    USER_RATE_LIST=$(awk '/^\/dev/{print $6"="int($5)}' /tmp/mem.disk)
    for user in $USER_RATE_LIST;do
	PART=${user%=*}
	USER_RATE=${user#*=}
	if [ $USER_RATE -ge 10 ];then
		echo "host:$IP"
		echo "warning!!part_name:$PART usage_rate is $USER_RATE%"
	fi
    done
    
done
