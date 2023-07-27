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

#3000 Top Ports for ~99% completeness per Nmap docs
nmap -Pn --top-ports 3000 -n -vvv -iL $pth/livehosts -oA $pth/top3k

#Output webservers into file
echo -e "\nOutputting webservers into webservers.txt\n"
grep -ai "80\/open\|443\/open\|8443\/open\|8080\/open" top3k.gnmap | cut -d " " -f 2 > webservers.txt

#Run gowitness (make sure installed - add a check later)
echo -e "\nRunning gowitness on webservers\n"
gowitness file -f $pth/webservers.txt

#Output open ports into file
echo -e "\nFiltering open ports into open_ports.txt\n"
grep -ai "open" top3k.gnmap > open_ports.txt

echo -e "\nDone\n"
