#!/bin/bash
echo "----------------------------cpu top 10---------------------------"
ps -eo pid,pcpu,pmem,args --sort=-pcpu | head -n 10
echo "---------------------------memory top 10-------------------------"
ps -eo pid,pcpu,pmem,args --sort=-pmem | head -n 10
