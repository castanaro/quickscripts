## About

A repository of tools/scripts that I find useful during penetration tests to help automate tasks

## Usage

### SUBHUNT.SH
./subhunt.sh [target domain]

subhunt.sh uses assetfinder (https://github.com/tomnomnom/assetfinder) and httprobe (https://github.com/tomnomnom/httprobe) to scan for live subdomains for a target domain.

Please download those tools before running.

### LIVEHOSTS.SH

./livehosts.sh [targets file]

Please name the target input file as "targets" which includes scope.

### SCAN.SH

./scan.sh [targets file]

Please name the target input file as "targets" which includes scope. Similar to livehosts.sh, scan.sh identifies live hosts on the network and then attempts an nmap scan for specified ports on those hosts.

### SMBLOOP

This command takes a username and password from a list and enumerates the shares (provided within another list) they can access on a supplied domain.

### IPRANGECHECKER.PY

python3 ipRangeChecker.py ranges.txt cidrs.txt
python3 ipRangeChecker.py ranges.txt 192.168.10.0/24

This script takes a file containing IP addresses and determines if they are in range of a supplied single CIDR range or file containing multiple CIDR ranges.
