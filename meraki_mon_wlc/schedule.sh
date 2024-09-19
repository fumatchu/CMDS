#!/bin/bash
#Scheduling Menu for after hours work
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Schedule IOS-XE Image Deployment"
       2 "Schedule IOS-XE Image Deployment and Upgrade"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Monitoring for Wireless-->Main Menu-->Scheduler" \
  --menu "Please select" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_mon_wlc/schedule_deploy_img.sh ;;
  2) /root/.meraki_mon_wlc/schedule_deploy_all.sh ;;
  esac
done
clear # clear after user pressed Cancel
