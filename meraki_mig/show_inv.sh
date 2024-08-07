#!/bin/bash
#Query show meraki output to serials
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Current converted Switches${TEXTRESET}

The following serial numbers are going to be claimed and put into general inventory

EOF
cat /var/lib/tftpboot/*-shmr | grep -E -o "Q.{0,13}"
cat /var/lib/tftpboot/*-shmr | grep -E -o "Q.{0,13}" >/root/.meraki_mig/switch_serials.txt
cat <<EOF

You will be presented with an organizational list, if more than one organization is associated to your API Key.
The next screen will allow you to select it.

${YELLOW}
After you have claimed your devices, please login to your dashboard and place the inventory
in the correct networks before proceeding to the next step in the menu (Migrate Hostnames)
This can be accomplished by selecting Organization --> Inventory, Search for 9300
Find the newly entered devices, select their checkbox, then Change Network Assignment
${TEXTRESET}

EOF
read -p "Press Enter to claim your devices into general inventory"
clear
echo ${GREEN}"Select your Organization from the List Below"${TEXTRESET}
python3 /root/.meraki_mig/claim_devices.py

sleep 4
