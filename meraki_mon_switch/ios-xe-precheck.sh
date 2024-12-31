#!/bin/bash

TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
INPUT="/root/.meraki_mon_switch/ip_list"

cat << EOF
${GREEN}
IOS-XE Version Check
${TEXTRESET}

Getting latest information from Switches, Please wait
EOF

/root/.meraki_mon_switch/get_ios_ver.exp > /dev/null 2>&1
clear

# Function to compare version strings
version_compare() {
  local IFS=.
  local i ver1 ver2
  ver1=(${1//[!0-9.]/})
  ver2=(${2//[!0-9.]/})
  # Pad the shorter version with zeros for proper comparison
  for ((i=${#ver1[@]}; i<${#ver2[@]}; i++)); do ver1[i]=0; done
  for ((i=${#ver2[@]}; i<${#ver1[@]}; i++)); do ver2[i]=0; done
  for ((i=0; i<${#ver1[@]}; i++)); do
    if ((10#${ver1[i]} > 10#${ver2[i]})); then
      return 1
    elif ((10#${ver1[i]} < 10#${ver2[i]})); then
      return 2
    fi
  done
  return 0
}

# Read file line-by-line to get an IP address
while read -r IP; do
  echo " "
  echo "${GREEN}$IP${TEXTRESET}"

  x=$(cat /var/lib/tftpboot/mon_switch/$IP-shver | grep "Cisco IOS XE Software, Version" | cut -c32-)
  echo "IOS-XE Version is ${YELLOW}$x${TEXTRESET}"

  # Define supported version ranges
  min_version="17.3.0"
  max_version="17.10.0"
  specific_version="17.12.3"

  # Compare the version
  version_compare "${x}" "${min_version}"
  result_min=$?

  version_compare "${x}" "${max_version}"
  result_max=$?

  version_compare "${x}" "${specific_version}"
  result_specific=$?

  # Check if the version meets requirements
  if { [ $result_min -eq 1 ] && [ $result_max -eq 2 ]; } || [ $result_specific -eq 0 ]; then
    echo "${GREEN}IOS-XE Version Meets Requirement${TEXTRESET}"
  else
    echo "${RED}ERROR: IOS-XE version does not meet the requirement${TEXTRESET}"
    echo "Supported versions are IOS-XE 17.3.0 - 17.10.0, and 17.12.3"
    echo "Please see the following link to download:"
    echo "https://software.cisco.com/download/home"
    echo "A CCO ID is required"
  fi
done < "$INPUT"

echo " "
echo " "
sleep 1
read -p "Press Enter to Continue"
