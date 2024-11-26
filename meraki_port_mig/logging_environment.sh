#!/bin/bash
#Logging Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Active Logging"
  2 "Show Full Log"
  3 "Deployment Log"
  4 "Show Hostname Migration"
  5 "Search Log files"
  6 "Search Port Template Deployment"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Migration to Dashboard-->Main Menu-->Log Search" \
  --menu "Please select" 30 75 30 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_port_mig/log_tail.sh ;;
  2) /root/.meraki_port_mig/full_log.sh ;;
  3) /root/.meraki_port_mig/show_soft_hard_log.sh ;;
  4) /root/.meraki_port_mig/show_hostnames_log.sh ;;
  5) /root/.meraki_port_mig/log_search ;;
  6) /root/.meraki_port_mig/show_template_deploy.sh ;;
  esac
done
clear # clear after user pressed Cancel