#!/bin/bash
#Setup Wizard
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVER_IP=$(hostname -I)
INPUT="/root/.meraki_mon_wlc/ip_list"
clear

cat <<EOF
${GREEN}Checking for DNA-A Licenses${TEXTRESET}
EOF
sleep 1
clear

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"

  echo ${YELLOW}"Checking License Compatbility ${TEXTRESET} "
  LICENSE=$(cat /var/lib/tftpboot/wlc/$IP-shver | grep "AIR License Level:" | cut -c20-)
  echo "The DNA Level of license is:"
  echo "${LICENSE}"
  if [ "$LICENSE" == "AIR DNA Advantage" ]; then
    echo "${GREEN}Version Matches Requirement"${TEXTRESET}
    echo " "
    echo "Please make sure that you have the correct QTY of DNA-A licenses to accomodate the AP's for AVC"
    sleep 5
  else
    echo "${RED}ERROR:The License Level does not allow for enabling AVC analytics."${TEXTRESET}
    echo "${RED}Please Validate that you have DNA Advantage licenses before enabling this feature"${TEXTRESET}
    echo "Exiting..."
    sleep 10
    exit
  fi

done <"$INPUT"
