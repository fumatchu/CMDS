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

${GREEN}Updating switch with "ip domain lookup" command ${TEXTRESET}

EOF

sleep 3

/root/.meraki_mon_switch/update_ip_domain_lookup.exp
clear
cat <<EOF
${GREEN}Gathering new Data${TEXTRESET}
EOF
sleep 1
/root/.meraki_mon_switch/update_config.exp
