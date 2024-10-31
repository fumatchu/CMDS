#!/bin/bash
#Meraki C9300 Migration Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVERIP=$(hostname -I)

items=(1 "Setup Wizard"
  2 "-----------------------------------------------"
  3 "Data Collection and Clean File System Flash"
  4 "IOS-XE Pre-Check"
  5 "Deploy IOS-XE Image to Switch"
  6 "Install IOS-XE Update"
  7 "Deploy and Install Update"
  8 "-----------------------------------------------"
  9 "Validate Switch/Deploy"
 10 "Update Physical Address"
 11 "Migrate Port configurations"
 12 "Template Deployment"
 13 "Batch Cleanup"
 14 "-----------------------------------------------"
 15 "Global Environment Settings"
 16 "Schedule Deployment"
 17 "Logs"
 18 "Utilities"
 19 "Welcome to CMDS"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Migration to Dashboard-->Main Menu" \
  --menu "Please select" 30 75 30 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear &/root/.meraki_mig/wizard.sh ;;
  2) clear ;;
  3) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/clean.exp ;;
  4) clear & /root/.meraki_mig/ios-xe-precheck.sh | tee -a /root/.meraki_mig/logs/ios-xe_pre_check_deployment.log ;;
  5) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/deploy_img.exp ;;
  6) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/deploy.exp ;;
  7) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/deploy_all.sh ;;
  8) clear ;;
  9) clear & /root/.meraki_mig/deploy_check.sh | tee -a /root/.meraki_mig/logs/soft_hard_check_deployment.log ;;
 10) clear & /root/.meraki_mig/update_physical_address_switch.sh ;;
 11) clear & /root/.meraki_mig/port_migration.sh | tee -a /root/.meraki_mig/logs/port_migration.log ;;
 12) clear & /root/.meraki_mig/adv_template.sh ;;
 13) clear & /root/.meraki_mig/batch_clean.sh ;;
 14) clear & /root/.meraki_mig/.logo ;;
 15) clear & /root/.meraki_mig/global_environment.sh ;;
 16) clear & /root/.meraki_mig/schedule.sh ;;
 17) clear & /root/.meraki_mig/logging_environment.sh ;;
 18) clear & /root/.meraki_mig/utilities.sh ;;
 19) clear & /root/.meraki_mig/welcome.readme | more ;;
  esac
done
clear # clear after user pressed Cancel
