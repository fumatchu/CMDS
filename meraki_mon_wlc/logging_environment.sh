#!/bin/bash
#Logging Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Active Logging"
  2 "Show Full Log"
  3 "Monitoring Setup Log"
  4 "WLC Registration Log"
  5 "Physical Address Updates"
  6 "AVC Enablement"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Wireless Monitoring-->CMDS-->Main Menu-->Log Search" \
  --menu "Please select" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_mon_wlc/log_tail ;;
  2) /root/.meraki_mon_wlc/full_log.sh ;;
  3) /root/.meraki_mon_wlc/pre_check_log.sh ;;
  4) /root/.meraki_mon_wlc/device_registration_log.sh ;;
  5) /root/.meraki_mon_wlc/physical_address_log.sh ;;
  6) /root/.meraki_mon_wlc/avc_enable_log.sh ;;
  esac
done
clear # clear after user pressed Cancel
