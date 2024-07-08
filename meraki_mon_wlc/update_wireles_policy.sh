#!/bin/bash
#Pre-Check Script
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVER_IP=$(hostname -I)
INPUT="/root/.meraki_mon_wlc/ip_list"
DATE=$(date)

clear
cat <<EOF
These are the current Wireless Policies on the WLC
The Server will enable AVC for the WLC and apply policy to the Wireless Profiles

EOF

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  #  echo "$IP"
  cat /var/lib/tftpboot/wlc/$IP | grep "wireless profile policy" | cut -c25- >>/root/.meraki_mon_wlc/wireless_profile.tmp

done <"$INPUT"

more /root/.meraki_mon_wlc/wireless_profile.tmp

cat <<EOF

EOF
read -p "Press Any Key"
clear

echo ${GREEN}"Creating local Flow Exporters${TEXTRESET}"
sleep 3
/root/.meraki_mon_wlc/update_avc_ta.exp

file="/root/.meraki_mon_wlc/wireless_profile.tmp"

while IFS= read -r line; do
  #  echo "$line"
  clear
  echo ${GREEN}"Updating Policy $line for AVC ${TEXTRESET}"
  sleep 3
  sed -i "/set policy/c\set policy ${line}" /root/.meraki_mon_wlc/update_ip_nbar.exp
  /root/.meraki_mon_wlc/update_ip_nbar.exp

done <"$file"

rm /root/.meraki_mon_wlc/wireless_profile.tmp
