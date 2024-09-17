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
${YELLOW}*You Should be selecting cat9k_iosxe.17.09.03m3.SPA.bin{$TEXTRESET}

EOF

cd /var/lib/tftpboot/images
md5sum ./cat* | sed -e 's/\.\///'
echo " "
read -p "Please specify the image you would like to use: " IMAGE

cat <<EOF
${GREEN}Updating Preference${TEXTRESET}
EOF
sleep 1

sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mig/clean
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mig/deploy.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mig/deploy_img.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mig/meraki_register.exp
