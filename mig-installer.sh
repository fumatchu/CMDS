#!/bin/bash
#mig-installer.sh #Bootstrap to GIT REPO
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
USER=$(whoami)
MAJOROS=$(cat /etc/redhat-release | grep -Eo "[0-9]" | sed '$d')
#Check for Network Connectivity
echo "Checking for Internet Connectivity"
echo " "
sleep 3
# Function to check DNS resolution
check_dns_resolution() {
    local domain=$1
    ping -c 1 $domain &> /dev/null
    return $?
}

# Function to ping an address
ping_address() {
    local address=$1
    ping -c 1 $address &> /dev/null
    return $?
}

# Flag to track if any test fails
test_failed=false

# Check DNS resolution for google.com
echo "Checking DNS resolution for google.com..."
if check_dns_resolution "google.com"; then
    echo "DNS resolution for google.com is successful."
else
    echo "DNS resolution for google.com failed."
    test_failed=true
fi

# Ping 8.8.8.8
echo "Trying to ping 8.8.8.8..."
if ping_address "8.8.8.8"; then
    echo "Successfully reached 8.8.8.8."
else
    echo "Cannot reach 8.8.8.8."
    test_failed=true
fi

# Provide final results summary
echo
echo "===== TEST RESULTS ====="
echo "DNS Resolution for google.com: $(if check_dns_resolution "google.com"; then echo "${GREEN}Passed"${TEXTRESET}; else echo "${RED}Failed"${TEXTRESET}; fi)"
echo "Ping to 8.8.8.8: $(if ping_address "8.8.8.8"; then echo "${GREEN}Passed"${TEXTRESET}; else echo "${RED}Failed"${TEXTRESET}; fi)"
echo "========================"
echo

# Prompt the user only if any test fails
if $test_failed; then
    read -p "One or more tests failed. Do you want to continue the script? (y/n): " user_input
    if [[ $user_input == "y" || $user_input == "Y" ]]; then
        echo "Continuing the script with failures"
        sleep 1
        # Place additional script logic here
    else
        echo "Please make sure that you have full Connectivty to the Internet Before Proceeding."
        exit 1
    fi
else
    echo "All tests passed successfully."
    sleep 3
    # Continue with the script or exit as needed
fi
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

items=(1 "Deploy CMDS for Rocky 8 - STABLE"
)

while choice=$(dialog --title "$TITLE" \
  --backtitle "Server Installer" \
  --menu "Please select the install type" 15 65 3 "${items[@]}" \
  2>&1 >/dev/tty); do
  case $choice in
  1) /root/MIGInstaller/MIGInstall8.sh ;;
  esac
done
clear # clear after user pressed Cancel
