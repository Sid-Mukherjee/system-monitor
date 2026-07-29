#!/bin/bash

getSysInfo() { 
    today=$(date)
    hostname=$(hostname)
    username=$(whoami)
    uptime=$(uptime -p)
    diskUsage=$(df -h / | awk 'NR==2 {print $5}')
    cpuIdle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
    cpuUsage=$(echo "100 - $cpuIdle" | bc)  
    cpuProgress=$(echo "$cpuUsage" | awk '{print int($1)}')
    usedMemory=$(free -h --giga | grep "Mem" | awk '{print $3}')
    batteryPercent=$(cat /sys/class/power_supply/BAT0/capacity)
    ipAddress=$(ip route get 1.1.1.1 | awk '{print $7}')
}

printHeader() {
    echo "============================"
    echo "System Health Dashboard"
    echo "============================"
}

printGeneralInfo() {
    echo "Today's date:   $today" 
    echo 
    echo "Hostname:       $hostname" 
    echo
    echo "Username:       $username"
    echo 
    echo "Uptime:         $uptime"
}

printResourceInfo() {
    echo -n "Disk usage:     $diskUsage "
    
    diskPercent=$(echo "$diskUsage" | tr -d '%' )
    createProgressBar "$diskPercent"

    echo
    echo -n "CPU Usage:      $cpuUsage% "
    
    createProgressBar "$cpuProgress"
    
    echo 
    echo "Memory Usage:   $usedMemory"
    echo 
    echo -n -e  "Battery:        $batteryColour$batteryPercent%\e[0m "
    
    createProgressBar "$batteryPercent"
}

printNetworkInfo() {
    echo "IP address:     $ipAddress"
}

setBatteryColour() {
    if [ "$batteryPercent" -ge 50 ]; then 
        batteryColour="\e[32m"
        
    elif [ "$batteryPercent" -ge 20 ]; then 
        batteryColour="\e[33m"
        
    else 
        batteryColour="\e[31m"
        
    fi
}

createProgressBar() {
    local filledBlocks=$(($1/10)) 
    local emptyBlocks=$((10 - $filledBlocks))
    for i in $(seq 1 $filledBlocks) 
    do 
        echo -n "⬛"
    done
    for i in $(seq 1 $emptyBlocks) 
    do 
        echo -n "⬜"
    done
    echo
}

main() {
    getSysInfo
    setBatteryColour
    printHeader
    echo 
    echo "Resources"
    echo "------------------------------------"
    echo
    printResourceInfo
    echo
    echo "General"
    echo "------------------------------------"
    echo
    printGeneralInfo 
    echo
    echo "Network"
    echo "------------------------------------"
    echo 
    printNetworkInfo
}

main

