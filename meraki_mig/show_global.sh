#!/bin/bash
#Show all relevant set Commands
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Show Global Settings ${TEXTRESET}
EOF

cat /root/.meraki_mig/clean.exp | grep "set server_ip"
cat /root/.meraki_mig/clean.exp | grep "set switch_user"
cat /root/.meraki_mig/clean.exp | grep "set switch_pass"
cat /root/.meraki_mig/clean.exp | grep "set image"
cat /root/.meraki_mig/claim_devices.py | grep -m 1 "API_KEY"
echo " "
echo "Batch IP List"
more /root/.meraki_mig/ip_list
echo " "
read -p "Press Enter"
