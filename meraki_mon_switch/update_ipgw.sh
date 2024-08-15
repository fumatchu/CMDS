#!/bin/bash
#Set the def_gw
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update GW of Last resort on Switch${TEXTRESET}
This will allow you to update the default route on the switch

EOF

read -p "Please provide the IP address you would like to use for the Gateway of Last resort: " GWLR
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p  "Please provide the IP address you would like to use for the Gateway of Last resort:" GWLR
done

sed -i "/set def_gw/c\set def_gw ${GWLR}" /root/.meraki_mon_switch/update_defgw.exp
sed -i "/set def_gw/c\set def_gw ${GWLR}" /root/.meraki_mon_switch/update_defgw_single.exp

read -r -p "Would you like to deploy these changes to all switches now? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  clear
  echo ${GREEN}"Updating Gateway of Last Resort${TEXTRESET}"
  sleep 1
  /root/.meraki_mon_switch/update_defgw.exp
fi
echo ${GREEN}"Script Complete"${TEXTRESET}
sleep 2
