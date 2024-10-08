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

${YELLOW}
*If you have just upgraded the IOS-XE version on an SSO pair, please wait at least 5 minutes before proceeding
The WLC's may still be syncing
${TEXTRESET}
EOF

read -p "Press Enter to Continue"
clear
/root/.meraki_mon_wlc/clean.exp
clear

rm -r -f /root/.meraki_mon_wlc/ip_list_single
touch /root/.meraki_mon_wlc/ip_list_single
sed -i '/^/d' /root/.meraki_mon_wlc/ip_list_single
touch /root/.meraki_mon_wlc/check.tmp

echo "############################Collection time ${DATE}######################################"
cat <<EOF
${GREEN}Validating Requirements${TEXTRESET}
EOF
sleep 1


# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"
  echo " "
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



  #Is the WLC in INSTALL Mode?
  echo "Checking INSTALL or BUNDLE Mode"
  INSTALLBUNDLE=$(cat /var/lib/tftpboot/wlc/${IP}-shver | sed '/INSTALL/q' | grep INSTALL | cut -c22-)
  if [ "$INSTALLBUNDLE" = "INSTALL" ]; then
    echo "${GREEN}WLC is in INSTALL Mode${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: The WLC is in BUNDLE mode. It must be converted to INSTALL Mode First${TEXTRESET}"
    echo "Please review the following Link:"
    echo "https://www.cisco.com/c/en/us/support/docs/wireless/catalyst-9800-series-wireless-controllers/217050-convert-installation
-mode-between-instal.html#toc-hId-1378002048"
    sleep 10
    echo ${RED}"Exiting...${TEXTRESET}"
  fi


  #Remnants of an old monitoring install?
  echo "Making sure meraki user does not exist"
  MERAKI_USER=$(cat /var/lib/tftpboot/wlc/${IP} | grep username | grep meraki)
  if [ "$MERAKI_USER" = "" ]; then
    echo "${GREEN}No Meraki User found${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: Found an instance of Meraki User in the username DB on the WLC. This must be resolved before proceeding${TEXTRESET}"
    echo "The usernames meraki-user and meraki-tdluser cannot pre-exist on the WLC when onboarding for Catalyst management"
    echo "Please review the requirements and remediation at:"
    echo "https://documentation.meraki.com/Cloud_Monitoring_for_Catalyst/Onboarding/Adding_Catalyst_9800_Wireless_Controller_and_Ac
cess_Points_to_Dashboard"
    echo ${RED}"Exiting...${TEXTRESET}"
    sleep 10
    exit
  fi


  #NTP Sync?
  echo "Checking NTP"
  NTP=$(cat /var/lib/tftpboot/wlc/${IP}-ntpsta | grep synchronized | sed -e 's/,.*$//' | cut -c10-)
  if [ "$NTP" = "synchronized" ]; then
    echo "${GREEN}NTP is synchronized${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: NTP is not synchronized. Please validate that your NTP is configured correctly${TEXTRESET}"
    echo ${YELLOW}"This can be manually corrected with Main Menu --> Utilities --> Deploy Global NTP Removal and Update${TEXTRESET}
"
    echo " "
    echo "1" >> /root/.meraki_mon_wlc/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue"${TEXTRESET}
    echo " "
    sleep 1
    echo $IP >> /root/.meraki_mon_wlc/ip_list_single
    /root/.meraki_mon_wlc/update_ntp_server_single.exp > /dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mon_wlc/ip_list_single
    sleep 2
  fi


  #Does the WLC  report at least one DNS entry?
  echo "Checking for DNS Name server"
  STATICNAMESERVER=$(cat /var/lib/tftpboot/wlc/${IP}-shipnm | grep 255.255.255.255)
  if [ "$STATICNAMESERVER" = "255.255.255.255" ]; then
    echo ${RED}"ERROR: A "name-server" entry  was not found"
    echo ${YELLOW}"This can be manually corrected with Main Menu-->Utilities-->Deploy Global Command for DNS${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_wlc/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue"${TEXTRESET}
    echo " "
    sleep 1
    echo $IP >> /root/.meraki_mon_wlc/ip_list_single
    /root/.meraki_mon_wlc/update_ip_name-server_single.exp > /dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mon_wlc/ip_list_single
    sleep 2
  else
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  fi


#Check if we have domain lookup configured

  echo "Checking for ip domain lookup Entry"
  LOOKUP=$(cat /var/lib/tftpboot/wlc/${IP}-lookup | head -6 | grep "Domain lookup" | cut -c20-)
  if [ "$LOOKUP" = "enabled" ]; then
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  else
    echo "${RED}ERROR: ip domain lookup was not found${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_wlc/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue"${TEXTRESET}
    echo " "
    sleep 1
    echo $IP >> /root/.meraki_mon_wlc/ip_list_single
    /root/.meraki_mon_wlc/update_ip_domain_lookup_single.exp > /dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mon_wlc/ip_list_single
    sleep 2
  fi

#Can we ping outside the Network with name resolution?
  echo "Pinging google.com"
  echo $IP >> /root/.meraki_mon_wlc/ip_list_single
  /root/.meraki_mon_wlc/network_test.exp > /root/.meraki_mon_wlc/network_test.tmp
  sed -i '/^/d' /root/.meraki_mon_wlc/ip_list_single
  PING=$(cat /root/.meraki_mon_wlc/network_test.tmp | grep Success |grep 100 | sed 's/(...........................................//')
  if [ "$PING" = "Success rate is 100 percent " ]; then
    echo "${GREEN}Success rate is 100 percent${TEXTRESET}"
    echo " "
  else
    echo "${YELLOW}WARNING: Expected 5 replies from google.com${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_wlc/check.tmp
    echo "The response was:"
    cat /root/.meraki_mon_wlc/network_test.tmp | grep Success
    echo " "
 fi


#Pinging from Wireless Management Interface
echo "Pinging google.com from WLAN Management Interface"
  WVLAN=$(cat /var/lib/tftpboot/wlc/${IP} | grep "wireless management" | cut -c31-)
  sed -i "/set wvlan/c\set wvlan ${WVLAN}" /root/.meraki_mon_wlc/network_test_wlan.exp
  /root/.meraki_mon_wlc/network_test_wlan.exp > /root/.meraki_mon_wlc/network_test_wlan.tmp
  PING=$(cat /root/.meraki_mon_wlc/network_test_wlan.tmp | grep Success |grep 100 | sed 's/(...........................................//')
  if [ "$PING" = "Success rate is 100 percent " ]; then
    echo "${GREEN}Success rate is 100 percent${TEXTRESET}"
    echo " "
  else
    echo "${YELLOW}WARNING: Expected 5 replies from google.com${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_wlc/check.tmp
    echo "The response was:"
    cat /root/.meraki_mon_wlc/network_test_wlan.tmp | grep Success
    echo " "
 fi


done <"$INPUT"

CHECK=$(cat /root/.meraki_mon_wlc/check.tmp | grep 1)
if grep -q '[^[:space:]]' "/root/.meraki_mon_wlc/check.tmp"; then
    echo "${RED}The WLC did not pass all checks. Please review the Pre-Check Log (If Needed)${TEXTRESET}"
    echo "${YELLOW}Main Menu --> Logs --> Meraki Precheck${TEXTRESET}"
    echo "CMDS has attempted to correct the issues, please re-run this script"
    echo "Main Menu--> Onboard WLC to Meraki Dashboard"
    echo " "
    echo "Exiting...."
    rm -r -f /root/.meraki_mon_wlc/check.tmp
    rm -r -f /root/.meraki_mon_wlc/ip_list_single
    rm -r -f /root/.meraki_mon_wlc/network_test_wlan.tmp
    rm -r -f /root/.meraki_mon_wlc/network_test.tmp
    sleep 10
    exit
  else
    echo ${GREEN}"All requirements met for Meraki Onboarding ${TEXTRESET}"
    echo " "
    rm -r -f /root/.meraki_mon_wlc/check.tmp
    rm -r -f /root/.meraki_mon_wlc/ip_list_single
    rm -r -f /root/.meraki_mon_wlc/network_test_wlan.tmp
    rm -r -f /root/.meraki_mon_wlc/network_test.tmp
    sleep 5
  fi

/root/.meraki_mon_wlc/register_wlc_2_cloud.sh
