#!/bin/bash
#Meraki Port Migration Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVERIP=$(hostname -I)
items=(1 "Setup Wizard"
  2 "-----------------------------------------------"
  3 "Data Collection"
  4 "Create CSV for Inventory"
  5 "Merge 24 port to 48 port"
  8 "-----------------------------------------------"
  9 "Import CSV/Staging"
 10 "Claim Devices"
 11 "Update Physical Address"
 12 "Update Hostnames"
 13 "Port Migration"
 14 "Batch Cleanup"
 15 "-----------------------------------------------"
 16 "Global Environment Settings"
 17 "Schedule Deployment"
 18 "Logs"
 19 "Utilities"
 20 "Welcome to CMDS"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Port Migration to Dashboard-->Main Menu-BETA" \
  --menu "Please select- **BETA-BETA-BETA**" 30 75 30 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear &/root/.meraki_port_mig/wizard.sh ;;
  2) clear ;;
  3) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_port_mig/clean.exp ;;
  4) clear & /root/.meraki_port_mig/switch_collection.sh ;;
  5) clear & /root/.meraki_port_mig/merge_switches.sh ;;
  8) clear ;;
  9) clear & /root/.meraki_port_mig/create_serial_file.sh | tee -a /root/.meraki_port_mig/logs/serialfile_creation.log ;;
 10) clear & /root/.meraki_port_mig/show_inv_claim.sh | tee -a /root/.meraki_port_mig/logs/claim.log ;;
 11) clear & /root/.meraki_port_mig/update_physical_address_switch.sh | tee -a /root/.meraki_port_mig/logs/address.log ;;
 12) clear & /root/.meraki_port_mig/hostname_collection.sh | tee -a /root/.meraki_port_mig/logs/hostname.log ;;
 13) clear & /root/.meraki_port_mig/port_migration.sh | tee -a /root/.meraki_port_mig/logs/port_migration.log ;;
 14) clear & /root/.meraki_port_mig/batch_clean.sh ;;
 15) clear ;;
 16) clear & /root/.meraki_port_mig/global_environment.sh ;;
 17) clear & /root/.meraki_port_mig/schedule.sh ;;
 18) clear & /root/.meraki_port_mig/logging_environment.sh ;;
 19) clear & /root/.meraki_port_mig/utilities.sh ;;
 20) clear & /root/.meraki_port_mig/welcome.readme | more ;;
  esac
done
clear # clear after user pressed Cancel
