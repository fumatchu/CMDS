#!/bin/bash
#Meraki Catalyst Monitoring Migration Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVERIP=$(hostname -I)

items=(1 "Setup Wizard"
  2 "-----------------------------------------------"
  3 "Data Collection and Clean File System Flash"
  4 "IOS-XE Version Check"
  5 "Deploy IOS-XE Image to WLC"
  6 "Install IOS-XE Update"
  7 "Deploy and Install IOS-XE Update"
  8 "-----------------------------------------------"
  9 "Onboard WLC to Meraki Dashboard"
 10 "Update Physical Address for WLC"
 11 "Update Physcial Address for AP(s)"
 12 "Batch Cleanup"
 13 "-----------------------------------------------"
 14 "Global Environment Settings"
 15 "Logs"
 16 "Utilities"
 17 "Scheduler"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Wireless Monitoring-->Main Menu" \
  --menu "Please select" 30 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & /root/.meraki_mon_wlc/setup_wizard.sh ;;
  2) clear ;;
  3) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/clean.sh ;;
  4) clear & /root/.meraki_mon_wlc/ios-xe-precheck.sh | tee -a /root/.meraki_mon_wlc/logs/ios-xe_precheck.log ;;
  5) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/deploy_img.sh ;;
  6) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/deploy.exp ;;
  7) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/deploy_all.sh ;;
  8) clear ;;
  9) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/check_baseline_wlc.sh | tee -a /root/.meraki_mon_wlc/logs/pre_check_deployment.log ;;
 10) clear &/root/.meraki_mon_wlc/update_physical_address_wlc.sh | tee -a /root/.meraki_mon_wlc/logs/physical_address.log ;;
 11) clear &/root/.meraki_mon_wlc/ap_phy_update.sh  | tee -a /root/.meraki_mon_wlc/logs/physical_address.log ;;
 12) clear & /root/.meraki_mon_wlc/batch_clean.sh ;;
 13) clear & /root/.meraki_mon_wlc/.logo ;;
 14) clear & /root/.meraki_mon_wlc/global_environment.sh ;;
 15) clear & /root/.meraki_mon_wlc/logging_environment.sh ;;
 16) clear & /root/.meraki_mon_wlc/utilities.sh ;;
 17) clear & /root/.meraki_mon_wlc/schedule.sh ;;
  esac
done
clear # clear after user pressed Cancel
