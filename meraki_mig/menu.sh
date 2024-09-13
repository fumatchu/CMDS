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
  7 "Meraki Pre-Check Collection"
  8 "Validate Switch Software/Hardware Configuration"
  9 "Register Catalyst Switch to Meraki Dashboard"
 10 "Show converted Meraki ID"
 11 "Claim Inventory/Serials to Organization"
 12 "Migrate Hostnames"
 13 "Update Physical Address and Move Map Marker"
 14 "Deploy Access Template to Downlink Ports (Quick Deploy)"
 15 "Template Deployment"
 16 "Batch Cleanup"
 17 "-----------------------------------------------"
 18 "Global Environment Settings"
 19 "Schedule Deployment"
 20 "Logs"
 21 "Utilities"
 22 "Setup Wizard"
 23 "Welcome to CMDS"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Migration to Dashboard-->Main Menu" \
  --menu "Please select" 30 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/clean ;;
  2) clear & /root/.meraki_mig/pre-check_IOS-XE.sh | tee -a /root/.meraki_mig/logs/ios-xe_pre_check_deployment.log ;;
  3) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/deploy_img.exp ;;
  4) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/deploy.exp ;;
  5) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/deploy_all.sh ;;
  6) clear ;;
  6) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/meraki_compat_check.sh | tee -a /root/.meraki_mig/logs/pre_check_deployment.log ;;
  7) clear & /root/.meraki_mig/deploy_check.sh | tee -a /root/.meraki_mig/logs/soft_hard_check_deployment.log ;;
  8) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mig/meraki_register.exp ;;
  9) /root/.meraki_mig/show_meraki_id.sh ;;
 10) /root/.meraki_mig/show_inv.sh ;;
 11) /root/.meraki_mig/hostname_collection.sh | tee -a /root/.meraki_mig/logs/hostname_deployment.log ;;
 12) clear & /root/.meraki_mig/update_physical_address_switch.sh ;;
 13) /root/.meraki_mig/port_deploy.sh ;;
 14) /root/.meraki_mig/adv_template.sh ;;
 15) /root/.meraki_mig/batch_clean.sh ;;
 16) /root/.meraki_mig/.logo ;;
 17) /root/.meraki_mig/global_environment.sh ;;
 18) /root/.meraki_mig/schedule.sh ;;
 19) /root/.meraki_mig/logging_environment.sh ;;
 20) /root/.meraki_mig/utilities.sh ;;
 21) /root/.meraki_mig/wizard.sh ;;
 22) /root/.meraki_mig/welcome.readme | more ;;
  esac
done
clear # clear after user pressed Cancel
