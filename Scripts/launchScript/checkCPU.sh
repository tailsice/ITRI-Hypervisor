#!/bin/bash
# Logical CPU count
COUNT=`cat  /proc/cpuinfo |  grep  "processor"  |  wc  -l `
echo  "logical CPU number : $COUNT"   
  
# Physical CPU count
COUNT=`cat  /proc/cpuinfo | grep "physical id" | sort |  uniq  | wc  -l`  
echo  "physical CPU number : $COUNT"
  
# Physcial CPU Cores
COUNT=`cat  /proc/cpuinfo|grep "cpu cores"| uniq | awk -F: '{print $2}'` 
echo  "core number in a physical CPU : $COUNT"   
  
#cat  /proc/cpuinfo |  grep  "core id" | sort -u 
  
#cat  /proc/cpuinfo |  grep flags | grep ht |sort -u
  
#cat  /proc/cpuinfo |  grep  "siblings" | sort -u
