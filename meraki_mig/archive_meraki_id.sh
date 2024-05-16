#!/bin/bash
#Shows Current processed switch and compatability
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)

clear
cat <<EOF
${GREEN}Current converted Switches${TEXTRESET}

Dumping Devices to /root/"Catalyst_Meraki_Inventory_${DATE}.log"
EOF

more /var/lib/tftpboot/*-shmr >>/root/"Catalyst_Meraki_Inventory_${DATE}.log"

echo "Please check the root directory for the logs"

read -p "Press Any Key"
