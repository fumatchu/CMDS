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

${GREEN}For your image selection, please use the "full" IOS version image file name.${TEXTRESET}
${YELLOW}*Please do not rename the file. Use the original file from the Cisco Downloads Site*${TEXTRESET}
An example: cat9k_iosxe.17.12.03.SPA.bin

${RED}Do Not use the Lite Image here.${TEXTRESET}
An example: cat9k_lite_iosxe.17.12.03.SPA.bin

If you have 9200's and 9300/9500's in your envrionment, the server must decipher between
the FULL IOS image that is used on 9300/9500 and the "Lite" image that is used for 9200's.

EOF
echo ${GREEN}"Current MD5 Checksums and Image Names"${TEXTRESET}
md5sum ./* | sed -e 's/\.\///'
echo " "

echo " "
read -p "Please specify the image you would like to use: " IMAGE

cat <<EOF
${GREEN}Updating Preference${TEXTRESET}
EOF
sleep 1

sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/clean.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/deploy_img.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/deploy.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/deploy_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/deploy_img_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_ntp_server.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_ip_name-server.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_aaa_config.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_iprouting_config.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_config.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_defgw.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_vty.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_aaa_config_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_ntp_server_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_vty_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_ip_name-server_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_ip_domain_lookup_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_defgw_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_iprouting_config_single.exp


