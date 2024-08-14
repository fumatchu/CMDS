#!/bin/bash
#Change SSH User Credentials
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Change SSH User Credentials${TEXTRESET}
EOF

read -p "Please provide the login for the Switch: " USER

cat <<EOF
${GREEN}Updating User Credentials${TEXTRESET}
EOF
sleep 1

sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/clean.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/deploy.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/deploy_img.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/deploy_single.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/deploy_img_single.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_ntp_server.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_ip_name-server.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_aaa_config.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_iprouting_config.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_config.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_defgw.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_vty.exp
