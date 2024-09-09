#!/bin/bash
#Hostname to Serial Mapping
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date "+%Y%m%d")
clear
cat <<EOF
${GREEN}Hostname to Serial Mapping${TEXTRESET}
EOF

more /root/.meraki_mon_wlc/logs/hostnames2serial.log

cat <<EOF
#########
#########
#########
EOF
read -p "Press Enter"
