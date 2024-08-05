#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear

cat <<EOF

${GREEN}Show PreConfigured Template(s)${TEXTRESET}

Current templates:

EOF



ls /root/.meraki_mig/templates/active

echo " "
read -p "Press Enter"
