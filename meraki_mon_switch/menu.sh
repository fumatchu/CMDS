#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVERIP=$(hostname -I)

items=(1 "Setup Wizard"
  2 "-----------------------------------------------"
  3 "Data Collection and Clean File System Flash"
  4 "IOS-XE Version Check"
  5 "Deploy IOS-XE Image to Switch"
  6 "Install IOS-XE Update"
  7 "Deploy IOS-XE and Install Update"
  8 "-----------------------------------------------"
  9 "Meraki Pre-Check Collection"
 10 "Batch Cleanup"
 11 "-----------------------------------------------"
 12 "Global Environment Settings"
 13 "Schedule Deployment"
 14 "Logs"
 15 "Utilities"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Monitoring for Switching Prep Tool-->Main Menu" \
  --menu "Please select" 30 75 30 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & /root/.meraki_mon_switch/setup_wizard.sh ;;
  2) clear ;;

  3) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/clean.exp ;;
  4) clear & /root/.meraki_mon_switch/ios-xe-precheck.sh | tee -a /root/.meraki_mon_switch/logs/ios-xe_precheck.log ;;
  5) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/deploy_img.sh ;;
  6) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/deploy.sh ;;
  7) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/deploy_all.sh ;;
  8) clear ;;
  9) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/check_baseline_switch.sh | tee -a /root/.meraki_mon_switch/logs/pre_check_deployment.log ;;
 10) clear & /root/.meraki_mon_switch/batch_clean.sh ;;
 11) clear & /root/.meraki_mon_switch/.logo ;;
 12) clear & /root/.meraki_mon_switch/global_environment.sh ;;
 13) clear & /root/.meraki_mon_switch/schedule.sh ;;
 14) clear & /root/.meraki_mon_switch/logging_environment.sh ;;
 15) clear & /root/.meraki_mon_switch/utilities.sh ;;
  esac
done
clear # clear after user pressed Cancel
