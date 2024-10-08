#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
INPUT="/root/.meraki_mon_wlc/ip_list"
cat << EOF
${GREEN}
IOS-XE Version Check
${TEXTRESET}

Getting latest information, Please wait
EOF

/root/.meraki_mon_wlc/get_ios_ver.exp > /dev/null 2>&1
clear
# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo " "
  echo "${GREEN}$IP${TEXTRESET}"



x=$(cat /var/lib/tftpboot/wlc/$IP-shver |grep "Cisco IOS XE Software, Version" | cut -c32-)
first=${x%%.*}          # Delete first dot and what follows.
last=${x##*.}           # Delete up to last dot.
mid=${x##$first.}       # Delete first number and dot.
mid=${mid%%.$last}      # Delete dot and last number.
#echo $first $mid $last
echo "IOS-XE Version is ${YELLOW}$x${TEXTRESET}"
 if [ $first -eq 17 ] && [ $mid -eq 12 ] && [ $last -eq 3 ]; then
    echo "${GREEN}IOS-XE Version Meets Requirement${TEXTRESET}"
  else
    echo "${RED}ERROR: IOS-XE version does not meet the requirement${TEXTRESET}"
    echo "Supported version is only 17.12.3"
    echo "Please see the following link to download:"
    echo "https://software.cisco.com/download/home"
    echo "A CCO ID is required"
fi
done <"$INPUT"
echo " "
sleep 1
read -p "Press Enter to Continue"
