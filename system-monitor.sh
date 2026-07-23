#!/bin/bash

today=$(date)
hostname=$(hostname)
username=$(whoami)
uptime=$(uptime -p)
diskUsage=$(df -h / | awk 'NR==2 {print $5}')

echo "============================"
echo "System Health Dashboard"
echo "============================"
echo 
echo "Today's date: $today" 
echo 
echo "Hostname: $hostname" 
echo
echo "Username: $username"
echo 
echo "Uptime: $uptime"
echo
echo "Disk usage: $diskUsage"

