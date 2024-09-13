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
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/clean.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/deploy.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/deploy_img.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/meraki_register.exp
  sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/meraki_compat_check.exp
fi
