#!/bin/bash
#Factory default the Server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear
cat <<EOF
${GREEN}Factory Default/Cleanup${TEXTRESET}

This will destory all data except downloaded images in the /var/lib/tftpboot/images folder, creating a fresh install experience
The application will be removed, and reinstalled from Git.
Upon reinstall, the server will prompt you to reboot.

${YELLOW}Use this process if you want to destroy all personal data, and re-install from Github${TEXTRESET}
EOF

read -r -p "Would you Like to run the factory reset now? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  echo "Deleting all data and Archives"
  rm -f -r /root/archive/
  find /var/lib/tftpboot/ -mindepth 1 -path /var/lib/tftpboot/images -prune -o -exec rm -rf {} +
  rm -r -f /root/.meraki*
  rm -f /usr/sbin/meraki_migration
  sleep 2
  cat <<EOF
${YELLOW}
*****************************
Retrieving Files from GitHub
*****************************
${TEXTRESET}
EOF

  sleep 1
  cd /root
  #Clone MIG
  mkdir /root/MIGInstaller

  git clone https://github.com/fumatchu/CMDS.git /root/MIGInstaller

  chmod 700 /root/MIGInstaller/MIG*

  #Move scripts
  #Put meraki_migration in the path
  mv /root/MIGInstaller/meraki_mig /root/.meraki_mig
  #Catalyst Wireless Monitoring
  mv /root/MIGInstaller/meraki_mon_wlc /root/.meraki_mon_wlc
  #Catalyst Wireless Monitoring
  mv /root/MIGInstaller/meraki_mon_switch /root/.meraki_mon_switch
  #Catalyst Port Migration
  mv /root/MIGInstaller/meraki_port_mig /root/.meraki_port_mig

  #Create Logs Folders in all Meraki subdirectories
  find /root -type d -name ".meraki*" -exec mkdir -p {}/logs \;

  #Change executable
  chmod 700 -R /root/.meraki*

  #Move meraki_migration to path
  mv /root/.meraki_mig/meraki_migration /usr/sbin/
  mv -v /root/MIGInstaller/meraki_mig /root/.meraki_mig

  #Create Directory for Active Templates
  mkdir /root/.meraki_mig/templates/active
  #Create Linked Dircetory
  mkdir /root/.meraki_mig/templates/linked
  #Create Folder for imported port configurations into templates for pre-existing switches
  mkdir /root/.meraki_mig/templates/already_installed
  mkdir /root/.meraki_mig/templates/already_installed/active
  mkdir /root/.meraki_mig/templates/already_installed/linked

  #Create Switch files to modify for already configured switches
  touch /root/.meraki_mig/templates/already_installed/switch_serials_24.txt
  touch /root/.meraki_mig/templates/already_installed/switch_serials_48.txt

  #Create archives
  mkdir /root/archive
  mkdir /root/archive/CatalystConfigurations

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
  read -p "Press Enter to Continue"
  echo ${RED}"Rebooting${TEXTRESET}"
  rm -f /root/factory_default_action.sh
  sleep 1
  reboot

fi
