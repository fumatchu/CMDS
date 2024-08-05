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
  5 "-----------------------------------------------"
  6 "Meraki Pre-Check Collection"
  7 "Batch Cleanup"
  8 "-----------------------------------------------"
  9 "Global Environment Settings"
 10 "Schedule Deployment"
 11 "Logs"
 12 "Utilities"
 13 "Setup Wizard"
 14 "Welcome to CMDS"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Monitoring PreCheck -->Main Menu" \
  --menu "Please select" 30 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/clean.exp ;;
  2) clear & /root/.meraki_mon_switch/ios-xe-precheck.sh | tee -a /root/.meraki_mon_switch/logs/ios-xe_precheck.log ;;
  3) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/deploy_img.sh ;;
  4) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/deploy.sh ;;
  5) clear ;;
  6) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_switch/check_baseline_switch.sh | tee -a /root/.meraki_mon_switch/logs/pre_check_deployment.log ;;
  7) /root/.meraki_mon_switch/batch_clean.sh ;;
  8) /root/.meraki_mon_switch/.logo ;;
  9) /root/.meraki_mon_switch/global_environment.sh ;;
 10) /root/.meraki_mon_switch/schedule.sh ;;
 11) /root/.meraki_mon_switch/logging_environment.sh ;;
 12) /root/.meraki_mon_switch/utilities.sh ;;
 13) /root/.meraki_mon_switch/setup_wizard.sh ;;
 14) /root/.meraki_mon_switch/welcome.readme | more ;;
  esac
done
clear # clear after user pressed Cancel
