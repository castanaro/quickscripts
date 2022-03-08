#!/bin/bash

#set variable to current dir
pth=`pwd`

echo -e "---- BEGIN HOST DISCOVERY ----\n"

# HOST DISCOVERY with ICMP echo, timestamp, and netmask
echo -e "\nPingsweep using ICMP echo (1/4)\n"
nmap -sP -PE -iL $pth/targets -oA $pth/icmpecho
cat $pth/icmpecho.gnmap | grep Up | cut -d ' ' -f 2 > $pth/live

echo -e "\nPingsweep using ICMP timestamp (2/4)\n"
nmap -sP -PP -iL $pth/targets -oA $pth/icmptimestamp
cat $pth/icmptimestamp.gnmap | grep Up | cut -d ' ' -f 2 >> $pth/live

echo -e "\nPingsweep using ICMP netmask (3/4)\n"
nmap -sP -PM -iL $pth/targets -oA $pth/icmpnetmask
cat $pth/icmpnetmask.gnmap | grep Up | cut -d ' ' -f 2 >> $pth/live

# HOST DISCOVERY with Pingsweep using TCP SYN and UDP
echo -e "\nPingsweep using TCP SYN and UDP (4/4)\n"
nmap -sn -PS21,22,23,25,53,80,88,110,111,135,139,443,445,8080 -iL $pth/targets -oA $pth/pingsweepTCP
nmap -sn -PU53,111,135,137,161,500 -iL $pth/targets -oA $pth/pingsweepUDP
cat $pth/pingsweepTCP.gnmap | grep Up | cut -d ' ' -f 2 >> $pth/live
cat $pth/pingsweepUDP.gnmap | grep Up | cut -d ' ' -f 2 >> $pth/live

#Create unique live hosts file
cat $pth/live | sort | uniq > $pth/livehosts
