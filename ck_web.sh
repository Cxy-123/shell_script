#!/bin/bash
URL_LIST="www.baidu.com www.abcd.com"
for url in $URL_LIST;do
    COUNT=0
    for i in {1..3};do
        CODE=$(curl -o /dev/null -s -w "%{http_code}" $url)
	if [ $CODE -eq 200 ];then
	    echo "$url is Aavalibal!"
	    break
	else
	    let COUNT++
	    echo "$url retry $COUNT time"
	fi
    done
    if [ $COUNT -eq 3 ];then
	echo "$url access failure!"
    fi

done
