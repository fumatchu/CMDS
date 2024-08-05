#!/bin/bash
#Collect hostnames and match to Serial
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear
cat <<EOF
${GREEN}Hostname Migration${TEXTRESET}

${YELLOW}
Did you move the claimed devices from Inventory into the networks you want on your dashboard?
If you did not, please do so now.

This can be accomplished by selecting Organization --> Inventory, Search for 9800
${TEXTRESET}

Find the newly entered devices, select their checkbox, then Add to Network
Proceed to run through the wizard on the Dashboard for WLC placement and AP allocation,
Using either single ("flat", allocated network) or leveraging the Site Tags
Then provide your login credentials for the dashboard.

EOF

read -p "Press Enter to confirm you have made that change, and the migration will continue"

# Set the input file name here
INPUT="/root/.meraki_mon_wlc/ip_list"
clear
echo "############################Collection time ${DATE}######################################"
cat <<EOF
${YELLOW}Migrating Hostnames${TEXTRESET}

EOF
#Get Data
/root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.exp

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"

  cat /var/lib/tftpboot/wlc/$IP-wlc_mon_summ | grep -E -o "Q.{0,13}" >>/root/.meraki_mon_wlc/working.tmp
  sed -i '2d;3d' /root/.meraki_mon_wlc/working.tmp
  sed -i 's/$/,/g' /root/.meraki_mon_wlc/working.tmp
  cat /var/lib/tftpboot/wlc/$IP | grep hostname | cut -c10- >>/root/.meraki_mon_wlc/working.tmp
  awk '{if(NR%2==0) {print var,$0} else {var=$0}}' /root/.meraki_mon_wlc/working.tmp >>/root/.meraki_mon_wlc/hostnames.txt
  rm /root/.meraki_mon_wlc/working.tmp

done <"$INPUT"

clear
echo ${GREEN}"Deploying Update"${TEXTRESET}
unbuffer python3 /root/.meraki_mon_wlc/deploy_hostnames.py
echo ${GREEN}"Script Complete"${TEXTRESET}
#cleanup
rm -f /root/.meraki_mon_wlc/hostnames.txt
sleep 2
