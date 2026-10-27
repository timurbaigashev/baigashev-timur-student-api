#!usr/bin/env bash

mkdir -p ~/devops/baigashev_timur_student_api/logs

exec > ~/devops/baigashev_timur_student_api/logs/Baigashev_Timur_system_report.log 2>&1

echo "================================"
echo "Student Information"
echo "================================"
echo "Surname: Baigashev"
echo "Name: Timur"
echo "================================"
echo "Current DateTime: $(date)"
echo "Username: $(whoami)"
echo "Operating System: $(uname -s)"
echo "Kernel version: $(uname -v)"
echo "================================"
echo "Disk Usage:"
df -h /
echo "CPU information:"
lscpu
echo "Memory Usage:"
free -h 2>/dev/null || grep MemTotal /proc/meminfo
echo "Available disk space:"
lsblk
