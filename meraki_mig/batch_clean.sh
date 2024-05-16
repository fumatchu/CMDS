#!/bin/bash
#Change SSH User Credentials
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear
cat <<EOF
${GREEN}Batch Cleanup${TEXTRESET}

This will archive all logs to an acrhive folder in the logs and root directory
It will also move the Registered Meraki Device (Serial and Hardware)
To the root directory (for historical purposes)
Configuration data, like Switch usernames, passwords, and the Meraki API key
will exist for the next batch processing.

${YELLOW}This process must be ran between batches (switch groups)${TEXTRESET}
EOF

read -r -p "Would you Like to run the batch cleanup now? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        echo "Archiving the logs files"
        mkdir /root/.meraki_mig/logs/"archive-logs-${DATE}"
        mv -v /root/.meraki_mig/logs/*.log /root/.meraki_mig/logs/"archive-logs-${DATE}"/
        \cp -R /root/.meraki_mig/logs/"archive-logs-${DATE}"/ /root/archive
        echo "Dumping Device information to /root/archive/Catalyst_Meraki_Inventory_${DATE}.log"
        more /var/lib/tftpboot/*-shmr >>/root/archive/"Catalyst_Meraki_Inventory_${DATE}.log"
        echo "Moving all Catalyst configs to the root folder"
        find /var/lib/tftpboot/. -name . -o -type d -prune -o -exec sh -c 'mv "$@" "$0"' /root/archive/CatalystConfigurations/ {} +
        rm -f /root/.meraki_mig/switch_serials*
        sleep 2

fi
