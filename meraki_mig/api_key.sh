#!/bin/bash
#Change SSH User Credentials
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear
cat <<EOF
${Green} Please Provide your Meraki API Key ${TEXTRESET}

EOF
read -p "Please provide your Meraki API Key: " API_KEY

#remove the instance of API Key first

sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mig/claim_devices.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mig/modify_port_24.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mig/modify_port_48.py

echo API_KEY = "\"${API_KEY}\"" >/root/.meraki_mig/api_key.key

sed -i '5 r /root/.meraki_mig/api_key.key' /root/.meraki_mig/claim_devices.py
sed -i '5 r /root/.meraki_mig/api_key.key' /root/.meraki_mig/modify_port_24.py
sed -i '5 r /root/.meraki_mig/api_key.key' /root/.meraki_mig/modify_port_48.py

cat <<EOF
${GREEN}Update Complete${TEXTRESET}
EOF
sleep 2
