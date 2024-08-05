#!/bin/bash
#search current log (time and IP)
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date "+%Y%m%d")
clear
cat <<EOF
${GREEN}Log Search${TEXTRESET}
EOF


read -p "Please provide the IP Address to search:" IPADDR

cat /root/.meraki_mon_switch/logs/${DATE}.log | grep -wns ${IPADDR} -A40 | more

cat <<EOF
#########
#########
#########
EOF

read -p "Press Enter to Continue"
