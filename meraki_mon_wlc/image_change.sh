#!/bin/bash
#Change IOS Image for deployment
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Change Image to download to the switch${TEXTRESET}

These are the current images on the Server

EOF

ls -al /var/lib/tftpboot/images

echo " "
read -p "Please specify the image you would like to use: " IMAGE

cat <<EOF
${GREEN}Updating Preference${TEXTRESET}
EOF
sleep 1

sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/clean.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/deploy.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/deploy_img.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_ip_name-server.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_config.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_aaa_config.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/register_wlc_2_cloud_check.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/register_wlc_2_cloud.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_avc_ta.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_ip_nbar.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_config_single.exp
