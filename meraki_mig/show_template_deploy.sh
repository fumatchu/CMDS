#!/bin/bash
#search current template log-SN
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date "+%Y%m%d")
clear
cat <<EOF
${GREEN}Log Search${TEXTRESET}
EOF


read -p "Please provide the serial number to validate:" SN

more /root/.meraki_mig/logs/template_deployment.log | grep ${SN}

cat <<EOF
#########
#########
#########
EOF

read -p "Press Any Key"

