#!/bin/bash
#Setup Wizard
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVER_IP=$(hostname -I)
DATE=$(date)
INPUT="/root/.meraki_mon_wlc/ip_list"
clear
cat <<EOF
############################Collection time ${DATE}######################################
${GREEN}Enable AVC/Telemtry${TEXTRESET}
This script will validate that you have the correct license level and enable AVC/Telemetry for you

${RED}This script WILL BE disruptive to clients as it needs to shutdown wireless profiles for a successful AVC enablement
APs must REJOIN (Not reboot) to the WLC after the profile update${TEXTRESET}

EOF

echo "The Script will continue momentarily"
sleep 10


# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  clear
  echo ${GREEN}"$IP"${TEXTRESET}
#CHECK LICENSE
  echo ${YELLOW}"Checking License Compatbility ${TEXTRESET} "
  LICENSE=$(cat /var/lib/tftpboot/wlc/$IP-shver | grep "AIR License Level:" | cut -c20-)
  echo "The DNA Level of license is:"
  echo "${LICENSE}"
  if [ "$LICENSE" == "AIR DNA Advantage" ]; then
    echo "${GREEN}Version Matches Requirement"${TEXTRESET}
    echo " "
    echo "Please make sure that you have the correct QTY of DNA-A licenses to accomodate the AP's for AVC"
    sleep 5

#Get Each WLC Config
echo $IP >> /root/.meraki_mon_wlc/ip_list_single
    /root/.meraki_mon_wlc/update_config_single.exp
    sed -i '/^/d' /root/.meraki_mon_wlc/ip_list_single
    sleep 2

#Update Wireless policy
#Get Wireless Profiles
cat /var/lib/tftpboot/wlc/$IP | grep "wireless profile policy" | cut -c25- >>/root/.meraki_mon_wlc/${IP}-wireless_profile.tmp
clear

echo "${GREEN}Wireless Profiles Found${TEXTRESET}"

cat /root/.meraki_mon_wlc/${IP}-wireless_profile.tmp
sleep 5

clear
echo ${GREEN}"Creating local Flow Exporters${TEXTRESET}"
sleep 3

echo $IP >> /root/.meraki_mon_wlc/ip_list_single
/root/.meraki_mon_wlc/update_avc_ta.exp
sed -i '/^/d' /root/.meraki_mon_wlc/ip_list_single
sleep 2

clear

file="/root/.meraki_mon_wlc/${IP}-wireless_profile.tmp"

while IFS= read -r line; do
  #  echo "$line"
  clear
  echo ${GREEN}"Updating Policy $line for AVC ${TEXTRESET}"
  sleep 3
  echo $IP >> /root/.meraki_mon_wlc/ip_list_single
  sed -i "/set policy/c\set policy ${line}" /root/.meraki_mon_wlc/update_ip_nbar.exp
  /root/.meraki_mon_wlc/update_ip_nbar.exp
  sed -i '/^/d' /root/.meraki_mon_wlc/ip_list_single

done <"$file"

else
    echo "${RED}ERROR:The License Level does not allow for enabling AVC analytics."${TEXTRESET}
    echo "${RED}Please Validate that you have DNA Advantage licenses before enabling this feature"${TEXTRESET}
    echo "${YELLOW}Skipping"${TEXTRESET}
    sleep 8
  fi

done <"$INPUT"

rm -r -f /root/.meraki_mon_wlc/*-wireless_profile.tmp
rm -r -f /root/.meraki_mon_wlc/ip_list_single
