#!/bin/bash
#Meraki C9300 Migration Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVERIP=$(hostname -I)

items=(1 "Data Collection and Clean File System Flash"
  2 "IOS-XE Pre-Check"
  3 "Deploy IOS-XE Image to Switch"
  4 "Install IOS-XE Update"
  5 "Deploy and Install Update"
  6 "-----------------------------------------------"
  7 "Validate Switch Software/Hardware Configuration/Deploy"
  8 "Update Physical Address"
  9 "Deploy Access Template to Downlink Ports (Quick Deploy)"
 10 "Template Deployment"
 11 "Batch Cleanup"
 12 "-----------------------------------------------"
 13 "Global Environment Settings"
 14 "Schedule Deployment"
 15 "Logs"
 16 "Utilities"
 17 "Setup Wizard"
 18 "Welcome to CMDS"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Migration to Dashboard-->Main Menu" \
  --menu "Please select" 30 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/clean.exp ;;
  2) clear & /root/.meraki_mig/pre-check_IOS-XE.sh | tee -a /root/.meraki_mig/logs/ios-xe_pre_check_deployment.log ;;
  3) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/deploy_img.exp ;;
  4) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/deploy.exp ;;
  5) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/deploy_all.sh ;;
  6) clear ;;
  7) clear & /root/.meraki_mig/deploy_check.sh | tee -a /root/.meraki_mig/logs/soft_hard_check_deployment.log ;;
  8) clear &/root/.meraki_mig/update_physical_address_switch.sh
  9) /root/.meraki_mig/port_deploy.sh ;;
 10) /root/.meraki_mig/adv_template.sh ;;
 11) /root/.meraki_mig/batch_clean.sh ;;
 12) /root/.meraki_mig/.logo ;;
 13) /root/.meraki_mig/global_environment.sh ;;
 14) /root/.meraki_mig/schedule.sh ;;
 15) /root/.meraki_mig/logging_environment.sh ;;
 16) /root/.meraki_mig/utilities.sh ;;
 17) /root/.meraki_mig/wizard.sh ;;
 18) /root/.meraki_mig/welcome.readme | more ;;
  esac
done
clear # clear after user pressed Cancel
