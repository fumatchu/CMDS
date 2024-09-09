#!/bin/bash
#Utilities Menu
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)

items=(1 "Ping Sweep Active WLC(s)"
  2 "Monitor TFTP "
  3 "Check WLC Registration to Cloud"
  4 "Check AP registration to Cloud"
  5 "Deploy Global command for DNS"
  6 "Deploy Remove and Update NTP"
  7 "Deploy aaa new-model update"
  8 "Enable AVC on WLC"
  9 "DHCP Server"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Catalyst Monitoring for Wireless-->Main Menu-->Utilities" \
  --menu "Please select" 18 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) clear & /root/.meraki_mon_wlc/ping_now.sh ;;
  2) clear & iptraf-ng -i all ;;
  3) clear & /root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.sh ;;
  4) clear & /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.sh ;;
  5) clear & /root/.meraki_mon_wlc/update_ip_name-server.sh ;;
  6) clear & /root/.meraki_mon_wlc/update_ntp_server.sh ;;
  7) clear & /root/.meraki_mon_wlc/update_aaa_config.sh ;;
  8) clear & /root/.meraki_mon_wlc/enable_avc.sh | tee -a /root/.meraki_mon_wlc/logs/avc_enable.log ;;
  9) clear & /root/.servman/DHCPMan ;;
  esac
done
clear # clear after user pressed Cancel
