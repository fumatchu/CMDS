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

read -p "Please provide the secondary DNS IP address you would like to use for name resolution: " NSIP2
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the secondary DNS IP address you would like to use for name resolution: " NSIP2
done
clear
cat <<EOF
${GREEN}Updating ip name server with IP address ${NSIP} ${TEXTRESET}
${GREEN}Updating ip name server with IP address ${NSIP2} ${TEXTRESET}

EOF
sleep 1

sed -i "/set nameserver1/c\set nameserver1 ${NSIP}" /root/.meraki_mon_wlc/update_ip_name-server.exp
sed -i "/set nameserver1/c\set nameserver1 ${NSIP}" /root/.meraki_mon_wlc/update_ip_name-server_single.exp
sed -i "/set nameserver2/c\set nameserver2 ${NSIP}" /root/.meraki_mon_wlc/update_ip_name-server.exp
sed -i "/set nameserver2/c\set nameserver2 ${NSIP}" /root/.meraki_mon_wlc/update_ip_name-server_single.exp

/root/.meraki_mon_wlc/update_ip_name-server.exp
clear
cat <<EOF
${GREEN}Gathering new Data${TEXTRESET}
EOF
sleep 1
/root/.meraki_mon_wlc/update_config.exp
