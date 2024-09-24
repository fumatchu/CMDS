#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
INPUT="/root/.meraki_mon_wlc/ip_list"
clear
cat <<EOF
${GREEN}Creating the AP Registration Summary${TEXTRESET}
EOF
cat << EOF
This will allow you to see the current AP's registered to the cloud
from the perspective of the WLC

Please Wait...
EOF
sleep 2

expect -f /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.exp > /dev/null 2>&1

clear
echo ${GREEN}"These are the current status of registered AP's via WLC to the cloud${TEXTRESET}"

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo ${GREEN}"$IP"${TEXTRESET}

cat /var/lib/tftpboot/wlc/${IP}-ap_mon_summ | tee /root/.meraki_mon_wlc/summary.tmp

done <"$INPUT"

echo " "
cat /root/.meraki_mon_wlc/summary.tmp | grep "Number of"

read -p "Press Enter"
