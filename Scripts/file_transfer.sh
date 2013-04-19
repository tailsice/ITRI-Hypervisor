#!/bin/bash
if [ "$1" == "" ] || [ "$2" == "" ]; then
        echo "     ###################################"
        echo "     # file_transfer [Count] [Loop]    #"
        echo "     # Example: file_transfer 2 5      #"
        echo "     # File size:2MB, Number of loop:5 #" 
        echo "     ###################################"
else
time=$(date)
dd if=/dev/zero of=random_file bs=1024k count=$1
host_md5=$(md5sum random_file)
host_size=$(du -sh random_file)
echo "Copy random_file from Host to Guest VM1"
scp_start=$(date +%s)
scp random_file 192.168.20.2:~
scp_end=$(date +%s)
echo "Elapsed time:$(($scp_end-$scp_start)) seconds"
vm1_md5=$(ssh 192.168.20.2 "md5sum random_file")
vm1_size=$(ssh 192.168.20.2 "du -sh random_file")
echo "Copy random_file from Guest VM1 to Guest VM2"
scp_start=$(date +%s)
ssh 192.168.20.2 "sshpass -p 'root' scp random_file root@192.168.20.4:~"
scp_end=$(date +%s)
echo "Elapsed time:$(($scp_end-$scp_start)) seconds"
vm2_md5=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "md5sum rand
om_file"")
vm2_size=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "du -sh ran
dom_file"")
echo "Check md5 from Host and Guest VMs:"
if [ "$host_md5" == "$vm1_md5" ] && [ "$vm1_md5" == "$vm2_md5" ]; then
        echo "MD5 match"
else
        echo "MD5 doesn't match"
fi
echo "Check file size from Host and Guest VMs:"
if [ "$host" == "$vm1" ] && [ "$vm1" == "$vm2" ]; then
        echo "File size match"
else
        echo "File size doesn't match"
fi
for((i=1;i<=$2;i++))
do
echo
echo "Loop $i"
ssh 192.168.20.2 "dd if=/dev/zero of=random_file bs=1024k count=$1"
vm1_md5=$(ssh 192.168.20.2 "md5sum random_file")
vm1_size=$(ssh 192.168.20.2 "du -sh random_file")
echo "Copy random_file from Guest VM1 to Guest VM2"
vm2_md5=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "md5sum rand
om_file"")
vm2_size=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "du -sh ran
dom_file"")
scp_start=$(date +%s)
ssh 192.168.20.2 "sshpass -p 'root' scp random_file root@192.168.20.4:~"
scp_end=$(date +%s)
echo "Elapsed time:$(($scp_end-$scp_start)) seconds"
echo "Check md5 from Guest VM1 and Guest VM2:"
if [ "$vm1_md5" == "$vm2_md5" ]; then
        echo "MD5 match"
else
        echo "MD5 doesn't match"
fi
echo "Check file size from Guest VM1 and Guest VM2:"
if [ "$vm1_size" == "$vm2_size" ]; then
        echo "File size match"
else
        echo "File size doesn't match"
fi
echo
echo "Copy random_file from Guest VM2 to Guest VM1"
vm2_md5=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "md5sum rand
om_file"")
vm2_size=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "du -sh ran
dom_file"")
scp_start=$(date +%s)
ssh 192.168.20.2 "sshpass -p 'root' scp 192.168.20.4:random_file ~"
scp_end=$(date +%s)
echo "Elapsed time:$(($scp_end-$scp_start)) seconds"
vm1_md5=$(ssh 192.168.20.2 "md5sum random_file")
vm1_size=$(ssh 192.168.20.2 "du -sh random_file")
echo "Check md5 from Guest VM1 and Guest VM2:"
if [ "$vm1_md5" == "$vm2_md5" ]; then
        echo "MD5 match"
else
        echo "MD5 doesn't match"
fi
echo "Check file size from Guest VM1 and Guest VM2:"
if [ "$vm1_size" == "$vm2_size" ]; then
        echo "File size match"
else
        echo "File size doesn't match"
fi
done
echo
echo "Start time:"
echo "$time"
echo "End time:" 
date
fi