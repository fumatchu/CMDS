#!/bin/bash
#Scheduling Menu for after hours work
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Data Collection and Inactive File Removal "
  2 "Schedule IOS-XE Image Deployment"
  3 "Schedule IOS-XE Upgrade"
  4 "Schedule IOS-XE Image Deployment and Upgrade"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Monitoring for Switching Prep Tool-->Main Menu-->Scheduler" \
  --menu "Please select" 30 75 30 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_mon_switch/schedule_clean.sh ;;
  2) /root/.meraki_mon_switch/schedule_deploy_img.sh ;;
  3) /root/.meraki_mon_switch/schedule_deploy.sh ;;
  4) /root/.meraki_mon_switch/schedule_up_and_deploy.sh ;;
  esac
done
clear # clear after user pressed Cancel
