#!/bin/bash
LOG_FILE="access.log"
LOG_DIR=/usr/local/nginx/logs/
YESTERDAY_TIME=$(date -d "yesterday" +%F)
LOG_MONTH_DIR=$LOG_DIR/$(date +"%Y-%m")

for log_file in $LOG_FILE;do
    [ ! -d $LOG_MONTH_DIR ] && mkdir -p $LOG_MONTH_DIR
    mv $LOG_DIR/$log_file $LOG_MONTH_DIR/${log_file}_${YESTERDAY_TIME}
done
kill -USR1 $(cat $LOG_DIR/nginx.pid)
