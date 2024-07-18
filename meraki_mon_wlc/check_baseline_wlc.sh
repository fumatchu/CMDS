#!/bin/bash
#Pre-Check Script
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVER_IP=$(hostname -I)
INPUT="/root/.meraki_mon_wlc/ip_list"
DATE=$(date)
clear
cat <<EOF
${GREEN}WLC Monitoring Setup${TEXTRESET}
This script will analyze your current configuration and setup your WLC for Monitoring in the Meraki Dashboard
EOF

read -p "Press any Key to Continue"
clear
/root/.meraki_mon_wlc/clean.exp
clear
cat <<EOF
${GREEN}Validating that we are running the approved version of IOS-XE to migrate to Meraki${TEXTRESET}
EOF
sleep 1
echo "############################Collection time ${DATE}######################################"
# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"

  echo ${GREEN}"Checking IOS Version is 17.12.03${TEXTRESET} "
  VERSIONFULL=$(cat /var/lib/tftpboot/wlc/${IP}-shver | grep "Cisco IOS XE Software, Version")
  echo "The Version is:"
  echo "${YELLOW}${VERSIONFULL}${TEXTRESET}"
  if [ "$VERSIONFULL" == "Cisco IOS XE Software, Version 17.12.03" ]; then
    echo "${GREEN}IOS-XE Version Matches Requirement"${TEXTRESET}
    echo " "
    sleep 1
  else
    echo "${RED}ERROR:IOS-XE Needs Updating - The Version should be 17.12.03"${TEXTRESET}
    echo "${RED}Please upgrade to 17.12.03 before proceeding"${TEXTRESET}
    echo " "
    echo "Please use this link to determine your Upgrade path:"
    echo "https://www.cisco.com/c/en/us/td/docs/wireless/controller/9800/17-12/release-notes/rn-17-12-9800.html#upgrade"
    echo " "
    echo "Use this Link to download IOS-XE Software:"
    echo "https://software.cisco.com/download/home/286313582"
    echo " "
    echo ${RED}"Cancelling Additional Checks${TEXTRESET}"
    echo "Exiting..."
    sleep 10
    exit
  fi

done <"$INPUT"

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"

  #Is the WLC in INSTALL Mode?
  echo "Checking INSTALL or BUNDLE Mode"
  INSTALLBUNDLE=$(cat /var/lib/tftpboot/wlc/${IP}-shver | sed '/INSTALL/q' | grep INSTALL | cut -c22-)
  if [ "$INSTALLBUNDLE" = "INSTALL" ]; then
    echo "${GREEN}WLC is in INSTALL Mode${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: The Switch is in BUNDLE mode. It must be converted to INSTALL Mode First${TEXTRESET}"
    echo "Please review the following Link:"
    echo "https://www.cisco.com/c/en/us/support/docs/wireless/catalyst-9800-series-wireless-controllers/217050-convert-installation-mode-between-instal.html#toc-hId-1378002048"
    sleep 10
    echo ${RED}"Exiting...${TEXTRESET}"
  fi
  #cat <<EOF

  #EOF
done <"$INPUT"

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"

  #Remnants of an old mmonitoring install?
  echo "Making sure meraki user does not exist"
  MERAKI_USER=$(cat /var/lib/tftpboot/wlc/${IP} | grep username | grep meraki)
  if [ "$MERAKI_USER" = "" ]; then
    echo "${GREEN}No Meraki User found${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: Found an instance of Meraki User in the username DB on the WLC. This must be resolved before proceeding${TEXTRESET}"
    echo "The usernames meraki-user and meraki-tdluser cannot pre-exist on the WLC when onboarding for Catalyst management"
    echo "Please review the requirements and remediation at:"
    echo "https://documentation.meraki.com/Cloud_Monitoring_for_Catalyst/Onboarding/Adding_Catalyst_9800_Wireless_Controller_and_Access_Points_to_Dashboard"
    echo ${RED}"Exiting...${TEXTRESET}"
    sleep 10
    exit
  fi
  #cat <<EOF

  #EOF
done <"$INPUT"



# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"

  #NTP Sync?
  echo "Checking NTP"
  NTP=$(cat /var/lib/tftpboot/wlc/${IP}-ntpsta | grep synchronized | sed -e 's/,.*$//' | cut -c10-)
  if [ "$NTP" = "synchronized" ]; then
    echo "${GREEN}NTP is synchronized${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: NTP is not syncronized. Please validate that your NTP is configured correctly${TEXTRESET}"
    echo ${RED}"Exiting...${TEXTRESET}"
    sleep 5
  fi
  #cat <<EOF

  #EOF
done <"$INPUT"

while read -r IP; do
  # Print the IP address to the console
  echo "$IP"

  #Does the WLC  report at least one DNS entry?
  echo "Checking for DNS Name server"
  STATICNAMESERVER=$(cat /var/lib/tftpboot/wlc/${IP}-shipnm | grep 255.255.255.255)
  if [ "$STATICNAMESERVER" = "255.255.255.255" ]; then
    echo ${RED}"ERROR: A "name-server" entry  was not found on the WLC"
    echo ${YELLOW}"Please correct this with Main Menu-->Utilities-->Deploy Global Command for DNS, then try again${TEXTRESET}"
    echo ${RED}"Cancelling Additional Checks${TEXTRESET}"
    echo "Exiting..."
    sleep 5
    exit
  else
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  fi

done <"$INPUT"

#Check if we have domain lookup configured

while read -r IP; do
  # Print the IP address to the console
  echo "$IP"

  echo "Checking for ip domain lookup Entry"
  LOOKUP=$(cat /var/lib/tftpboot/wlc/${IP}-lookup | head -6 | grep "Domain lookup" | cut -c20-)
  if [ "$LOOKUP" = "enabled" ]; then
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  else
    echo "${RED}ERROR${TEXTRESET}"
    echo " "
  fi
done <"$INPUT"

#Check for aaa new-model

while read -r IP; do
  # Print the IP address to the console
  echo "$IP"

  echo "Checking for aaa new-model entry"
  AAA=$(cat /var/lib/tftpboot/wlc/${IP} | grep "aaa new-model")
  if [ "$AAA" = "aaa new-model" ]; then
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  else
    echo "${RED}ERROR${TEXTRESET}"
    echo " "
  fi

done <"$INPUT"

echo "Script Complete"
sleep 5
