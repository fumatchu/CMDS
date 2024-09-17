#!/bin/bash
#Query show meraki output to serials
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear


cat <<EOF
${GREEN}Hostname Migration${TEXTRESET}

${YELLOW}
Did you move the claimed devices from Inventory into the networks you want on your dashboard?
If you did not, please do so now.
This can be accomplished by selecting Organization --> Inventory, Search for 9300
Find the newly entered devices, select their checkbox, then Change Network Assignment
${TEXTRESET}
EOF

read -p "Press Enter to confirm you have made that change, and the migration will continue"

clear & /root/.meraki_mig/update_physical_address_switch.sh
clear & /root/.meraki_mig/hostname_collection.sh | tee -a /root/.meraki_mig/logs/hostname_deployment.log
