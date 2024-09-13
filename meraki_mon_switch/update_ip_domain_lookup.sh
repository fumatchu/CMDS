#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update Switch with ip domain lookup ${TEXTRESET}
This will allow you to update the ip domain lookup command

EOF

read -r -p "Would you like to deploy these changes to all switches now? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  clear
  echo ${GREEN}"Updating domain lookup command${TEXTRESET}"
  sleep 1
  /root/.meraki_mon_switch/update_ip_domain_lookup.exp
  /root/.meraki_mon_switch/update_ip_domain_lookup_single.exp
fi
echo ${GREEN}"Script Complete"${TEXTRESET}
sleep 2
