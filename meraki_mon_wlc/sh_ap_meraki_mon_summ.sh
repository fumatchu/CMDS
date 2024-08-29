#!/bin/bash
#Set the command ip name-server
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
This will allow you to see the current AP's registered to the cloud
from the perspective of the WLC
EOF

expect -f /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.exp

clear
echo ${GREEN}"These are the current status of registered AP's via WLC to the cloud${TEXTRESET}"

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo ${GREEN}"$IP"${TEXTRESET}

cat /var/lib/tftpboot/wlc/${IP}-ap_mon_summ

done <"$INPUT"

read -p "Press Enter"
