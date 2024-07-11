#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Deploy IOS-XE Image${TEXTRESET}

This will deploy an IOS-XE Image to the WLC

If you have a Single WLC in your envrionnment, you can successfully use this script

${YELLOW}If you are in an HA environment, currently, the server does not support SSO, or ISSU Upgrades ${TEXTRESET}

It will be available in a future release


Please refer to these design guides for upgrading 9800 series WLC's to the required version (17.12.03), for ISSU and HA

https://www.cisco.com/c/en/us/td/docs/wireless/controller/9800/17-12/config-guide/b_wl_17_12_cg/m_upgrade_9800cl.html


https://www.cisco.com/c/en/us/td/docs/wireless/controller/9800/technical-reference/c9800-best-practices.html


EOF

read -r -p "Would you like to deploy the IOS-XE Image? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  clear
  echo ${GREEN}"Deploying Image${TEXTRESET}"
  sleep 1
/root/.meraki_mon_wlc/deploy_img.exp

fi
echo "Complete"
sleep 1                            
