#!/bin/bash
#Meraki C9300 Migration Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVERIP=$(hostname -I)

items=(1 "Data Collection and Clean File System Flash"
  2 "IOS-XE Version Check"
  3 "Deploy IOS-XE Image to Switch"
  4 "Install IOS-XE Update"
  5 "Deploy IOS-XE and Install Update"
  6 "-----------------------------------------------"
  7 "Meraki Pre-Check Collection"
  8 "Download Cloud Monitoring for Catalyst Application"
  9 "Batch Cleanup"
 10 "-----------------------------------------------"
 11 "Global Environment Settings"
 12 "Schedule Deployment"
 13 "Logs"
 14 "Utilities"
 15 "Setup Wizard"
 16 "Welcome to CMDS"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Monitoring for Switching Prep Tool-->Main Menu" \
  --menu "Please select" 30 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/clean.exp ;;
  2) clear & /root/.meraki_mon_switch/ios-xe-precheck.sh | tee -a /root/.meraki_mon_switch/logs/ios-xe_precheck.log ;;
  3) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/deploy_img.sh ;;
  4) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/deploy.sh ;;
  5) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/deploy_all.sh ;;
  6) clear ;;
  7) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/check_baseline_switch.sh | tee -a /root/.meraki_mon_switch/logs/pre_check_deployment.log ;;
  8) clear & /root/.meraki_mon_switch/download_client.sh ;;
  9) /root/.meraki_mon_switch/batch_clean.sh ;;
 10) /root/.meraki_mon_switch/.logo ;;
 11) /root/.meraki_mon_switch/global_environment.sh ;;
 12) /root/.meraki_mon_switch/schedule.sh ;;
 13) /root/.meraki_mon_switch/logging_environment.sh ;;
 14) /root/.meraki_mon_switch/utilities.sh ;;
 15) /root/.meraki_mon_switch/setup_wizard.sh ;;
 16) /root/.meraki_mon_switch/welcome.readme | more ;;
  esac
done
clear # clear after user pressed Cancel
