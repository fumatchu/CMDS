#!/bin/bash
#Meraki C9300 Migration Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVERIP=$(hostname -I)

items=(1 "Update all AP(s) to same Physical Address"
  2 "Update Some AP's to Physical Address"
  3 "Create AP Inventory Sheet for Download"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "CMDS-->Main Menu" \
  --menu "Please select" 30 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & /root/.meraki_mon_wlc/update_physical_address_ap.sh ;;
  2) clear & /root/.meraki_mon_wlc/update_physical_address_ap_selective.sh ;;
  3) clear & /root/.meraki_mon_wlc/create_inventory.sh ;;
  esac
done
clear # clear after user pressed Cancel

