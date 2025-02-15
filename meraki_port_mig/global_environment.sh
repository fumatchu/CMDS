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
  4 "Update Server IP Address"
  5 "Show all Settings"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Migration to Dashboard-->Main Menu-->Global Environment Settings" \
  --menu "Please select" 30 75 30 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_port_mig/ssh_user_change.sh ;;
  2) /root/.meraki_port_mig/ssh_password_change.sh ;;
  3) nano /root/.meraki_port_mig/ip_list ;;
  4) /root/.meraki_port_mig/tftp_server_change.sh ;;
  5) /root/.meraki_port_mig/show_global.sh ;;
  esac
done
clear # clear after user pressed Cancel