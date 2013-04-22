#!/bin/bash
if [ "$1" == "" ] || [ "$2" == "" ]; then
        echo "     ###################################"
        echo "     # file_transfer [Count] [Loop]    #"
        echo "     # Example: file_transfer 2 5      #"
        echo "     # File size:2MB, Number of loop:5 #" 
        echo "     ###################################"
else
echo -e "Loop\tElapsed time(seconds)\tMD5 comparison result\tSize comparison result" | tee -a /root/test.log
start_time=$(date +%Y%m%d%H%M%S)
dd if=/dev/zero of=random_file bs=1024k count=$1
host_md5=$(md5sum random_file)
host_size=$(du -sh random_file)
echo "Copy random_file from Host to Guest VM1"
scp_start=$(date +%s)
scp random_file 192.168.20.2:~
scp_end=$(date +%s)
#echo "Elapsed time:$(($scp_end-$scp_start)) seconds"
echo -n -e "\t$(($scp_end-$scp_start))\t" | tee -a /root/test.log
vm1_md5=$(ssh 192.168.20.2 "md5sum random_file")
vm1_size=$(ssh 192.168.20.2 "du -sh random_file")
echo "Check md5 from Host and Guest VM1:"
if [ "$host_md5" == "$vm1_md5" ]; then
        echo -n -e "MD5 match\t" | tee -a /root/test.log
else
        echo -n -e "MD5 doesn't match\t" | tee -a /root/test.log
fi
echo "Check size from Host and Guest VM1:"
if [ "$host" == "$vm1" ]; then
        echo "Size match" | tee -a /root/test.log
else
        echo "Size doesn't match" | tee -a /root/test.log
fi
for((i=1;i<=$2;i++))
do
echo
#echo "Loop $i"
echo -n -e "$i\t" | tee -a /root/test.log
vm1_md5=$(ssh 192.168.20.2 "md5sum random_file")
vm1_size=$(ssh 192.168.20.2 "du -sh random_file")
echo "Copy random_file from Guest VM1 to Guest VM2"
vm2_md5=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "md5sum random_file"")
vm2_size=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "du -sh random_file"")
scp_start=$(date +%s)
ssh 192.168.20.2 "sshpass -p 'root' scp random_file root@192.168.20.4:~"
scp_end=$(date +%s)
#echo "Elapsed time:$(($scp_end-$scp_start)) seconds" 
echo -n -e "$(($scp_end-$scp_start))\t" | tee -a /root/test.log
echo "Check md5 from Guest VM1 and Guest VM2:"
if [ "$vm1_md5" == "$vm2_md5" ]; then
        echo -n -e "MD5 match\t" | tee -a /root/test.log
else
        echo -n -e "MD5 doesn't match\t" | tee -a /root/test.log
fi
echo "Check size from Guest VM1 and Guest VM2:"
if [ "$vm1_size" == "$vm2_size" ]; then
        echo "Size match" | tee -a /root/test.log
else
        echo "Size doesn't match" | tee -a /root/test.log
fi
echo
echo "Copy random_file from Guest VM2 to Guest VM1"
vm2_md5=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "md5sum random_file"")
vm2_size=$(ssh 192.168.20.2 "sshpass -p 'root' ssh root@192.168.20.4 "du -sh random_file"")
scp_start=$(date +%s)
ssh 192.168.20.2 "sshpass -p 'root' scp 192.168.20.4:random_file ~"
scp_end=$(date +%s)
#echo "Elapsed time:$(($scp_end-$scp_start)) seconds" 
echo -n -e "\t$(($scp_end-$scp_start))\t" | tee -a /root/test.log
vm1_md5=$(ssh 192.168.20.2 "md5sum random_file")
vm1_size=$(ssh 192.168.20.2 "du -sh random_file")
echo "Check md5 from Guest VM1 and Guest VM2:"
if [ "$vm1_md5" == "$vm2_md5" ]; then
        echo -n -e "MD5 match\t" | tee -a /root/test.log
else
        echo -n -e "MD5 doesn't match\t" | tee -a /root/test.log
fi
echo "Check size from Guest VM1 and Guest VM2:"
if [ "$vm1_size" == "$vm2_size" ]; then
        echo "Size match" | tee -a /root/test.log
else
        echo "Size doesn't match" | tee -a /root/test.log
fi
done
end_time=$(date +%Y%m%d%H%M%S)
echo
echo "Start time:"
echo "$start_time"
echo "End time:"
echo "$end_time"
fi
mv test.log $3-$4-$5-$start_time-$end_time.csv

