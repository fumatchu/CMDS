#!/bin/bash
#Update Server IP Address from Install
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVER_IP=$(hostname -I)
clear
cat <<EOF
${GREEN}Update Server IP${TEXTRESET}
EOF

echo "The current IP Address of the server is: ${SERVER_IP}"

read -r -p "Would you like to update this address? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  echo ${GREEN}"Updating Server IP${TEXTRESET}"
  sleep 1
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/clean.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/deploy.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/deploy_img.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/deploy_single.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/deploy_img_single.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/update_ntp_server.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/update_ip_name-server.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/update_aaa_config.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/update_iprouting_config.exp
fi
