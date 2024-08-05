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
This can be accomplished by selecting Organization --> Inventory, Search for 9300
Find the newly entered devices, select their checkbox, then Change Network Assignment
${TEXTRESET}
EOF

read -p "Press Enter to confirm you have made that change, and the migration will continue"

# Set the input file name here
INPUT="/root/.meraki_mig/ip_list"
clear
echo "############################Collection time ${DATE}######################################"
cat <<EOF
${YELLOW}Migrating Hostnames${TEXTRESET}

EOF

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"

cat /var/lib/tftpboot/$IP-shmr | grep '1 \ C9300' | grep -E -o "Q.{0,13}" >> /root/.meraki_mig/working.tmp
sed -i 's/$/,/g' /root/.meraki_mig/working.tmp
cat /var/lib/tftpboot/$IP | grep hostname | sed 's/hostname //g' >> /root/.meraki_mig/working.tmp
awk '{if(NR%2==0) {print var,$0} else {var=$0}}' /root/.meraki_mig/working.tmp >> /root/.meraki_mig/hostnames.txt
rm /root/.meraki_mig/working.tmp

done <"$INPUT"


echo ${GREEN}"Deploying Update"${TEXTRESET}
unbuffer python3 /root/.meraki_mig/deploy_hostnames.py
echo ${GREEN}"Script Complete"${TEXTRESET}
#cleanup
rm -f /root/.meraki_mig/hostnames.txt
sleep 2
