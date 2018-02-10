#!/bin/sh
function echo_01(){
        echo "$1"
}
echo_01 "*****  Server OS Info *****"
cat /etc/issue
echo_01 "*****  HDD *****"
df -h
echo_01 "*****  Memory *****"
free -b
echo_01 "*****  LISTEN Port *****"
netstat -nlt

