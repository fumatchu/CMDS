#!/bin/bash
#Utilities Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Ping Sweep Active Switches"
  2 "Monitor TFTP "
  3 "Network Discovery"
  4 "Deploy Global command for DNS"
  5 "Deploy Global ip domain lookup"
  6 "Deploy Global aaa new-model update"
  7 "Deploy Global NTP removal and update"
  8 "Deploy Global ip routing command"
  9 "Deploy Global Default Route" 
 10 "Download Cloud Monitoring for Catalyst Application"
 11 "DHCP Server"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Monitoring for Switching Prep Tool-->Main Menu-->Utilities" \
  --menu "Please select" 18 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & /root/.meraki_mon_switch/ping_now.sh ;;
  2) clear & iptraf-ng -i all ;;
  3) clear & /root/.meraki_mon_switch/network_discovery.sh ;;
  4) clear & /root/.meraki_mon_switch/update_ip_name-server.sh ;;
  5) clear & /root/.meraki_mon_switch/update_ip_domain_lookup.sh ;;
  6) clear & /root/.meraki_mon_switch/update_aaa_config.sh ;;
  7) clear & /root/.meraki_mon_switch/update_ntp_server.sh ;;
  8) clear & /root/.meraki_mon_switch/update_iprouting_config.sh ;;
  9) clear & /root/.meraki_mon_switch/update_defgw.sh ;;
 10) clear & /root/.meraki_mon_switch/download_client.sh ;;
 11) clear & /root/.servman/DHCPMan ;;

  esac
done
clear # clear after user pressed Cancel
