#!/bin/bash
dd if=/dev/zero of=random_file bs=$(($RANDOM % 5120)) count=2048
echo "Copy random_file from Host to Guest VM1 and Guest VM1 to Guest VM2"
scp random_file 192.168.20.2:~
ssh 192.168.20.2 "sshpass -p 'root' scp random_file root@192.168.20.4:~"
echo "Host md5:"
md5sum random_file
echo "Guest VM1 md5:"
ssh 192.168.20.2 "md5sum random_file"
echo "Guest VM2 md5:"
ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "md5sum random_file""
echo "Host file size:"
du -sh random_file
echo "Guest VM1 file size:"
ssh 192.168.20.2 "du -sh random_file"
echo "Guest VM2 file size:"
ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "du -sh random_file""
for((i=1;i<4;i++))
do
echo
echo "Loop $i"
ssh 192.168.20.2 "dd if=/dev/zero of=random_file bs=$(($RANDOM % 5120)) count=20
48"
echo "Copy random_file from Guest VM1 to Guest VM2"
ssh 192.168.20.2 "sshpass -p 'root' scp random_file root@192.168.20.4:~"
echo "Guest VM1 md5:"
ssh 192.168.20.2 "md5sum random_file"
echo "Guest VM2 md5"
ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "md5sum random_file""
echo "Guest VM1 file size:"
ssh 192.168.20.2 "du -sh random_file"
echo "Guest VM2 file size:"
ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "du -sh random_file""
echo
echo "Copy random_file from Guest VM2 to Guest VM1"
ssh 192.168.20.2 "sshpass -p 'root' scp 192.168.20.4:random_file ~"
echo "Guest VM2 md5"
ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "md5sum random_file""
echo "Guest VM1 md5:"
ssh 192.168.20.2 "md5sum random_file"
echo "Guest VM2 file size:"
ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "du -sh random_file""
echo "Guest VM1 file size:"
ssh 192.168.20.2 "du -sh random_file"
done


