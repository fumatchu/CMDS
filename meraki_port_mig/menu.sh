#!/bin/bash
#Meraki Port Migration Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVERIP=$(hostname -I)
echo "THIS IS BETA"
sleep 5
items=(1 "Setup Wizard"
  2 "-----------------------------------------------"
  3 "Data Collection"
  4 "Create CSV for Inventory"
  8 "-----------------------------------------------"
  9 "Validate Switch/Deploy"
 10 "Update Physical Address"
 11 "Deploy Access Template to Downlink Ports (Quick Deploy)"
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
  --backtitle "Catalyst Port Migration to Dashboard-->Main Menu-BETA" \
  --menu "Please select- **BETA-BETA-BETA**" 30 75 30 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear &/root/.meraki_port_mig/wizard.sh ;;
  2) clear ;;
  3) clear & rm -r -f /root/.ssh/known_hosts & /root/.meraki_port_mig/clean.exp ;;
  4) clear & /root/.meraki_port_mig/switch_collection.sh ;;
  8) clear ;;
  9) clear & /root/.meraki_port_mig/deploy_check.sh | tee -a /root/.meraki_port_mig/logs/soft_hard_check_deployment.log ;;
 10) clear & /root/.meraki_port_mig/update_physical_address_switch.sh ;;
 11) clear & /root/.meraki_port_mig/port_deploy.sh ;;
 12) clear & /root/.meraki_port_mig/adv_template.sh ;;
 13) clear & /root/.meraki_port_mig/batch_clean.sh ;;
 14) clear & /root/.meraki_port_mig/.logo ;;
 15) clear & /root/.meraki_port_mig/global_environment.sh ;;
 16) clear & /root/.meraki_port_mig/schedule.sh ;;
 17) clear & /root/.meraki_port_mig/logging_environment.sh ;;
 18) clear & /root/.meraki_port_mig/utilities.sh ;;
 19) clear & /root/.meraki_port_mig/welcome.readme | more ;;
  esac
done
clear # clear after user pressed Cancel
