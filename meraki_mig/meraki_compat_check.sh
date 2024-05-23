#!/bin/bash
#Meraki Mig deploy
#meraki_compat_check.sh
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
INPUT="/root/.meraki_mig/ip_list"
switch_minimum=17.09
SINT="ip http client source-interface"
DATE=$(date)
clear
# Set the input file name here
INPUT="/root/.meraki_mig/ip_list"

#Sanitize config files first
cat <<EOF
${GREEN}Checking current Switch Config for Meraki Migration Requirements${TEXTRESET}

Creating a Checkpoint and gathering latest data from the switches
EOF

sleep 3

clear
expect -f /root/.meraki_mig/clean
clear

cat <<EOF
Collecting Compatability Data from switches for Meraki Migration
EOF
sleep 3
clear &
rm -r -f /root/.ssh/known_hosts

expect -f /root/.meraki_mig/meraki_compat_check.exp

clear

cat <<EOF
${GREEN}Validating that we are running the approved version of IOS-XE to migrate to Meraki${TEXTRESET}
EOF
sleep 4
clear
echo "############################Collection time ${DATE}######################################"
# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"

  echo ${YELLOW}"Checking IOS Version is 17.09.03m3${TEXTRESET} "
  #VERSION=$(cat /var/lib/tftpboot/${IP}-shver | grep "Cisco IOS Software" | cut -c84- | cut -d, -f1 | sed 's/\(.*\)..../\1/')
  #VERSIONFULL=$(cat /var/lib/tftpboot/${IP}-shver | grep "Cisco IOS XE Software, Version" | sed -e 's/\.//g')
  VERSIONFULL=$(cat /var/lib/tftpboot/${IP}-shver | grep "Cisco IOS XE Software, Version")
  echo "The switch Version is:"
  echo "${VERSIONFULL}"
  if [ "$VERSIONFULL" == "Cisco IOS XE Software, Version 17.09.03m3" ]; then
    echo "${GREEN}IOS-XE Version Matches Requirement"${TEXTRESET}
    echo " "
    sleep 1
  else
    echo "${RED}ERROR:IOS-XE Needs Updating - The Version should be 17.09.03m3"${TEXTRESET}
    echo "${RED}Please upgrade to 17.09.03m3 on all switches then re-run the Meraki PreCheck Collection"${TEXTRESET}
    echo "Exiting..."
    sleep 5
    exit
  fi

done <"$INPUT"
cat <<EOF
Collection complete
Please review the logs at MainMenu --> Logs --> Meraki PreCheck Log
The script will terminate momentarily
EOF
sleep 6
