#!/bin/bash
#Get Monitoring status from WLC
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
INPUT="/root/.meraki_mon_wlc/ip_list"

clear
cat <<EOF
${GREEN}Creating the AP Regsitration Summary${TEXTRESET}
EOF
sleep 2
cat << EOF
This will allow you to see the current WLC registration to the cloud
from the WLC's perspective
EOF

expect -f /root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.exp

clear
echo ${GREEN}"This is the WLC's current resgistration status${TEXTRESET}"
# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo ${GREEN}"$IP"${TEXTRESET}
  echo " "

cat /var/lib/tftpboot/wlc/${IP}-wlc_mon_summ
done <"$INPUT"
read -p "Press Enter"
