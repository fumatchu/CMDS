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
  5 "Archive Active Log Files"
  6 "Dump Registered Switches to file"
  7 "DHCP Server"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "MMU- Main Menu -->Utilities" \
  --menu "Please select" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/.meraki_mig/ping_now.sh ;;
  2) iptraf-ng -i all ;;
  3) /root/.meraki_mig/dynamic_set_ns.sh ;;
  4) /root/.meraki_mig/dynamic_set_httpclient.sh ;;
  5) /root/.meraki_mig/archive.sh ;;
  6) /root/.meraki_mig/archive_meraki_id.sh ;;
  7) clear & /root/.servman/DHCPMan ;;

  esac
done
clear # clear after user pressed Cancel
