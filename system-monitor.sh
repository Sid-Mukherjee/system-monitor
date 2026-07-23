#!/bin/bash

today=$(date)
hostname=$(hostname)
username=$(whoami)
uptime=$(uptime -p)
diskUsage=$(df -h / | awk 'NR==2 {print $5}')
cpuIdle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
cpuUsage=$(echo "100 - $cpuIdle" | bc)  
ramUsage=$(free -h --giga | grep "Mem" | awk '{print $3}')
batteryPercent=$(cat /sys/class/power_supply/BAT0/capacity)
ipAddress=$(ip route get 1.1.1.1 | awk '{print $7}')

echo "============================"
echo "System Health Dashboard"
echo "============================"
echo 
echo "General"
echo "------------------------------------"
echo
echo "Today's date:   $today" 
echo 
echo "Hostname:       $hostname" 
echo
echo "Username:       $username"
echo 
echo "Uptime:         $uptime"
echo
echo "Resources"
echo "------------------------------------"
echo
echo "Disk usage:     $diskUsage"
echo
echo "CPU Usage:      $cpuUsage%" 
echo 
echo "Memory Usage:   $ramUsage"
echo 
echo "Battery:        $batteryPercent%"  
echo
echo "Network"
echo "------------------------------------"
echo 
echo "IP address:     $ipAddress"