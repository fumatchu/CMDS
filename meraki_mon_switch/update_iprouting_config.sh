#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update ip routing command${TEXTRESET}
This will allow you to update the ip routing entry on the Switches

ip routing must be enabled for on switch routing between the dashboard and the switch.
Even if you only have one SVI, ip routing must be enabled

EOF

read -r -p "Would you like to deploy these changes? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  clear
  echo ${GREEN}"Updating ip routing ${TEXTRESET}"
  sleep 1
  /root/.meraki_mon_switch/update_iprouting_config.exp
fi

clear
cat <<EOF
${GREEN}Gathering new Data${TEXTRESET}
EOF
sleep 1
/root/.meraki_mon_switch/update_config.exp
