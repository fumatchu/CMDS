#!/bin/bash
#Batch Clean for Server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
DATEDAY=$(date +"%m-%d-%y")
clear
cat <<EOF
${GREEN}Batch Cleanup${TEXTRESET}

This will archive all logs to an acrhive folder in the logs and root directory
It will also move the Registered Meraki Device (Serial and Hardware)
To the root directory (for historical purposes)
Configuration data, like Switch usernames, passwords, and the Meraki API key
will exist for the next batch processing. However, the Batch IP List
will be removed.

${YELLOW}
This process must be ran between batches (switch groups-IP Address groups)
However DO NOT run this if you are in an active group deployment.
Make sure at a minimum you have migrated the hostnames over.
${TEXTRESET}
EOF

read -r -p "Would you Like to run the batch cleanup now? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        clear
        echo ${YELLOW}"Archiving the logs files"${TEXTRESET}
        mkdir /root/.meraki_mig/logs/"archive-logs-${DATE}"
        mv -v /root/.meraki_mig/logs/*.log /root/.meraki_mig/logs/"archive-logs-${DATE}"/
        mkdir /root/archive/c9300_migration
        \cp -R /root/.meraki_mig/logs/"archive-logs-${DATE}"/ /root/archive/c9300_migration
        echo ${YELLOW}"Dumping Device information to /root/archive/Catalyst_c9300_Meraki_Inventory_${DATE}.log"${TEXTRESET}
        more /var/lib/tftpboot/mig_switch/*-shmr >>/root/archive/"Catalyst_c9300_Meraki_Inventory_${DATE}.log"
        echo ${YELLOW}"Moving all Catalyst configs to the root folder"${TEXTRESET}
       # find /var/lib/tftpboot/. -name . -o -type d -prune -o -exec sh -c 'mv "$@" "$0"' /root/archive/CatalystConfigurations/ {} +
        mkdir /root/archive/CatalystConfigurations/"${DATEDAY}"
        mv -v /var/lib/tftpboot/mig_switch/* /root/archive/CatalystConfigurations/"${DATEDAY}"/
        rm -f /root/.meraki_mig/switch_serials*
        echo ${YELLOW}"Cleaning the Batch IP List"${TEXTRESET}
        rm -f /root/.meraki_mig/ip_list
        touch /root/.meraki_mig/ip_list
        sleep 2

fi




read -r -p "Would you Like to re-run the wizard for a new batch of Switches? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        clear
        /root/.meraki_mig/wizard.sh
fi



cat << EOF
${GREEN}
Cleanup Complete!
${TEXTRESET}
EOF
read -p "Press Enter"
