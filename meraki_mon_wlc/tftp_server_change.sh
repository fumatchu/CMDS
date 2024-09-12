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
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/clean.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/deploy.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/deploy_img.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/update_ip_name-server.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/update_config.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/update_aaa_config.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/register_wlc_2_cloud_check.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/register_wlc_2_cloud.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/update_config_single.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/discovery.exp
fi
