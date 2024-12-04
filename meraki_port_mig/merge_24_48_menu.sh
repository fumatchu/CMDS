#!/bin/bash
#Modify Global Environment for switch, user, etc
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Create CSV for Port Merge"
  2 "Import CSV/Staging"
  3 "Port Migration"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Migration to Dashboard-->Main Menu-->Global Environment Settings" \
  --menu "Please select" 30 75 30 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_port_mig/port_merge_collection.sh ;;
  2) /root/.meraki_port_mig/create_serial_file_port_merge.sh;;
  3) /root/.meraki_port_mig/merge_switches_nfe.sh;;
  esac
done
clear # clear after user pressed Cancel
