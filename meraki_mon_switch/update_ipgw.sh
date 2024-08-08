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
clear
cat <<EOF
${GREEN}Updating gateway of last resort with IP address ${GWLR} ${TEXTRESET}

EOF
sleep 1

sed -i "/set def_gw/c\set def_gw ${GWLR}" /root/.meraki_mon_switch/update_defgw.exp

/root/.meraki_mon_switch/update_defgw.exp
clear
cat <<EOF
${GREEN}Gathering new Data${TEXTRESET}
EOF
sleep 1
/root/.meraki_mon_switch/update_config.exp
