#!/bin/bash
time=$(date)
dd if=/dev/zero of=random_file bs=5120 count=2048
echo "Copy random_file from Host to Guest VM1 and Guest VM1 to Guest VM2"
scp random_file 192.168.20.2:~
ssh 192.168.20.2 "sshpass -p 'root' scp random_file root@192.168.20.4:~"
echo "Check md5 from Host and VMs:"
host_md5=$(md5sum random_file)
vm1_md5=$(ssh 192.168.20.2 "md5sum random_file")
vm2_md5=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "md5sum random_file"")
if [ "$host_md5" == "$vm1_md5" ] && [ "$vm1_md5" == "$vm2_md5" ]; then
        echo "Match"
else
        echo "No match"
fi
echo "Check file size from Host and VMs:"
host_size=$(du -sh random_file)
vm1_size=$(ssh 192.168.20.2 "du -sh random_file")
vm2_size=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "du -sh random_file"")
if [ "$host" == "$vm1" ] && [ "$vm1" == "$vm2" ]; then
        echo "Match"
else
        echo "No match"
fi
for((i=1;i<2;i++))
do
echo
echo "Loop $i"
ssh 192.168.20.2 "dd if=/dev/zero of=random_file bs=5120 count=2048"
echo "Copy random_file from Guest VM1 to Guest VM2"
ssh 192.168.20.2 "sshpass -p 'root' scp random_file root@192.168.20.4:~"
echo "Check md5 from VM1 and VM2:"
vm1_md5=$(ssh 192.168.20.2 "md5sum random_file")
vm2_md5=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "md5sum random_file"")
if [ "$vm1_md5" == "$vm2_md5" ]; then
        echo "Match"
else
        echo "No match"
fi
echo "Check file size from VM1 and VM2:"
vm1_size=$(ssh 192.168.20.2 "du -sh random_file")
vm2_size=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "du -sh random_file"")
if [ "$vm1_size" == "$vm2_size" ]; then
        echo "Match"
else
        echo "No match"
fi
echo
echo "Copy random_file from Guest VM2 to Guest VM1"
ssh 192.168.20.2 "sshpass -p 'root' scp 192.168.20.4:random_file ~"
echo "Check md5 from VM1 and VM2:"
vm2_md5=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "md5sum random_file"")
vm1_md5=$(ssh 192.168.20.2 "md5sum random_file")
if [ "$vm1_md5" == "$vm2_md5" ]; then
        echo "Match"
else
        echo "No match"
fi
echo "Check file size from VM1 and VM2:"
vm2_size=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "du -sh random_file"")
vm1_size=$(ssh 192.168.20.2 "du -sh random_file")
if [ "$vm1_size" == "$vm2_size" ]; then
        echo "Match"
else
        echo "No match"
fi
done
echo
echo "Start time:"
echo "$time"
echo "End time:" 
date
