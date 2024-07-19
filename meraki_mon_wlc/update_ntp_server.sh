#!/bin/bash
#Set the command ntp server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update IP Name Server on WLC${TEXTRESET}
This will allow you to update the ntp name server entry on the WLC

EOF

read -p "Please provide the NTP IP address you would like to use for time syncronization: " NTP
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the NTP IP address you would like to use for time syncronization: " NTP
done
clear
cat <<EOF
${GREEN}Updating ntp name server with IP address ${NTP} ${TEXTRESET}

EOF
sleep 1

sed -i "/set ntpserver/c\set ntpserver ${NTP}" /root/.meraki_mon_wlc/update_ntp_server.exp

/root/.meraki_mon_wlc/update_ntp_server.exp
clear
cat <<EOF
${GREEN}Gathering new Data${TEXTRESET}
EOF
sleep 1
/root/.meraki_mon_wlc/update_config.exp
