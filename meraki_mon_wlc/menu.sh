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
  8 "Migrate WLC Hostnames"
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
 19 "Setup Wizard"
 20 "Welcome to CMDS-Catalyst Wireless Monitoring"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Wireless Monitoring-->CMDS-->Main Menu-->" \
  --menu "Please select" 30 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/clean.sh ;;
  2) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/deploy_img.exp ;;
  3) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/deploy.exp ;;
  4) clear ;;
  5) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_mon_wlc/check_baseline_wlc.sh | tee -a /root/.meraki_mon_wlc/logs/pre_check_deployment.log ;;
  6) clear & /root/.meraki_mon_wlc/register_wlc_2_cloud.sh ;;
  7) /root/.meraki_mon_wlc/claim_devices.sh ;;
  8) /root/.meraki_mon_wlc/hostname_wlc_collection.sh ;;
  9) /root/.meraki_mon_wlc/update_physical_address_wlc.sh ;;
 10) /root/.meraki_mon_wlc/ap_phy_update.sh ;;
 11) clear & /root/.meraki_mon_wlc/enable_avc.sh ;;
 12) clear & /root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.sh ;;
 13) clear & /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.sh ;;
 14) /root/.meraki_mon_wlc/batch_clean.sh ;;
 15) /root/.meraki_mon_wlc/.logo ;;
 16) /root/.meraki_mon_wlc/global_environment.sh ;;
 17) /root/.meraki_mon_wlc/logging_environment.sh ;;
 18) /root/.meraki_mon_wlc/utilities.sh ;;
 19) /root/.meraki_mon_wlc/setup_wizard.sh ;;
 20) /root/.meraki_mig/welcome.readme | more ;;
  esac
done
clear # clear after user pressed Cancel
