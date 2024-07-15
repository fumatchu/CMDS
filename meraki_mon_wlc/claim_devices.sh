#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear
echo "############################Collection time ${DATE}######################################"
cat <<EOF
${GREEN}Claiming WLC to Meraki Org${TEXTRESET}
This will take the newly registered WLC and claim it to your inventory in the Meraki Dashboard

EOF

read -p "Press Any Key"

more /var/lib/tftpboot/wlc/sh-meraki-connect | grep -E -o "Q.{0,13}" >>/root/.meraki_mon_wlc/wlc_serials.txt

clear

cat <<EOF
The server is going to claim the following ID:

EOF
cat /root/.meraki_mon_wlc/wlc_serials.txt

cat <<EOF


This is the Serial Number of the WLC Directly.
All AP's that are supported, will be onboarded automatically into the Dashboard

If needed, please review the documentation (and supported AP's) at:
https://documentation.meraki.com/Cloud_Monitoring_for_Catalyst/Getting_Started/Cloud_Monitoring_for_Catalyst_Wireless_Requirements


The Next screen will provide a list of Organizations (if your API key is associated to more than one)
and allow you to join the serial number to the Organitzation of your choice.

${YELLOW}After claiming is complete, You Must Move the WLC from General inventory to the Network you wish to service for itself and the AP's.${TEXTRESET}

EOF
read -p "Press Any Key"

clear
cat <<EOF
${GREEN}Select the Organization you would like to use${TEXTRESET}

EOF
python3 /root/.meraki_mon_wlc/claim_devices.py

#Clean Serials File
rm -f /root/.meraki_mon_wlc/wlc_serials.txt
