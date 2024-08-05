#!/bin/bash
#Logging Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Active Logging"
  2 "Show Full Log"
  3 "IOS-XE PreCheck"
  4 "Meraki PreCheck"
  5 "Show Hostname Migration"
  6 "Search Log files"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "CMDS-Main Menu -->Log Search" \
  --menu "Please select" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_mon_switch/log_tail.sh ;;
  2) /root/.meraki_mon_switch/full_log.sh ;;
  3) /root/.meraki_mon_switch/show_ios-xe_pre-log.sh ;;
  4) /root/.meraki_mon_switch/show_pre_log.sh ;;
  5) /root/.meraki_mon_switch/show_hostnames_log.sh ;;
  6) /root/.meraki_mon_switch/log_search.sh ;;
  esac
done
clear # clear after user pressed Cancel
