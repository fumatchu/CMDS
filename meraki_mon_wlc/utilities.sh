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
  4 "Deploy Remove and Update NTP"
  4 "Deploy aaa new-model update"
  5 "DHCP Server"
  6 "Factory Default"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Wireless Monitoring-->CMDS-->Main Menu-->Utilities" \
  --menu "Please select" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & /root/.meraki_mon_wlc/ping_now.sh ;;
  2) clear & iptraf-ng -i all ;;
  3) clear & /root/.meraki_mon_wlc/update_ip_name-server.sh ;;
  4) clear & /root/.meraki_mon_wlc/update_ntp_server.sh ;;
  5) clear & /root/.meraki_mon_wlc/update_aaa_config.sh ;;
  6) clear & /root/.servman/DHCPMan ;;
  7) clear & /root/.meraki_mon_wlc/factory_default.sh ;;
  esac
done
clear # clear after user pressed Cancel
