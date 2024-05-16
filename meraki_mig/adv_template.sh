#!/bin/bash
#Utilities Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Create a Template"
  2 "Delete a Template"
  3 "Deploy a Template"
  4 "Show templates"
  5 "Override Switches to Receive Template"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "CMDS- Main Menu -->Template Builder" \
  --menu "Please select" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_mig/advanced_template.sh ;;
  2) /root/.meraki_mig/delete_template.sh ;;
  3) /root/.meraki_mig/deploy_template.sh | tee -a /root/.meraki_mig/logs/template_deployment.log ;;
  4) /root/.meraki_mig/show_template.sh ;;
  esac
done
clear # clear after user pressed Cancel
