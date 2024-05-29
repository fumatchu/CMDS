#!/bin/bash
#Script for IOS-XE migration (Sanity Check)
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
INPUT="/root/.meraki_mig/ip_list"
switch_minimum=16.6
upg_minimum=16.12
DATE=$(date)
clear
#Sanitize config files first
cat <<EOF
${GREEN}Checking current Switch Config${TEXTRESET}

EOF
# Set the input file name here
INPUT="/root/.meraki_mig/ip_list"
clear
echo "############################Collection time ${DATE}######################################"
cat <<EOF
${YELLOW}Checking current Switch Config${TEXTRESET}

EOF
cat <<EOF
Checking current IOS-XE Versions. This will provide two answers per switch
1. Checking the IOS Version- Determines if it meets the requirement (16.6.2)
    - If your switches are below 16.6.2 (16.5.1a) you must manually upgrade first
2. Checking for one-shot upgrade- Determines if we can upgrade directly to
   The required version for Meraki migration (16.12 or higher).

Inspection will continue momentarily
EOF

sleep 15

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"

  cat <<EOF
${YELLOW}Checking the IOS Version${TEXTRESET}
EOF

  #Does the Switch Base IOS Provide a High enough version number for IOS-XE?
  echo "Checking base IOS-XE Version to migrate to 17.09.03m3 "
  VERSION=$(cat /var/lib/tftpboot/${IP}-shver | grep "Cisco IOS Software" | cut -c84- | cut -d, -f1 | sed 's/\(.*\)..../\1/')
  VERSIONFULL=$(cat /var/lib/tftpboot/${IP}-shver | grep "Cisco IOS XE Software, Version")
  echo "The switch Version is:"
  echo "${VERSIONFULL}"
  check=$(echo "$VERSION>$switch_minimum" | bc -l)
  echo "check = $check"
  if (($check)); then
    echo "${GREEN}IOS-XE Version Meets Requirement${TEXTRESET}"
    sleep 2
  else
    echo "${RED}ERROR:IOS-XE Needs Manual Updating - minimum version requirement is 16.6${TEXTRESET}"
    echo "Please review the logs before continuing"
    sleep 5
    exit
  fi
  echo "${GREEN}The switch Version is:"${TEXTRESET}"
#echo "${VERSION} | grep "Cisco IOS XE Software, Version"
  cat <<EOF

EOF

  #Does the Switch Base IOS Provide a High enough version number for IOS-XE to one-shot UPG??
  echo "${YELLOW}Checking IOS-XE Version to "one-shot" migrate to 17.09.03m3${TEXTRESET}"
  VERSION=$(cat /var/lib/tftpboot/${IP}-shver | grep "Cisco IOS Software" | cut -c84- | cut -d, -f1 | sed 's/\(.*\)..../\1/')
  VERSIONFULL=$(cat /var/lib/tftpboot/${IP}-shver | grep "Cisco IOS XE Software, Version")
  echo "The switch Version is:"
  echo "${VERSIONFULL}"
  check=$(echo "$VERSION>$upg_minimum" | bc -l)
  echo "check = $check"
  if (($check)); then
    echo "${GREEN}IOS-XE Version Meets "one-shot" Requirement${TEXTRESET}"
    sleep 2
  else
    echo "${RED}ERROR:IOS-XE cannot "one-shot" to 17.09.03m3 - minimum version requirement is 16.12${TEXTRESET}"
    echo "${RED}You will have to incrementally upgrade to 16.12, then "one-shot" upgrade to 17.09.03m3${TEXTRESET}"
    echo "Please review the logs before continuing"
    sleep 5
  fi
  echo "${GREEN}The switch Version is:"${TEXTRESET}"
#echo "${VERSION} | grep "Cisco IOS XE Software, Version"
  cat <<EOF

EOF

done <"$INPUT"

cat <<EOF
IOS-XE Version checking complete
${YELLOW}
#############################################################################################
If the minimum Base requirement has been met, please proceed to Deploy IOS-XE Image to switch
#############################################################################################
${TEXTRESET}
Please review the logs at MainMenu --> Logs --> IOS-XE PreCheck Log
The script will terminate shortly
EOF
sleep 5
