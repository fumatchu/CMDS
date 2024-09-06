#!/bin/bash
#Pre-Check Log
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date "+%Y%m%d")
clear
cat <<EOF
${GREEN}Log Search${TEXTRESET}
EOF

more /root/.meraki_mon_switch/logs/network_discovery

cat <<EOF
#########
#########
#########
EOF
read -p "Press Enter"
