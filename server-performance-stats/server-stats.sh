#!/bin/bash

# Total CPU usage
echo "############################################"
echo "############ Total CPU Usage ############"
echo "############################################"
echo "CPU Usage: "$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]"%"

echo 

# Total memory usage (Free vs Used including percentage)
total_mem=$(free | awk '/^Mem:/{print $2}')
used_mem=$(free | awk '/^Mem:/{print $3}')
free_mem=$(free | awk '/^Mem:/{print $4}')

total_mem_gb=$((total_mem / 1024 / 1024))
used_mem_gb=$((used_mem / 1024 / 1024))
free_mem_gb=$((free_mem / 1024 / 1024))

used_percent=$((used_mem * 100 / total_mem))
free_percent=$((free_mem * 100 / total_mem))

echo "############################################"
echo "############ Total Memory Usage ############"
echo "############################################"

echo "Total memory: $total_mem_gb GB"
echo "Used memory: $used_mem_gb GB ($used_percent%)"
echo "Free memory: $free_mem_gb GB ($free_percent%)"

echo

# Total disk usage (Free vs Used including percentage)
echo "############################################"
echo "############ Total Disk Usage ############"
echo "############################################"
total_disk=$(df --block-size=1G / | awk 'NR==2 {print $2}')
used_disk=$(df --block-size=1G / | awk 'NR==2 {print $3}')
avail_disk=$(df --block-size=1G / | awk 'NR==2 {print $4}')

used_percent=$((used_disk * 100 / total_disk))
free_percent=$((avail_disk * 100 / total_disk))

echo "Total disk: ${total_disk} GB"
echo "Used disk: ${used_disk} GB (${used_percent}%)"
echo "Free disk: ${avail_disk} GB (${free_percent}%)"

echo

# Top 5 processes by CPU usage
echo "###################################"
echo "# Top 5 Processes by Memory Usage #"
echo "###################################"
ps aux --sort -%mem | head -n 6 | awk '{print $1 "\t" $2 "\t" $4 "\t" $11}'

echo

# Top 5 processes by memory usage
echo "################################"
echo "# Top 5 Processes by CPU Usage #"
echo "################################"
ps aux --sort -%cpu | head -n 6 | awk '{print $1 "\t" $2 "\t" $3 "\t" $11}'