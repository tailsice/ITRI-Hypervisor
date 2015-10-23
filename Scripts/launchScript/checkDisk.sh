#!/bin/bash
DIR=/root/disk/d
LOG_FILE=/tmp/checkDiskLog
MODE=$1

if [ -z $1 ]; then
  echo "Please input parameter"
  exit 1
fi

if [ "$MODE" == "4" -o "$MODE" == "8" -o "$MODE" == "12" -o "$MODE" == "16" ]; then
  if [ -e $LOG_FILE ]; then
     rm -rf $LOG_FILE
     echo "Clean Log File"
  fi
else
  echo "Please input 4,8,12,16"
  exit 1
fi

function checkWrite() {
  COUNT=$1
  for j in `seq 1 $COUNT`
  do
  NAME=$DIR$j
  if [ -w $NAME ]; then
    echo "" > /dev/null
  else
    echo "$NAME Can't write" >> $LOG_FILE
  fi
  done
}

function checkMount() {
  COUNT=$1
  for j in `seq 1 $COUNT`
  do
  NAME=$DIR$j
  RE=`mount | grep $NAME | wc -l`
  if [ "$RE" == "0" ]; then
     echo "vdisk $j can't mount" >> $LOG_FILE
  fi
  done
}

if [ "$MODE"  == "4" ]; then
  mount /dev/vdb /root/disk/d1 
  mount /dev/vdc /root/disk/d2 
  mount /dev/vdd /root/disk/d3
  mount /dev/vde /root/disk/d4

  NUMBER=`mount | grep /disk/d | wc -l`
  if [ "$NUMBER" != "4" ];then
    checkMount 4
  fi
  checkWrite 4

  for i in `seq 1 4`
  do
    FOLDER=/root/disk/d$i
    umount $FOLDER
  done
fi

if [ "$MODE"  == "8" ]; then
  mount /dev/vdb /root/disk/d1 
  mount /dev/vdc /root/disk/d2 
  mount /dev/vdd /root/disk/d3
  mount /dev/vde /root/disk/d4
  mount /dev/vdf /root/disk/d5
  mount /dev/vdg /root/disk/d6 
  mount /dev/vdh /root/disk/d7
  mount /dev/vdi /root/disk/d8

  NUMBER=`mount | grep /disk/d | wc -l`
  if [ "$NUMBER" != "8" ];then
    checkMount 8
  fi
  checkWrite 8

  for i in `seq 1 8`
  do
    FOLDER=/root/disk/d$i
    umount $FOLDER
  done
fi

if [ "$MODE"  == "12" ]; then
  mount /dev/vdb /root/disk/d1 
  mount /dev/vdc /root/disk/d2 
  mount /dev/vdd /root/disk/d3
  mount /dev/vde /root/disk/d4
  mount /dev/vdf /root/disk/d5
  mount /dev/vdg /root/disk/d6 
  mount /dev/vdh /root/disk/d7
  mount /dev/vdi /root/disk/d8
  mount /dev/vdj /root/disk/d9
  mount /dev/vdk /root/disk/d10
  mount /dev/vdl /root/disk/d11
  mount /dev/vdm /root/disk/d12

  NUMBER=`mount | grep /disk/d | wc -l`
  if [ "$NUMBER" != "12" ];then
    checkMount 12
  fi
  checkWrite 12

  for i in `seq 1 12`
  do
    FOLDER=/root/disk/d$i
    umount $FOLDER
  done
fi

if [ "$MODE"  == "16" ]; then
  mount /dev/vdb /root/disk/d1 
  mount /dev/vdc /root/disk/d2 
  mount /dev/vdd /root/disk/d3
  mount /dev/vde /root/disk/d4
  mount /dev/vdf /root/disk/d5
  mount /dev/vdg /root/disk/d6 
  mount /dev/vdh /root/disk/d7
  mount /dev/vdi /root/disk/d8
  mount /dev/vdj /root/disk/d9
  mount /dev/vdk /root/disk/d10
  mount /dev/vdl /root/disk/d11
  mount /dev/vdm /root/disk/d12
  mount /dev/vdn /root/disk/d13
  mount /dev/vdo /root/disk/d14
  mount /dev/vdp /root/disk/d15
  mount /dev/vdq /root/disk/d16

  NUMBER=`mount | grep /disk/d | wc -l`
  if [ "$NUMBER" != "16" ];then
    checkMount 16
  fi
  checkWrite 16

  for i in `seq 1 16`
  do
    FOLDER=/root/disk/d$i
    umount $FOLDER
  done
fi

if [ -e $LOG_FILE ]; then
   echo "### Error Message ###"
   cat $LOG_FILE
else
   echo "All Fine"
fi

exit

