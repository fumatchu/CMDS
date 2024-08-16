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
  5 "-----------------------------------------------"
  6 "Meraki Pre-Check Collection"
  7 "Validate Switch Software/Hardware Configuration"
  8 "Register Catalyst Switch to Meraki Dashboard"
  9 "Show converted Meraki ID"
 10 "Claim Inventory/Serials to Organization"
 11 "Migrate Hostnames"
 12 "Update Physical Address and Move Map Marker"
 13 "Deploy Access Template to Downlink Ports (Quick Deploy)"
 14 "Template Deployment"
 15 "Batch Cleanup"
 16 "-----------------------------------------------"
 17 "Global Environment Settings"
 18 "Schedule Deployment"
 19 "Logs"
 20 "Utilities"
 21 "Setup Wizard"
 22 "Welcome to CMDS"
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
  5) clear ;;
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
