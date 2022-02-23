#!/bin/bash

printf "\n"

if [ "$#" -ne 1 ]
then
        echo "Usage: Please supply the domain (e.g., tesla.com)"
        exit 1
else
        url=$1
fi


if [ ! -d "/opt/osint/recon/" ]
then
        echo "Creating directories /opt/osint/recon"
        mkdir -p /opt/osint/recon/
fi

if ! [ -x "$(command -v assetfinder)" ]
then 
        echo "Error: Assetfinder is not installed. Please install it."
        exit 1
fi


echo "[+][+][+] Harvesting subdomains for $url [+][+][+]"
assetfinder $url > /opt/osint/recon/assets.txt
assets=$(wc -l /opt/osint/recon/assets.txt | cut -d " " -f 1)

printf "\n"
echo "Harvested $assets subdomains for $url"
printf "\n"

if ! [ -x "$(command -v httprobe)" ]
then 
        echo "Error: Httprobe is not installed. Please install it."
        exit 1
fi

echo "[+][+][+] Identifying live domains for $url [+][+][+]"
cat /opt/osint/recon/assets.txt | httprobe > /opt/osint/recon/alive.txt
alive=$(wc -l /opt/osint/recon/alive.txt | cut -d " " -f 1)

printf "\n"
echo "Identified $alive live domains"
printf "\n"
echo "Done. Happy testing!"
