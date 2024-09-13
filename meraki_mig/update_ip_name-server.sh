#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update IP Name Server on Switch${TEXTRESET}
This will allow you to update the ip name server entry

EOF

read -p "Please provide the DNS IP address you would like to use for name resolution: " NSIP
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the DNS IP address you would like to use for name resolution: " NSIP
done

sed -i "/set nameserver1/c\set nameserver1 ${NSIP}" /root/.meraki_mig/update_ip_name-server.exp
sed -i "/set nameserver1/c\set nameserver1 ${NSIP}" /root/.meraki_mig/update_ip_name-server_single.exp


read -p "Please provide the secondary DNS IP address you would like to use for name resolution: " NSIP2
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the secondary DNS IP address you would like to use for name resolution: " NSIP2
done

sed -i "/set nameserver2/c\set nameserver2 ${NSIP2}" /root/.meraki_mig/update_ip_name-server.exp
sed -i "/set nameserver2/c\set nameserver2 ${NSIP2}" /root/.meraki_mig/update_ip_name-server_single.exp



read -r -p "Would you like to deploy these changes to all switches now? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  clear
  echo ${GREEN}"Updating Switches with ip name-server ${NSIP}${TEXTRESET}"
  echo ${GREEN}"Updating Switches with ip name-server ${NSIP2}${TEXTRESET}"
  sleep 1
 /root/.meraki_mig/update_ip_name-server.exp
fi
echo ${GREEN}"Script Complete"${TEXTRESET}
sleep 2
