#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update IP Name Server on WLC${TEXTRESET}
This will allow you to update the ip name server entry on the WLC

EOF

read -p "Please provide the DNS IP address you would like to use for name resolution: " NSIP
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the DNS IP address you would like to use for name resolution: " NSIP
done
clear
cat <<EOF
${GREEN}Updating ip name server with IP address ${NSIP} ${TEXTRESET}

EOF
sleep 1

sed -i "/set nameserver/c\set nameserver ${NSIP}" /root/.meraki_mon_switch/update_ip_name-server.exp

/root/.meraki_mon_switch/update_ip_name-server.exp
clear
cat <<EOF
${GREEN}Gathering new Data${TEXTRESET}
EOF
sleep 1
/root/.meraki_mon_switch/update_config.exp
