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

read -p "Please provide the login for the WLC: " USER

cat <<EOF
${GREEN}Updating User Credentials${TEXTRESET}
EOF
sleep 1

sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/clean.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/deploy.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/deploy_img.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_ip_name-server.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_config.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_aaa_config.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/register_wlc_2_cloud_check.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/register_wlc_2_cloud.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_avc_ta.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_ip_nbar.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_ntp_server.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_ntp_server_single.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_ip_name-server_single.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/network_test.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/network_test_wlan.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_config_single.exp
