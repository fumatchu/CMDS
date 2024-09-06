#!/bin/bash
#Change IOS Image for deployment
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

${GREEN}Change Image to download to the WLC${TEXTRESET}

These are the current images on the Server

EOF

cd /var/lib/tftpboot/images
echo ${GREEN}"Current MD5 Checksums and Image Names"${TEXTRESET}
md5sum ./C9800* | sed -e 's/\.\///'
echo " "

read -p "Please specify the image you would like to use: " IMAGE
while [ -z "$IMAGE" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please specify the image you would like to use: " IMAGE
done

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
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_ntp_server.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_ntp_server_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_ip_name-server_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_config_single.exp

echo "${GREEN}Update Complete${TEXTRESET}"

