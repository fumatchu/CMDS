#!/bin/bash
#Utilities Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Ping Sweep Active Switches"
  2 "Monitor TFTP "
  3 "Create Switch Network on Dashboard"
  4 "Deploy Global command for DNS"
  5 "Deploy Global command for http client"
  6 "Show converted Meraki ID"
  7 "Network Discovery"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Migration to Dashboard-->Main Menu-->Utilities" \
  --menu "Please select" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & /root/.meraki_mig/ping_now.sh ;;
  2) clear & iptraf-ng -i all ;;
  3) clear & python3.10 /root/.meraki_mig/make_network_switch.py ;;
  4) clear & /root/.meraki_mig/update_ip_name-server.sh ;;
  5) clear & /root/.meraki_mig/update_httpclient.sh ;;
  6) clear & /root/.meraki_mig/show_meraki_id.sh ;;
  7) clear & /root/.meraki_mig/network_discovery.sh ;;
  esac
done
clear # clear after user pressed Cancel
