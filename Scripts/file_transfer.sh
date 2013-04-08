#!/bin/bash
for((i=1;i<6;i++))
do
echo "Loop $i"
dd if=/dev/zero of=random_file bs=$(($RANDOM % 51200)) count=2048
sshpass -p 'root' scp random_file root@192.168.101.2:~
md5sum random_file
sshpass -p 'root' ssh root@192.168.101.2 "md5sum random_file"
done
