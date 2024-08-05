#!/bin/bash
#Pre-Check Script
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVER_IP=$(hostname -I)
INPUT="/root/.meraki_mon_switch/ip_list"
DATE=$(date)
clear
cat <<EOF
${GREEN}Catalyst Monitoring Setup${TEXTRESET}
This script will analyze your current configuration and make reccomendations for Monitoring in the Meraki Dashboard
EOF

read -p "Press any Key to Continue"
clear
/root/.meraki_mon_switch/clean.exp
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

  echo ${GREEN}"Checking IOS-XE Version${TEXTRESET} "
  VERSIONFULL=$(cat /var/lib/tftpboot/mon_switch/${IP}-shver | grep "Cisco IOS XE Software, Version")
  echo "The Current Version is:"
  echo "${YELLOW}${VERSIONFULL}${TEXTRESET}"
  echo " "
  sleep 1
#  if [ "$VERSIONFULL" == "Cisco IOS XE Software, Version 17.12.03" ]; then
#    echo "${GREEN}IOS-XE Version Matches Requirement"${TEXTRESET}
#    echo " "
#    sleep 1
#  else
#    echo "${RED}ERROR:IOS-XE Needs Updating - The Version should be 17.12.03"${TEXTRESET}
#    echo "${RED}Please upgrade to 17.12.03 before proceeding"${TEXTRESET}
#    echo " "
#    echo "Use this Link to download IOS-XE Software:"
#    echo "https://software.cisco.com/download/home/278875285"
#    echo " "
#    echo ${RED}"Cancelling Additional Checks${TEXTRESET}"
#    echo "Exiting..."
#    sleep 10
#    exit
#  fi



 #Is the Switch in INSTALL Mode?
  echo "Checking INSTALL or BUNDLE Mode"
  INSTALLBUNDLE=$(cat /var/lib/tftpboot/mon_switch/${IP}-shver | sed '/INSTALL/q' | grep INSTALL | cut -c73-)
  if [ "$INSTALLBUNDLE" = "INSTALL" ]; then
    echo "${GREEN}Switch is in INSTALL Mode${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: The Switch is in BUNDLE mode. It must be converted to INSTALL Mode First${TEXTRESET}"
    sleep 3
  fi

  #NTP Sync?
  echo "Checking NTP"
  NTP=$(cat /var/lib/tftpboot/mon_switch/${IP}-ntpsta | grep synchronized | sed -e 's/,.*$//' | cut -c10-)
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


#Does the Switch report at least one DNS entry if DHCP?
  echo "Checking for DNS Entry if DHCP assigned"
  NAMESERVER=$(grep . /var/lib/tftpboot/mon_switch/${IP}-shipnm)
  if [ "$NAMESERVER" != "" ]; then
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: A "name-server" entry  was not found on the switch please add one before continuing ${TEXTRESET}"
    echo ${YELLOW}"This can be corrected with Main Menu --> Utilities --> Global command for DNS${TEXTRESET}"
    sleep 3
  fi

  #Does the switch report at least one DNS entry?
  echo "Checking for DNS Entry if Static assignment"
  STATICNAMESERVER=$(cat /var/lib/tftpboot/mon_switch/${IP}-shipnm | grep 255.255.255.255)
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


#Check if we have domain lookup configured


  echo "Checking for ip domain lookup Entry"
  LOOKUP=$(cat /var/lib/tftpboot/mon_switch/${IP}-lookup | head -6 | grep "Domain lookup" | cut -c20-)
  if [ "$LOOKUP" = "enabled" ]; then
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  else
    echo "${RED}ERROR${TEXTRESET}"
    echo " "
  fi

#Check for aaa new-model

  echo "Checking for aaa new-model entry"
  AAA=$(cat /var/lib/tftpboot/mon_switch/${IP} | grep "aaa new-model")
  if [ "$AAA" = "aaa new-model" ]; then
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  else
    echo "${RED}ERROR${TEXTRESET}"
    echo " "
  fi

#Is IP routing enabled?
  echo "Checking for ip routing command"
  IPROUTE=$(cat /var/lib/tftpboot/mon_switch/${IP} | grep "ip routing")
  if [ "$IPROUTE" = "ip routing" ]; then
    echo "${GREEN}Found${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ip routing must be enabled${TEXTRESET}"
    sleep 3
  fi

#Is the Switch presenting at least a GW of Last resort?
  echo "Checking for Default Gateway"
  ROUTE=$(cat /var/lib/tftpboot/mon_switch/${IP}-shroute | grep 0.0.0.0/0 | cut -c7- | sed 's/\(.*\)........................../\1/')
  if [ "$ROUTE" = "0.0.0.0/0" ]; then
    echo "${GREEN}Found GW of Last Resort${TEXTRESET}"
    echo " "
  else
    echo ${RED}"The switch requires a configuration of a default gateway${TEXTRESET}"
    sleep 3
  fi


done <"$INPUT"

echo "${GREEN}Script Complete${TEXTRESET}"
sleep 5
