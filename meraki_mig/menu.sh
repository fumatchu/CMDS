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
  7 "Validate Switch Software/Hardware Configuration"
  8 "Register Catalyst Switch to Meraki Dashboard"
  9 "Claim Inventory/Serials to Organization"
 10 "Migrate Hostnames"
 11 "Update Physical Address and Move Map Marker"
 12 "Deploy Access Template to Downlink Ports (Quick Deploy)"
 13 "Template Deployment"
 14 "Batch Cleanup"
 15 "-----------------------------------------------"
 16 "Global Environment Settings"
 17 "Schedule Deployment"
 18 "Logs"
 19 "Utilities"
 20 "Setup Wizard"
 21 "Welcome to CMDS"
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
  8) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/meraki_register.exp ;;
  9) /root/.meraki_mig/show_inv.sh ;;
 10) /root/.meraki_mig/hostname_collection.sh | tee -a /root/.meraki_mig/logs/hostname_deployment.log ;;
 11) clear & /root/.meraki_mig/update_physical_address_switch.sh ;;
 12) /root/.meraki_mig/port_deploy.sh ;;
 13) /root/.meraki_mig/adv_template.sh ;;
 14) /root/.meraki_mig/batch_clean.sh ;;
 15) /root/.meraki_mig/.logo ;;
 16) /root/.meraki_mig/global_environment.sh ;;
 17) /root/.meraki_mig/schedule.sh ;;
 18) /root/.meraki_mig/logging_environment.sh ;;
 19) /root/.meraki_mig/utilities.sh ;;
 20) /root/.meraki_mig/wizard.sh ;;
 21) /root/.meraki_mig/welcome.readme | more ;;
  esac
done
clear # clear after user pressed Cancel
