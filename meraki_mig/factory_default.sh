#!/bin/bash
#Change SSH User Credentials
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear
cat <<EOF
${GREEN}Factory Default/Cleanup${TEXTRESET}

This will archive all logs to an acrhive folder in the logs and root directory
It will also move the Registered Meraki Device (Serial and Hardware) to the root directory (for historical purposes)
All Configuration data, like Switch usernames, passwords, and the Meraki API key
will be destroyed. The application will be removed, and reinstalled from Git.
Upon reinstall, the server will prompt you to reboot.

${YELLOW}Use this process if you want to destroy all personal data, minus logs, or you want to start working in a different org${TEXTRESET}
EOF

read -r -p "Would you Like to run the factory reset now? [y/N]" -n 1
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
        cat <<EOF
${YELLOW}
*****************************
Retrieving Files from GitHub
*****************************
${TEXTRESET}
EOF

sleep 1
#Clone MIG
mkdir /root/MIGInstaller

git clone https://github.com/fumatchu/CMDS.git /root/MIGInstaller

chmod 700 /root/MIGInstaller/MIG*

#Move scripts
#Put meraki_migration in the path
rm -r -f /root/.meraki_mig/
mv -v /root/MIGInstaller/meraki_mig /root/.meraki_mig
mkdir /root/.meraki_mig/logs
chmod 700 -R /root/.meraki_mig
rm -f /usr/sbin/meraki_migration
mv /root/.meraki_mig/meraki_migration /usr/sbin/
#Create Directory for Active Templates
mkdir /root/.meraki_mig/templates/active

# Mr. M
chmod 700 /root/.meraki_mig/.logo

#Add DHCP Module
mv /root/MIGInstaller/.servman /root
chmod 700 -R /root/.servman

#Cleanup Install Files
sed -i '/MIGInstall.sh/d' /root/.bash_profile
rm -r -f /root/MIG*
rm -r -f /root/mig*
clear
cat <<EOF
${GREEN}
********************************
  Server Installation Complete
********************************
${TEXTRESET}

The server will reboot now
EOF
echo " "
read -p "Press Any Key to Continue"
echo ${RED}"Rebooting${TEXTRESET}"
sleep 1
reboot


fi
