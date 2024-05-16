#!/bin/bash
#Change SSH User Credentials
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
${TEXTRESET}

EOF
read -p "Press Any Key to claim your devices into general inventory"
clear
python3 /root/.meraki_mig/claim_devices.py

sleep 4
