#!/bin/bash
#Pre-Check Script
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVER_IP=$(hostname -I)
INPUT="/root/.meraki_mon_switch/ip_list"
DATE=$(date)
touch /root/.meraki_mon_switch/check.tmp
clear
cat <<EOF
${GREEN}Catalyst Monitoring Setup${TEXTRESET}
This script will analyze your current configuration and make recommendations for Monitoring in the Meraki Dashboard
EOF

read -p "Press Enter to Continue"
clear
/root/.meraki_mon_switch/clean.exp
clear
cat <<EOF
############################Collection time ${DATE}######################################
${GREEN}Validating Requirements${TEXTRESET}
EOF
sleep 1
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
    echo " "
    echo "1" >> /root/.meraki_mon_switch/check.tmp
    echo "Please refer to this document for further information:"
    echo "https://www.cisco.com/c/en/us/support/docs/switches/catalyst-9300-series-switches/216231-upgrade-guide-for-cisco-catalyst-9000-sw.html"
    sleep 5
    echo "Exiting the Check"
    sleep 5
    exit
    
  fi

  #NTP Sync?
  echo "Checking NTP"
  NTP=$(cat /var/lib/tftpboot/mon_switch/${IP}-ntpsta | grep synchronized | sed -e 's/,.*$//' | cut -c10-)
  if [ "$NTP" = "synchronized" ]; then
    echo "${GREEN}NTP is synchronized${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: NTP is not syncronized. Please validate that your NTP is configured correctly${TEXTRESET}"
    echo ${YELLOW}"This can be manually corrected with Main Menu --> Utilities --> Deploy Global NTP Removal and Update${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_switch/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue"${TEXTRESET}
    echo " "
    sleep 1 
    /root/.meraki_mon_switch/update_ntp_server.exp > /dev/null 2>&1
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
    echo ${YELLOW}"This can be manually corrected with Main Menu --> Utilities --> Deploy Global command for DNS${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_switch/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue"${TEXTRESET}
    echo " "
    sleep 1 
    /root/.meraki_mon_switch/update_ip_name-server.exp > /dev/null 2>&1
    sleep 5
  fi

  #Does the switch report at least one DNS entry?
  echo "Checking for DNS Entry if Static assignment"
  STATICNAMESERVER=$(cat /var/lib/tftpboot/mon_switch/${IP}-shipnm | grep 255.255.255.255)
  if [ "$STATICNAMESERVER" = "255.255.255.255" ]; then
    echo ${RED}"ERROR: A "name-server" entry  was not found on the switch"
    echo ${YELLOW}"This can be manually corrected with Main Menu-->Utilities-->Deploy Global Command for DNS${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_switch/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue"${TEXTRESET}
    echo " "
    sleep 1 
    /root/.meraki_mon_switch/update_ip_name-server.exp > /dev/null 2>&1
    sleep 5
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
    echo "${RED}ERROR: ip domain lookup was not found${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_switch/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue"${TEXTRESET}
    echo " "
    sleep 1
    /root/.meraki_mon_switch/update_ip_domain_lookup.exp > /dev/null 2>&1
    sleep 5
  fi

#Check for aaa new-model

  echo "Checking for aaa new-model entry"
  AAA=$(cat /var/lib/tftpboot/mon_switch/${IP} | grep "aaa new-model")
  if [ "$AAA" = "aaa new-model" ]; then
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  else
    echo "${RED}ERROR: Could not find an Entry for aaa new model in the configuration${TEXTRESET}"
    echo ${YELLOW}"This can be manually corrected with Main Menu-->Utilities-->Deploy Global aaa new-model Update${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_switch/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue"${TEXTRESET}
    echo " "
    /root/.meraki_mon_switch/update_aaa_config.exp > /dev/null 2>&1
    sleep 5 
  fi

#Is IP routing enabled?
  echo "Checking for ip routing command"
  IPROUTE=$(cat /var/lib/tftpboot/mon_switch/${IP} | grep "ip routing")
  if [ "$IPROUTE" = "ip routing" ]; then
    echo "${GREEN}Found${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: Could not find ip routing in config. It must be enabled${TEXTRESET}"
    echo ${YELLOW}"This can be manually corrected with Main Menu-->Utilities-->Enable ip routing command${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_switch/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue${TEXTRESET}"
    echo " "
    /root/.meraki_mon_switch/update_iprouting_config.exp > /dev/null 2>&1
    sleep 5
  fi

#Is the Switch presenting at least a GW of Last resort?
  echo "Checking for Default Gateway"
  ROUTE=$(cat /var/lib/tftpboot/mon_switch/${IP}-shroute | grep 0.0.0.0/0 | cut -c7- | sed 's/\(.*\)......................../\1/')
  IPROUTE=$(cat /var/lib/tftpboot/mon_switch/${IP} | grep "ip route" | cut -c 1-24)
  if [ "$ROUTE" = "0.0.0.0/0" ] && [ "$IPROUTE" = "ip route 0.0.0.0 0.0.0.0" ]; then
    echo "${GREEN}Found GW of Last Resort${TEXTRESET}"
    echo " "
  else
    echo ${RED}"The switch requires a configuration of a default gateway${TEXTRESET}"
    echo ${YELLOW}"This can be manually corrected with Main Menu --> Utilities --> Deploy Default Route${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_switch/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue${TEXTRESET}"
    echo " "
    /root/.meraki_mon_switch/update_defgw.exp > /dev/null 2>&1
    sleep 5
  fi


done <"$INPUT"

CHECK=$(cat /root/.meraki_mon_switch/check.tmp | grep 1)
if grep -q '[^[:space:]]' "/root/.meraki_mon_switch/check.tmp"; then
    echo "${RED}The Switches did not pass all checks. Please review the Pre-Check Log (If Needed)${TEXTRESET}"
    echo "${YELLOW}Main Menu --> Logs --> Meraki Pre Check"
    echo "CMDS has attempted to correct the issues, please re-run this script"
    echo "Main Menu--> Meraki Pre-Check Collection"
    echo " "
  else
    echo ${GREEN}"All requirements met ${TEXTRESET}"
    echo " "
    sleep 5
  fi

rm -r -f /root/.meraki_mon_switch/check.tmp
echo "${GREEN}Script Complete${TEXTRESET}"
echo "Returning to the main menu shortly"
sleep 10
