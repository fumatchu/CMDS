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

EOF

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


#Test if this is a stack switch

STACK=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmr| sed -n '/^2/p'  2>/dev/null)

if [ "$STACK" = "" ]; then
     sed -i '/^IP=/c\IP=' /root/.meraki_mig/convert_hostname_single.sh
     sed -i "s/IP=/IP=${IP}/g" /root/.meraki_mig/convert_hostname_single.sh
     /root/.meraki_mig/convert_hostname_single.sh
   else
     sed -i '/^IP=/c\IP=' /root/.meraki_mig/convert_hostname_stack.sh
     sed -i "s/IP=/IP=${IP}/g" /root/.meraki_mig/convert_hostname_stack.sh
     /root/.meraki_mig/convert_hostname_stack.sh
fi

done <"$INPUT"
