#!/bin/bash

echo "TimeStamp,CPU_User,CPU_System,CPU_iowat,Memory_Use,Swap_Use,Disk Reade,Disk Write"
while [ true ]
do
  DATE=`date "+%Y-%m-%d %H:%M:%S"`
  iostat 1 2 > /tmp/iostat
  top -b -n 1 > /tmp/top
  CPU_U=`cat /tmp/iostat |tail -n 6 | awk '{print $2}' | head -n 2 | tail -n 1`
  CPU_S=`cat /tmp/iostat |tail -n 6 | awk '{print $4}' | head -n 2 | tail -n 1`
  CPU_I=`cat /tmp/iostat |tail -n 6 | awk '{print $5}' | head -n 2 | tail -n 1`
  Mem_U=`cat /tmp/top |head -n 4 | tail -n 1 |awk '{print $2}'`
  Swap_U=`cat /tmp/top |head -n 5 | tail -n 1 |awk '{print $2}'`
  Disk_R=`cat /tmp/iostat |tail -n 2 | head -n 1 | awk '{print $3}'`
  Disk_W=`cat /tmp/iostat |tail -n 2 | head -n 1 | awk '{print $4}'`
  echo ${DATE},${CPU_U},${CPU_S},${CPU_I},${Mem_U},${Swap_U},${Disk_R},${Disk_W}
done
