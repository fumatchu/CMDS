#!/bin/bash
#Full Log Read Daily Full log
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date "+%Y%m%d")
clear
cat <<EOF
${GREEN}Log Search${TEXTRESET}
EOF

more /root/.meraki_mon_wlc/logs/avc_enable.log

cat <<EOF
#########
#########
#########
EOF
read -p "Press Enter"
