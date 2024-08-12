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
  4 "Deploy ip domain lookup"
  5 "Deploy Global aaa new-model update"
  6 "Deploy Global NTP removal and update"
  7 "Deploy ip routing command"
  8 "Deploy Default Route" 
  9 "DHCP Server"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Wireless Monitoring-->CMDS-->Main Menu-->Utilities" \
  --menu "Please select" 18 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & /root/.meraki_mon_switch/ping_now.sh ;;
  2) clear & iptraf-ng -i all ;;
  3) clear & /root/.meraki_mon_switch/update_ip_name-server.sh ;;
  4) clear & /root/.meraki_mon_switch/update_ip_domain_lookup.sh ;;
  5) clear & /root/.meraki_mon_switch/update_aaa_config.sh ;;
  6) clear & /root/.meraki_mon_switch/update_ntp_server.sh ;;
  7) clear & /root/.meraki_mon_switch/update_iprouting_config.sh ;;
  8) clear & /root/.meraki_mon_switch/update_defgw.sh ;;
  9) clear & /root/.servman/DHCPMan ;;

  esac
done
clear # clear after user pressed Cancel
