#!/bin/bash
#Utilities Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Ping Sweep Active Switches"
  2 "Monitor TFTP "
  3 "Deploy Global command for DNS"
  4 "Deploy Global command for http client"
  5 "Show converted Meraki ID"
  6 "Network Discovery"
  7 "DHCP Server"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Migration to Dashboard-->Main Menu-->Utilities" \
  --menu "Please select" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & /root/.meraki_mig/ping_now.sh ;;
  2) clear & iptraf-ng -i all ;;
  3) clear & /root/.meraki_mig/update_ip_name-server.sh ;;
  4) clear & /root/.meraki_mig/update_httpclient.sh ;;
  5) clear & /root/.meraki_mig/show_meraki_id.sh ;;
  6) clear & /root/.meraki_mig/network_discovery.sh ;;
  7) clear & /root/.servman/DHCPMan ;;
  esac
done
clear # clear after user pressed Cancel
