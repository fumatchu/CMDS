#!/bin/bash
#Shows Current processed switch and compatability
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Current Converted Switches${TEXTRESET}

Current Batch Registered Devices

EOF

more /var/lib/tftpboot/*-shmr

read -p "Press Enter"

clear

echo ${GREEN}"Historical Registered Devices"${TEXTRESET}

more /root/archive/Catalyst_Meraki_Inventory*

read -p "Press Enter"
