#!/bin/bash
#Modify Global Environment for switch, user, etc
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Change SSH User Login "
  2 "Change SSH password to switch"
  3 "Change Switch IP Address(es)"
  4 "Specify the Switch Image"
  5 "Update Server IP Address"
  6 "Update Meraki API Key"
  7 "Show all Settings"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "CMDS-Main Menu-->Global Settings" \
  --menu "Please select" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_mig/ssh_user_change.sh ;;
  2) /root/.meraki_mig/ssh_password_change.sh ;;
  3) nano /root/.meraki_mig/ip_list ;;
  4) /root/.meraki_mig/image_change.sh ;;
  5) /root/.meraki_mig/tftp_server_change.sh ;;
  6) /root/.meraki_mig/api_key.sh ;;
  7) /root/.meraki_mig/show_global.sh ;;
  esac
done
clear # clear after user pressed Cancel
