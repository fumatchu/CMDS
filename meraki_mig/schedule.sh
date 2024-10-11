#!/bin/bash
#Scheduling Menu for after hours work
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Schedule IOS-XE Image Deployment"
  2 "Schedule IOS-XE Upgrade"
  3 "Schedue IOS-XE Image Deployment and Upgrade"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Migration to Dashboard-->Main Menu-->Scheduler" \
  --menu "Please select" 30 75 30 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_mig/schedule_deploy_img.exp ;;
  2) /root/.meraki_mig/schedule_deploy.exp ;;
  3) /root/.meraki_mig/schedule_deploy_all.sh ;;
  esac
done
clear # clear after user pressed Cancel
