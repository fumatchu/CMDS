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
  5 "-----------------------------------------------"
  6 "Meraki Pre-Check"
  7 "Register WLC to Meraki Dashboard"
  8 "Claim WLC to Meraki Organization"
  9 "Update Physical Address for WLC"
 10 "Update Physcial Address for AP"
 11 "Enable AVC"
 12 "Check WLC Registration to Cloud"
 13 "Check AP registration to Cloud"
 14 "Batch Cleanup"
 15 "-----------------------------------------------"
 16 "Global Environment Settings"
 17 "Logs"
 18 "Utilities"
 19 "Scheduler"
 20 "Setup Wizard"
 21 "Welcome to CMDS-Catalyst Wireless Monitoring"
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
  5) clear ;;
  6) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/check_baseline_wlc.sh | tee -a /root/.meraki_mon_wlc/logs/pre_check_deployment.log ;;
  7) clear & /root/.meraki_mon_wlc/register_wlc_2_cloud.sh | tee -a /root/.meraki_mon_wlc/logs/device_registration.log ;;
  8) clear & /root/.meraki_mon_wlc/claim_devices.sh ;;
  9) clear &/root/.meraki_mon_wlc/update_physical_address_wlc.sh | tee -a /root/.meraki_mon_wlc/logs/physical_address.log ;;
 10) clear &/root/.meraki_mon_wlc/ap_phy_update.sh  | tee -a /root/.meraki_mon_wlc/logs/physical_address.log ;;
 11) clear & /root/.meraki_mon_wlc/enable_avc.sh | tee -a /root/.meraki_mon_wlc/logs/avc_enable.log ;;
 12) clear & /root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.sh ;;
 13) clear & /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.sh ;;
 14) clear & /root/.meraki_mon_wlc/batch_clean.sh ;;
 15) clear & /root/.meraki_mon_wlc/.logo ;;
 16) clear & /root/.meraki_mon_wlc/global_environment.sh ;;
 17) clear & /root/.meraki_mon_wlc/logging_environment.sh ;;
 18) clear & /root/.meraki_mon_wlc/utilities.sh ;;
 19) clear & /root/.meraki_mon_wlc/schedule.sh ;;
 20) clear & /root/.meraki_mon_wlc/setup_wizard.sh ;;
 21) clear & /root/.meraki_mon_wlc/welcome.readme | more ;;
  esac
done
clear # clear after user pressed Cancel
