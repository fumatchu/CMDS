#!/bin/bash
#mig-installer.sh #Bootstrap to GIT REPO
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)
MAJOROS=$(cat /etc/redhat-release | grep -Eo "[0-9]" | sed '$d')

#Checking for user permissions
if [ "$USER" = "root" ]; then
  echo " "
else
  echo ${RED}"This program must be run as root ${TEXTRESET}"
  echo "Exiting"
  sleep 2
  exit
fi
#Checking for version Information
#if [ "$MAJOROS" = "9" ]; then
#  echo " "
#else
#  echo ${RED}"Sorry, but this installer only works on Rocky 9.X ${TEXTRESET}"
#  echo "Please upgrade to ${GREEN}Rocky 9.x${TEXTRESET}"
#  echo "Exiting the installer..."
#  sleep 2
#  exit
#fi

cat <<EOF
${GREEN}
***************************************
Please wait while we gather some files
***************************************
${TEXTRESET}


${YELLOW}Installing wget and git${TEXTRESET}
EOF
sleep 1

dnf -y install wget git dialog

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


clear
#cat <<EOF
# *********************************************

# This script was created for ${GREEN}Rocky 9.x${TEXTRESET}
# This will install 

# 1. CMDS with C9300 Migration capabilities
# 2. CMDS with Catalyst Wireless Monitoring (setup) capabilities 
 
# What this script does:
# 1. Apply appropriate SELinux context and Firewall rules
# 2. Install the REPO(s) needed and dependencies needed
# 3. Configure the system as needed, based on your answers
# 4. Provides an (optional) Name Server
# 5. Provides an (optional) DHCP Server
# 6. Provides a tftp collection server
# 7. Provides all the scripts to migrate the c9300's
# 8. Provides all the scripts to setup Catalyst Monitoring for c9800s

#*********************************************
 

#EOF

#read -p "Press Enter to Continue"

items=(1 "Deploy CMDS for Rocky 9"
       2 "Deploy CMDS for Rocky 8 - BETA"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Server Installer" \
  --menu "Please select the install type" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/MIGInstaller/MIGInstall.sh ;;
  2) /root/MIGInstaller/MIGInstall8.sh ;;
  esac
done
clear # clear after user pressed Cancel
