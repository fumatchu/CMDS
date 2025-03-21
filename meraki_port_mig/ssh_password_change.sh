#!/bin/bash
#Change SSH Password Credentials
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Change SSH Password Credentials${TEXTRESET}
EOF

read -p "Please provide the password for the Switch: " PASS

cat <<EOF
${GREEN}Updating Password Credential${TEXTRESET}
EOF
sleep 1

sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/clean.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/discovery.exp
