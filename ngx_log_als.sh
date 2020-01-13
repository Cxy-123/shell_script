#!/bin/bash
LOG_FILE=$1
#访问最多的ip
awk '{ip[$1]++}END{for(i in ip){print i,ip[i]}}' $LOG_FILE | sort -nr
#访问最多的页面
awk '{website[$7]++}END{for(i in website){print i,website[i]}}' $LOG_FILE | sort -nr 
#访问页面状态码数量
awk '{status[$7" "$9]++}END{for(i in status){print i,status[i]}}' $LOG_FILE | sort -nr 
#根据时间段来访问最多的ip
awk '$4 >= "[13/Jan/2020:17:00:00" && $4 <= "[13/Jan/2020:18:00:00"{ip[$1]++}END{for(i in ip){print i,ip[i]}}' $LOG_FILE | sort -nr 


