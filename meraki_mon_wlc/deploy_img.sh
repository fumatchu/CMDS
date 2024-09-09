#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
INPUT="/root/.meraki_mon_wlc/ip_list"
echo "Collecting latest data, Please wait"
/root/.meraki_mon_wlc/get_ios_ver.exp > /dev/null 2>&1
clear
cat <<EOF
${GREEN}Deploy IOS-XE Image${TEXTRESET}

This will deploy an IOS-XE Image to the WLC

If you have a Single WLC in your environnment, you can successfully use this script

${YELLOW}If you are in an HA environment, The minimum version to upgrade is 17.5. ${TEXTRESET}
If your WLC Code is below 17.5, you must use the GUI on the WLC to peform your Upgrade, first.
When you get to >17.5, you may use the server to upgrade to 17.12

${GREEN}Current Version of IOS-XE on the WLC(s) ${TEXTRESET}
EOF
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"
VERSIONFULL=$(cat /var/lib/tftpboot/wlc/${IP}-shver | grep "Cisco IOS XE Software, Version")
  echo "The Version is:"
  echo "${YELLOW}${VERSIONFULL}${TEXTRESET}"
  echo " "
done <"$INPUT"

cat << EOF

Please refer to these design guides for upgrading 9800 series WLC's to the required version (17.12.03), for ISSU and HA

https://www.cisco.com/c/en/us/td/docs/wireless/controller/9800/17-12/config-guide/b_wl_17_12_cg/m_upgrade_9800cl.html


https://www.cisco.com/c/en/us/td/docs/wireless/controller/9800/technical-reference/c9800-best-practices.html


EOF

read -r -p "Would you like to deploy the IOS-XE Image using this Server? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  clear
  echo ${GREEN}"Deploying Image${TEXTRESET}"
  sleep 1
/root/.meraki_mon_wlc/deploy_img.exp

fi
echo "Complete"
sleep 1
