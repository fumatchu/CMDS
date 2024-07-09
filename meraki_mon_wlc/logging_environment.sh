#!/bin/bash
#Logging Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Active Logging"
  2 "Show Full Log"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Wireless Monitoring-->CMDS-->Main Menu-->Log Search" \
  --menu "Please select" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_mon_wlc/log_tail ;;
  2) /root/.meraki_mon_wlc/full_log.sh ;;
  esac
done
clear # clear after user pressed Cancel
