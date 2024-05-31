#!/bin/bash
#Advanced Template Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Deploy Port Template"
  2 "Show Port Templates"
  3 "Deploy Linked (Nested) Template"
  4 "Show Linked (Nested) Template"
  5 "Modify 24 port Serial List"
  6 "Modify 48 Port Serial List"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "CMDS-Main Menu -->Template Builder" \
  --menu "Please select" 18 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_mig/deploy_template.sh | tee -a /root/.meraki_mig/logs/template_deployment.log ;;
  2) /root/.meraki_mig/show_existing_template.sh ;;
  3) /root/.meraki_mig/deploy_linked_template.sh | tee -a /root/.meraki_mig/logs/template_deployment.log ;;
  4) /root/.meraki_mig/show_linked_template.sh ;;
  5) nano /root/.meraki_mig/templates/already_installed/switch_serials_24.txt ;;
  6) nano nano /root/.meraki_mig/templates/already_installed/switch_serials_48.txt ;;
  esac
done
clear # clear after user pressed Cancel
