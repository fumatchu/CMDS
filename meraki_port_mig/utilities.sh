#!/bin/bash
#Utilities Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Create Switch Network on Dashboard"
  2 "Network Discovery"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Migration to Dashboard-->Main Menu-->Utilities" \
  --menu "Please select" 30 75 30 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & python3.10 /root/.meraki_port_mig/make_network_switch.py ;;
  2) clear & /root/.meraki_port_mig/network_discovery.sh ;;
  esac
done
clear # clear after user pressed Cancel