#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
INPUT="/root/.meraki_mig/ip_list"
cat << EOF
${GREEN}
IOS-XE Version Check
${TEXTRESET}

Getting latest information from Switches, Please wait
EOF

/root/.meraki_mig/get_ios_ver.exp > /dev/null 2>&1
clear
# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo " "
  echo "${GREEN}$IP${TEXTRESET}"

echo "Checking IOS Version is 17.09.03m3 "
  #VERSION=$(cat /var/lib/tftpboot/mig_switch/${IP}-shver | grep "Cisco IOS Software" | cut -c84- | cut -d, -f1 | sed 's/\(.*\)..../\1/')
  #VERSIONFULL=$(cat /var/lib/tftpboot/mig_switch/${IP}-shver | grep "Cisco IOS XE Software, Version" | sed -e 's/\.//g')
  VERSIONFULL=$(cat /var/lib/tftpboot/mig_switch/${IP}-shver | grep "Cisco IOS XE Software, Version")
  echo "The switch Version is:"
  echo "${VERSIONFULL}"
  if [ "$VERSIONFULL" == "Cisco IOS XE Software, Version 17.09.03m3" ]; then
    echo "${GREEN}IOS-XE Version Matches Requirement${TEXTRESET}"
    echo " "
  else
    echo "${RED}ERROR:IOS-XE Needs Updating - The Version should be 17.09.03m3${TEXTRESET}"
    echo "1" >> /root/.meraki_mig/check.tmp
    echo " "
    echo "Download this code: https://software.cisco.com/download/specialrelease/b53558e8586d98df4e9e7860c7692e75"
    echo "Valid CCO ID is required"
    echo "The Script will continue momentarily"
    sleep 10
    
  fi


done <"$INPUT"
echo " "
echo " "
sleep 1
read -p "Press Enter to Continue"
