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

sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/clean.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/deploy.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/deploy_img.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/meraki_register.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/meraki_compat_check.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/dynamic_set_httpclient.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/dynamic_set_ns.exp
