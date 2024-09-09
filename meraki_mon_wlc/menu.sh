#!/bin/bash
#Meraki Catalyst Monitoring Migration Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVERIP=$(hostname -I)

items=(1 "Data Collection and Clean File System Flash"
  2 "IOS-XE Version Check"
  3 "Deploy IOS-XE Image to WLC"
  4 "Install IOS-XE Update"
  5 "Deploy and Install IOS-XE Update"
  6 "-----------------------------------------------"
  7 "Onboard WLC to Meraki Dashboard"
 10 "Update Physical Address for WLC"
 11 "Update Physcial Address for AP(s)"
 12 "Batch Cleanup"
 13 "-----------------------------------------------"
 14 "Global Environment Settings"
 15 "Logs"
 16 "Utilities"
 17 "Scheduler"
 18 "Setup Wizard"
 19 "Welcome to CMDS-Catalyst Wireless Monitoring"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Wireless Monitoring-->Main Menu" \
  --menu "Please select" 30 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/clean.sh ;;
  2) clear & /root/.meraki_mon_wlc/ios-xe-precheck.sh | tee -a /root/.meraki_mon_wlc/logs/ios-xe_precheck.log ;;
  3) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/deploy_img.sh ;;
  4) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/deploy.exp ;;
  5) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/deploy_all.sh ;;
  6) clear ;;
  7) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/check_baseline_wlc.sh | tee -a /root/.meraki_mon_wlc/logs/pre_check_deployment.log ;;
 10) clear &/root/.meraki_mon_wlc/update_physical_address_wlc.sh | tee -a /root/.meraki_mon_wlc/logs/physical_address.log ;;
 11) clear &/root/.meraki_mon_wlc/ap_phy_update.sh  | tee -a /root/.meraki_mon_wlc/logs/physical_address.log ;;
 12) clear & /root/.meraki_mon_wlc/batch_clean.sh ;;
 13) clear & /root/.meraki_mon_wlc/.logo ;;
 14) clear & /root/.meraki_mon_wlc/global_environment.sh ;;
 15) clear & /root/.meraki_mon_wlc/logging_environment.sh ;;
 16) clear & /root/.meraki_mon_wlc/utilities.sh ;;
 17) clear & /root/.meraki_mon_wlc/schedule.sh ;;
 18) clear & /root/.meraki_mon_wlc/setup_wizard.sh ;;
 19) clear & /root/.meraki_mon_wlc/welcome.readme | more ;;
  esac
done
clear # clear after user pressed Cancel
