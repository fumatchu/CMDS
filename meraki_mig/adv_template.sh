#!/bin/bash
#Advanced Template Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Create a Port Template"
  2 "Deploy a Port Template"
  3 "Show Port Templates"
  4 "Delete a Port Template"
  5 "Deploy Linked (Nested) Template"
  6 "Show Linked (Nested) Template"
  7 "Delete Linked (Nested) Template"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "CMDS-Main Menu -->Template Builder" \
  --menu "Please select" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_mig/advanced_template.sh ;;
  2) /root/.meraki_mig/deploy_template.sh | tee -a /root/.meraki_mig/logs/template_deployment.log ;;
  3) /root/.meraki_mig/show_template.sh ;;
  4) /root/.meraki_mig/delete_port_template.sh ;;
  5) /root/.meraki_mig/deploy_linked_template.sh | tee -a /root/.meraki_mig/logs/template_deployment.log ;;
  6) /root/.meraki_mig/show_linked_template.sh ;;
  7) /root/.meraki_mig/delete_nested_port_template.sh ;;
  esac
done
clear # clear after user pressed Cancel
