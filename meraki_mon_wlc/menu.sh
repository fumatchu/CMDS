#!/bin/bash
#Meraki Catalyst Monitoring Migration Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVERIP=$(hostname -I)

items=(1 "Data Collection and Clean File System Flash"
  2 "Deploy IOS-XE Image to WLC"
  3 "Install IOS-XE Update"
  4 "-----------------------------------------------"
  5 "WLC Monitoring Setup"
  6 "Register WLC to Meraki Dashboard"
  7 "Claim WLC to Meraki Organization"
  8 "Update Physical Address for WLC"
  9 "Update Physcial Address for AP"
 10 "Enable AVC"
 11 "Check WLC Registration to Cloud"
 12 "Check AP registration to Cloud"
 13 "Batch Cleanup"
 14 "-----------------------------------------------"
 15 "Global Environment Settings"
 16 "Logs"
 17 "Utilities"
 18 "Setup Wizard"
 19 "Welcome to CMDS-Catalyst Wireless Monitoring"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Wireless Monitoring-->CMDS-->Main Menu" \
  --menu "Please select" 30 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/clean.sh ;;
  2) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/deploy_img.sh ;;
  3) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/deploy.exp ;;
  4) clear ;;
  5) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/check_baseline_wlc.sh | tee -a /root/.meraki_mon_wlc/logs/pre_check_deployment.log ;;
  6) clear & /root/.meraki_mon_wlc/register_wlc_2_cloud.sh | tee -a /root/.meraki_mon_wlc/logs/device_registration.log ;;
  7) /root/.meraki_mon_wlc/claim_devices.sh ;;
  8) /root/.meraki_mon_wlc/update_physical_address_wlc.sh | tee -a /root/.meraki_mon_wlc/logs/physical_address.log ;;
  9) /root/.meraki_mon_wlc/ap_phy_update.sh  | tee -a /root/.meraki_mon_wlc/logs/physical_address.log ;;
 10) clear & /root/.meraki_mon_wlc/enable_avc.sh | tee -a /root/.meraki_mon_wlc/logs/avc_enable.log ;;
 11) clear & /root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.sh ;;
 12) clear & /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.sh ;;
 13) /root/.meraki_mon_wlc/batch_clean.sh ;;
 14) /root/.meraki_mon_wlc/.logo ;;
 15) /root/.meraki_mon_wlc/global_environment.sh ;;
 16) /root/.meraki_mon_wlc/logging_environment.sh ;;
 17) /root/.meraki_mon_wlc/utilities.sh ;;
 18) clear & /root/.meraki_mon_wlc/setup_wizard.sh ;;
 19) /root/.meraki_mon_wlc/welcome.readme | more ;;
  esac
done
clear # clear after user pressed Cancel
