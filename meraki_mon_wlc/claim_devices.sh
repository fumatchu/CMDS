#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
INPUT="/root/.meraki_mon_wlc/ip_list"
clear
echo "############################Collection time ${DATE}######################################"
cat <<EOF
${GREEN}Claiming WLC to Meraki Org${TEXTRESET}
This will take the newly registered WLC and claim it to your inventory in the Meraki Dashboard

EOF

read -p "Press Enter"

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo ${GREEN}"$IP"${TEXTRESET}
  echo " "
cat /var/lib/tftpboot/wlc/${IP}-sh-meraki-connect | grep -E -o "Q.{0,13}" >>/root/.meraki_mon_wlc/wlc_serials.txt
cat /var/lib/tftpboot/wlc/${IP}-sh-meraki-connect | grep -E -o "Q.{0,13}" >> /root/.meraki_mon_wlc/working.tmp
cat /var/lib/tftpboot/wlc/${IP} | grep hostname | sed 's/hostname //g' >> /root/.meraki_mon_wlc/working.tmp
awk '{if(NR%2==0) {print var,$0} else {var=$0}}' /root/.meraki_mon_wlc/working.tmp > /root/.meraki_mon_wlc/logs/hostnames2serial.log
done <"$INPUT"

clear

cat <<EOF
The server is going to claim the following ID:

EOF
cat /root/.meraki_mon_wlc/logs/hostnames2serial.log

cat <<EOF


This is the Serial Number of the WLC Directly.
All AP's that are supported, will be onboarded automatically into the Dashboard

If needed, please review the documentation (and supported AP's) at:
https://documentation.meraki.com/Cloud_Monitoring_for_Catalyst/Getting_Started/Cloud_Monitoring_for_Catalyst_Wireless_Requir
ements


The Next screen will provide a list of Organizations (if your API key is associated to more than one)
and allow you to join the serial number to the Organitzation of your choice.

${YELLOW}After claiming is complete, You Must Move the WLC from General inventory to the Network you wish to service for itself and the AP's.${TEXTRESET}

EOF
read -p "Press Enter"

clear
cat <<EOF
${GREEN}Select the Organization you would like to use${TEXTRESET}

EOF
python3 /root/.meraki_mon_wlc/claim_devices.py

clear
cat  << EOF
${GREEN}Hostname to Serial File Mappings${TEXTRESET}
If you have have onboarded more than one WLC, this is the list of hostnames to serial mappings.
EOF

cat /root/.meraki_mon_wlc/logs/hostnames2serial.log

cat << EOF

This will assist you in moving the correct WLC to Network you choose in the dashboard.
This file can also be accessed in ${YELLOW}Main Menu --> Logs -->Hostname/Serial Map${TEXTRESET}

EOF
read -p "Press Enter"
clear
#Clean Serials File
rm -f /root/.meraki_mon_wlc/wlc_serials.txt
rm -r -f /root/.meraki_mon_wlc/working.tmp

cat << EOF
Onboarding is Complete!

Please be sure to run
${YELLOW}Main Menu --> Update Physical Addresses for WLC${TEXTRESET}
${YELLOW}Main Menu --> Update Physical Addresses for AP${TEXTRESET}

Also, please be sure to run a batch cleanup after assigning Physical addresses
${YELLOW}Main Menu --> Batch Cleanup${TEXTRESET}

EOF

read -p "Press Enter"
