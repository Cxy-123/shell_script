#!/bin/bash
function cpu() {
    util=$(vmstat |awk 'NR==3{print $13+$14}')
    iowait=$(vmstat |awk 'NR==3{print $16}')
    echo "CPU - 使用率： ${util}%,等待磁盘IO响应使用率： ${iowait}%"
}
function memory(){
    total=$(free -m |awk 'NR==2{printf "%.1f",$2/1024}')
    used=$(free -m |awk 'NR==2{printf "%.1f",($2-$NF)/1024}')
    availiable=$(free -m |awk 'NR==2{printf "%.1f",$NF/1024}')
    echo "内存 - 总大小： $total G, 已使用： $used G, 可用： $availiable G"
}
disk() {
    fs=$(df -h | awk '/^\/dev/{print $1}')
    for p in $fs;do
	mounted=$(df -h | awk -v p=$p 'p==$1{print $NF}')
	size=$(df -h | awk -v p=$p 'p==$1{print $2}')
	used=$(df -h | awk -v p=$p 'p==$1{print $3}')
	used_percent=$(df -h | awk -v p=$p 'p==$1{print $5}')
	echo "硬盘 - 挂载点： $mounted, 总大小： $size G, 已使用： $used G, 使用率： $used_percent G"
    done
    
}
tcp_status(){
    summary=$(netstat -antp | awk '{a[$6]++}END{for(i in a){printf i":"a[i]"  "}}')
    echo "TCP连接状态 - $summary"
}
cpu
memory
disk
tcp_status
