#!/bin/bash
#  Author : Tails Chi
#  Time   : 2014/06/06
#  Count count target system download time

IP=$1
STATUS="true"
Start_TIME=null
Stop_TIME=null

if [ "$IP" == "" ]; then
  echo "Please input a IP address"
  exit
fi

while [ true ]
do
  ping -c 1 $IP > /dev/null
  if [ "$?" == "0" ]; then 
    if [ "$STATUS" == "false" ]; then
       Stop_TIME=`date +%s`
       break
    fi
  else     
    if [ "$STATUS" == "true" ]; then
       Start_TIME=`date +%s`
       STATUS="false"
    fi
  fi
  sleep 1
done

#echo " Start Time = $Start_TIME"
#echo " Stop Time = $Stop_TIME"
Down_TIME=$(($Stop_TIME - $Start_TIME))

echo "Down time = $Down_TIME"
