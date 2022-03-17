## About

A repository of tools/scripts that I find useful during penetration tests to help automate tasks

## Usage

### SPELUNKER.SH
./spelunker.sh [target domain]

spelunker.sh uses assetfinder (https://github.com/tomnomnom/assetfinder) and httprobe (https://github.com/tomnomnom/httprobe) to scan for live subdomains for a target domain.

Please download those tools before running spelunker.sh.

### LIVEHOSTS.SH

./livehosts.sh [targets file]

Please name the target input file as "targets"

### SMBMAP NESTED FOR LOOP

This script takes a username and password from a list and enumerates the shares (provided within another list) they can access on a supplied domain.
