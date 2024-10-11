#!/bin/bash
#Modify Global Environment for switch, user, etc
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Change SSH User Login "
  2 "Change SSH password to switch"
  3 "Update Batch IP Address(es)"
  4 "Specify the Switch Image"
  5 "Update Server IP Address"
  6 "Show all Settings"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Monitoring for Switching Prep Tool-->Main Menu-->Global Environment Settings" \
  --menu "Please select" 30 75 30 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_mon_switch/ssh_user_change.sh ;;
  2) /root/.meraki_mon_switch/ssh_password_change.sh ;;
  3) nano /root/.meraki_mon_switch/ip_list ;;
  4) /root/.meraki_mon_switch/image_change.sh ;;
  5) /root/.meraki_mon_switch/tftp_server_change.sh ;;
  6) /root/.meraki_mon_switch/show_global.sh ;;
  esac
done
clear # clear after user pressed Cancel
