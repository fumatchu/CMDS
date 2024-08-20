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
rm -r -f /root/.meraki_mon_switch/ip_list_single
sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
touch /root/.meraki_mon_switch/ip_list_single


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

  echo ${GREEN}"Checking IOS-XE Version${TEXTRESET}"
  echo " "
x=$(cat /var/lib/tftpboot/mon_switch/$IP-shver |grep "Cisco IOS XE Software, Version" | cut -c32-)
first=${x%%.*}          # Delete first dot and what follows.
last=${x##*.}           # Delete up to last dot.
mid=${x##$first.}       # Delete first number and dot.
mid=${mid%%.$last}      # Delete dot and last number.
#echo $first $mid $last
echo "IOS-XE Version is ${YELLOW}$x${TEXTRESET}"
 if [ $first -ge 17 ] && [ $mid -ge 3 ] && [ $last -gt 1 ]; then
    echo "${GREEN}IOS-XE Version Meets Minimum Requirement${TEXTRESET}"
    echo " "
  else
    echo "${RED}ERROR: IOS-XE version does not meet the minimum requirement${TEXTRESET}"
    echo "Supported versions are IOS-XE 17.3 - 17.10.1, and 17.12.3"
    echo "Please see the following link to download:"
    echo "https://software.cisco.com/download/home"
    echo "A CCO ID is required"  
    sleep 5
    echo "Exiting the Check"
    sleep 2
    exit    
fi


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
    sleep 2
    exit
    
  fi

#Does the Switch allow VTY telnet output?
  echo "Checking for VTY to allow telnet out"
  VTY=$(cat /var/lib/tftpboot/mon_switch/${IP}-vty | grep "Allowed output transports are")
  if [ "$VTY" = "Allowed output transports are telnet ssh." ]; then
    echo "${GREEN}VTY OUTPUT for Telnet ALLOWED${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: VTY Lines must allow telnet for connectivity checking to *.tlsgw.meraki.com 443. It MUST be enabled${TEXTRESET}"
    echo ${YELLOW}"This can be manually corrected with Main Menu-->Utilities-->Deploy Global VTY Change for telnet output ${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_switch/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue${TEXTRESET}"
    echo " "
    echo $IP >> /root/.meraki_mon_switch/ip_list_single
    /root/.meraki_mon_switch/update_vty_single.exp > /dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    sleep 2
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
    echo $IP >> /root/.meraki_mon_switch/ip_list_single
    /root/.meraki_mon_switch/update_ntp_server_single.exp > /dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    sleep 2
  fi

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
    echo $IP >> /root/.meraki_mon_switch/ip_list_single
    /root/.meraki_mon_switch/update_ip_name-server_single.exp > /dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    sleep 2
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
    echo $IP >> /root/.meraki_mon_switch/ip_list_single
    /root/.meraki_mon_switch/update_ip_name-server_single.exp > /dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    sleep 2
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
    echo $IP >> /root/.meraki_mon_switch/ip_list_single
    /root/.meraki_mon_switch/update_ip_domain_lookup_single.exp > /dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    sleep 2
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
    echo $IP >> /root/.meraki_mon_switch/ip_list_single
    /root/.meraki_mon_switch/update_aaa_config_single.exp > /dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    sleep 2 
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
    echo "Looking for a pre-existing statement of ip default-gateway in the config:"
    sed -i '/IP=/d' /root/.meraki_mon_switch/ip_defgw_check.sh
    sed -i "3i IP=${IP}" /root/.meraki_mon_switch/ip_defgw_check.sh
    /root/.meraki_mon_switch/ip_defgw_check.sh
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    sleep 2
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
    echo $IP >> /root/.meraki_mon_switch/ip_list_single
    /root/.meraki_mon_switch/update_iprouting_config_single.exp > /dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    sleep 2
  fi

#Can we ping outside the Network with name resolution?
  echo "Pinging google.com"
  echo $IP >> /root/.meraki_mon_switch/ip_list_single
  /root/.meraki_mon_switch/network_test.exp > /root/.meraki_mon_switch/network_test.tmp
  sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
  PING=$(cat /root/.meraki_mon_switch/network_test.tmp | grep Success |grep 100 | sed 's/(...........................................//')
  if [ "$PING" = "Success rate is 100 percent " ]; then
    echo "${GREEN}Success rate is 100 percent${TEXTRESET}"
    rm -r -f /root/.meraki_mon_switch/network_test.tmp
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    echo " "
  else
    echo "${YELLOW}WARNING: Expected 5 replies from google.com${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_switch/check.tmp
    echo "The response was:"
    cat /root/.meraki_mon_switch/network_test.tmp | grep Success
    rm -r -f /root/.meraki_mon_switch/network_test.tmp
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    echo " "
    sleep 2
 fi

done <"$INPUT"

#Committing Changes to Switches
cat << EOF
Committing Switch Changes- This may take some time depending on the number of switches..
Please wait...

EOF
/root/.meraki_mon_switch/clean.exp > /dev/null 2>&1

CHECK=$(cat /root/.meraki_mon_switch/check.tmp | grep 1)
if grep -q '[^[:space:]]' "/root/.meraki_mon_switch/check.tmp"; then
    echo "${RED}The Switches did not pass all checks. Please review the Pre-Check Log (If Needed)${TEXTRESET}"
    echo "${YELLOW}Main Menu --> Logs --> Meraki Pre Check"
    echo "CMDS has attempted to correct the issues, please re-run this script"
    echo "Main Menu--> Meraki Pre-Check Collection"
    echo " "
  else
    echo " "
    echo ${GREEN}"All requirements met for Meraki Onboarding ${TEXTRESET}"
    echo " "
    sleep 5
  fi


rm -r -f /root/.meraki_mon_switch/check.tmp
rm -r -f /root/.meraki_mon_switch/ip_list_single
echo "${GREEN}Script Complete${TEXTRESET}"
echo "Returning to the main menu shortly"
sleep 10
