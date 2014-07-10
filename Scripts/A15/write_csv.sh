#!/bin/bash

logdir=/mnt/Data/log

if [ -e $logdir/migrate_cpu.log ] ; then
   migrate_log=$logdir/migrate_cpu.log
elif [ -e $logdir/migrate_memory.log ] ; then
   migrate_log=$logdir/migrate_memory.log
elif [ -e $logdir/migrate_io.log ] ; then
   migrate_log=$logdir/migrate_io.log
else
   echo "No migrate log file found."
   exit 1
fi

Migrate_start_minute=`cat $migrate_log | tail -n 3 | head -n 1 | awk -F : '{print \$2}'`

Migrate_end_minute=`cat $migrate_log | tail -n 2 | awk -F : '{print \$2}'`

Migrate_start_second=`cat $migrate_log | tail -n 3 | head -n 1 | awk -F : '{print \$3}'`

Migrate_end_second=`cat $migrate_log | tail -n 2 | awk -F : '{print \$3}'`

Migrate_start_nanosecond=`cat $migrate_log | tail -n 3 | head -n 1 | awk -F : '{print \$4}'`

Migrate_end_nanosecond=`cat $migrate_log | tail -n 2 | awk -F : '{print \$4}'`


Migrate_end2start_minute=`expr $Migrate_end_minute - $Migrate_start_minute`

Migrate_end2start_second=`expr $Migrate_end_second - $Migrate_start_second`

Migrate_end2start_nanosecond=`expr $Migrate_end_nanosecond - $Migrate_start_nanosecond`

Migrate_end2start_m2s=`expr 60 \* $Migrate_end2start_minute`

Migrate_spend_second=`expr $Migrate_end2start_m2s + $Migrate_end2start_second`

Migrate_spend_s2ns=`expr 1000000000 \* $Migrate_spend_second`

Migrate_spend_nanosecond=`expr $Migrate_spend_s2ns + $Migrate_end2start_nanosecond`

Migrate_spend_time=`echo "scale=9; $Migrate_spend_nanosecond/1000000000" | bc`

#Migrate_spend_time=$(($Migrate_end_second - $Migrate_start_second))

#Transfer_data_size=`cat $logdir/netio.log | tail -n 1 | tr  ' ' | awk '{print \$NF}'`
Transfer_data_size=`grep  $logdir/netio.log | tail -n 1 | tr  ' ' | awk '{print \$NF}'`

Downtime=`cat $migrate_log | tail -n 1 | cut -d'=' -f2`

# $1 is Number_of_reboot 
# $2 is Down time

echo "$1, ${Migrate_spend_time}, ${Downtime}, ${Transfer_data_size}"
