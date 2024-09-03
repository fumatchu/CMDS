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
# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo " "
  echo "${GREEN}$IP${TEXTRESET}"



x=$(cat /var/lib/tftpboot/mon_switch/$IP-shver |grep "Cisco IOS XE Software, Version" | cut -c32-)
first=${x%%.*}          # Delete first dot and what follows.
last=${x##*.}           # Delete up to last dot.
mid=${x##$first.}       # Delete first number and dot.
mid=${mid%%.$last}      # Delete dot and last number.
#echo $first $mid $last
echo "IOS-XE Version is ${YELLOW}$x${TEXTRESET}"
 if [ $first -ge 17 ] && [ $mid -ge 3 ] && [ $last -gt 1 ]; then
    echo "${GREEN}IOS-XE Version Meets Requirement${TEXTRESET}"
  else
    echo "${RED}ERROR: IOS-XE version does not meet the requirement${TEXTRESET}"
    echo "Supported versions are IOS-XE 17.3 - 17.10.1, and 17.12.3"
    echo "Please see the following link to download:"
    echo "https://software.cisco.com/download/home"
    echo "A CCO ID is required"
fi
done <"$INPUT"
echo " "
echo " "
sleep 1
read -p "Press Enter to Continue"
