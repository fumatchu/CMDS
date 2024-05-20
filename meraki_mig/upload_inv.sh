#!/bin/bash
#DEFUNCT
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Upload Converted Serials to Meraki Dashboard${TEXTRESET}

The following serial numbers will be uploaded into the dashboard

EOF

cat /var/lib/tftpboot/*-shmr | grep -E -o "Q.{0,13}" >>/root/.meraki_mig/dashboard_upload

more /root/.meraki_mig/dashboard_upload

read -p "Press Any Key"
