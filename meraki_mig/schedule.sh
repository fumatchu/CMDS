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
  4 "Schedule Meraki Register and Reboot Switch"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "MMU- Main Menu -->Scheduler" \
  --menu "Please select" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_mig/schedule_clean.sh ;;
  2) /root/.meraki_mig/schedule_deploy_img.exp ;;
  3) /root/.meraki_mig/schedule_deploy.exp ;;
  4) /root/.meraki_mig/schedule_meraki_register.exp ;;
  esac
done
clear # clear after user pressed Cancel
