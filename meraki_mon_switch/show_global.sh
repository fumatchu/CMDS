#!/bin/bash
#Show all relevant set Commands
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Show Global Settings ${TEXTRESET}
EOF

cat /root/.meraki_mon_switch/clean.exp | grep "set server_ip"
cat /root/.meraki_mon_switch/clean.exp | grep "set switch_user"
cat /root/.meraki_mon_switch/clean.exp | grep "set switch_pass"
cat /root/.meraki_mon_switch/clean.exp | grep "set image"
cat /root/.meraki_mon_switch/api_key.key
cat /root/.meraki_mon_switch/update_ntp_server.exp | grep "set ntpserver"
cat /root/.meraki_mon_switch/update_ip_name-server.exp | grep "set nameserver1"
cat /root/.meraki_mon_switch/update_ip_name-server.exp | grep "set nameserver2"
cat /root/.meraki_mon_switch/update_defgw.exp | grep "set def_gw"
echo " "
echo "Batch IP List"
more /root/.meraki_mon_switch/ip_list
echo " "
read -p "Press Enter"
