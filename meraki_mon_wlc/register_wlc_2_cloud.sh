#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Register WLC to Cloud${TEXTRESET}
This will register the WLC to the Cloud

EOF

read -p "Press Any Key"

/root/.meraki_mon_wlc/register_wlc_2_cloud.exp

clear

cat <<EOF
${YELLOW}Waiting for WLC Registration${TEXTRESET}
EOF
sleep 20

/root/.meraki_mon_wlc/register_wlc_2_cloud_check.exp

clear

cat <<EOF
${GREEN}Current status of WLC Registration${TEXTRESET}
EOF
more /var/lib/tftpboot/wlc/sh-meraki-connect

read -p "Press Any Key"
