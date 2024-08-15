#!/bin/bash
#Set the command ntp server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update IP Name Server${TEXTRESET}
This will allow you to update the ntp name server entry

EOF

read -p "Please provide the NTP IP address you would like to use for time syncronization: " NTP
while [ -z "$NTP" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the NTP IP address you would like to use for time syncronization: " NTP
done
clear
cat <<EOF

EOF
sleep 1

sed -i "/set ntpserver/c\set ntpserver ${NTP}" /root/.meraki_mon_switch/update_ntp_server.exp
sed -i "/set ntpserver/c\set ntpserver ${NTP}" /root/.meraki_mon_switch/update_ntp_server_single.exp


read -r -p "Would you like to deploy these changes to all switches now? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  clear
  ${GREEN}Updating ntp name server with IP address ${NTP} ${TEXTRESET}
  sleep 1
/root/.meraki_mon_switch/update_ntp_server.exp
fi
echo ${GREEN}"Script Complete"${TEXTRESET}
sleep 2
