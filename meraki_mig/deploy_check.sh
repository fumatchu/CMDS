#!/bin/bash
#deploy_check- Check reuirements to migrate Switch to Meraki Dashboard
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
INPUT="/root/.meraki_mig/ip_list"
switch_minimum=17.09
SINT="ip http client source-interface"
DATE=$(date)
clear
#Sanitize config files first
clear
rm -r -f /root/.meraki_mig/ip_list_single
#sed -i '/^/d' /root/.meraki_mig/ip_list_single
touch /root/.meraki_mig/ip_list_single
touch /root/.meraki_mig/check.tmp
clear
echo "############################Collection time ${DATE}######################################"
cat <<EOF

Collecting the current configuration
Please Wait...
EOF

/root/.meraki_mig/clean.exp >/dev/null 2>&1

cat <<EOF

Collecting Hardware Information
Please Wait...
EOF

/root/.meraki_mig/hardware_compat.exp >/dev/null 2>&1

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo " "
  echo ${YELLOW}"$IP"${TEXTRESET}
  echo "Checking IOS Version is 17.09.03m3 "
  #VERSION=$(cat /var/lib/tftpboot/mig_switch/${IP}-shver | grep "Cisco IOS Software" | cut -c84- | cut -d, -f1 | sed 's/\(.*\)..../\1/')
  #VERSIONFULL=$(cat /var/lib/tftpboot/mig_switch/${IP}-shver | grep "Cisco IOS XE Software, Version" | sed -e 's/\.//g')
  VERSIONFULL=$(cat /var/lib/tftpboot/mig_switch/${IP}-shver | grep "Cisco IOS XE Software, Version")
  echo "The switch Version is:"
  echo "${VERSIONFULL}"
  if [ "$VERSIONFULL" == "Cisco IOS XE Software, Version 17.09.03m3" ]; then
    echo "${GREEN}IOS-XE Version Matches Requirement${TEXTRESET}"
    echo " "
  else
    echo "${RED}ERROR:IOS-XE Needs Updating - The Version should be 17.09.03m3${TEXTRESET}"
    echo "1" >>/root/.meraki_mig/check.tmp
    echo " "
    sleep 3
  fi

  #Is the Switch in INSTALL Mode?
  echo "Checking INSTALL or BUNDLE Mode"
  #INSTALLBUNDLE=$(cat /var/lib/tftpboot/mig_switch/${IP}-shver | grep INSTALL | cut -c73-)
  INSTALLBUNDLE=$(cat /var/lib/tftpboot/mig_switch/${IP}-shver | sed '/INSTALL/q' | grep INSTALL | cut -c73-)
  if [ "$INSTALLBUNDLE" = "INSTALL" ]; then
    echo "${GREEN}Switch is in INSTALL Mode${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: The Switch is in BUNDLE mode. It must be converted to INSTALL Mode First${TEXTRESET}"
    echo " "
    echo "1" >>/root/.meraki_mig/check.tmp
    echo "Please refer to this document for further information:"
    echo "https://www.cisco.com/c/en/us/support/docs/switches/catalyst-9300-series-switches/216231-upgrade-guide-for-cisco-catalyst-9000-sw.html"
    sleep 5
    echo "Exiting the Check"
    sleep 2
    exit
  fi

  #Does the Switch have compatible Hardware?
  echo "Checking for Hardware compatability"
  HW=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | grep Incompatible | cut -c94-)
  if [ "$HW" = "Incompatible" ]; then
    echo ${RED}"ERROR: The Switch HW is not compatible. Please correct this issue first${TEXTRESET}"
    echo ${YELLOW}"If this is a Network Module incompatibility, you can unscrew and remove it. They are hot insertion ready.${TEXTRESET}"
    echo "1" >>/root/.meraki_mig/check.tmp
    more /var/lib/tftpboot/mig_switch/*shmrcompat | grep Incompatible -B9 -C1
  else
    echo "${GREEN}No Hardware Incompatabilities Found${TEXTRESET}"
    echo " "
  fi

  #Does the Switch have DHCP on at Least one interface?
  echo "Checking for DHCP Interface"
  DHCP=$(cat /var/lib/tftpboot/mig_switch/${IP}-shipintbr | grep DHCP | cut -c44- | sed 's/\(.*\)................................./\1/')
  if [ "$DHCP" = "DHCP" ]; then
    echo "${GREEN}We found an interface with DHCP${TEXTRESET}"
    echo " "
  else
    echo ${YELLOW}"CAUTION: A DHCP entry was not found on the switch${TEXTRESET}"
    echo "Per the Documentation, Please make sure DHCP will be available after the migration"
    echo " "
    sleep 3
  fi

  #Is the Switch presenting at least a GW of Last resort?
  echo "Checking for Default Gateway"
  ROUTE=$(cat /var/lib/tftpboot/mig_switch/${IP}-shroute | grep 0.0.0.0/0 | cut -c7- | sed 's/\(.*\)........................../\1/')
  if [ "$ROUTE" = "0.0.0.0" ]; then
    echo "${GREEN}Found GW of Last Resort${TEXTRESET}"
    echo " "
  else
    echo ${RED}"The switch requires a configuration of a default gateway${TEXTRESET}"
    echo "1" >>/root/.meraki_mig/check.tmp
    echo " "
    sleep 3
  fi

  #Does the Switch have ip http client-source command?
  echo "Checking for ip http client source-interface"
  SOURCEINTERFACE=$(cat /var/lib/tftpboot/mig_switch/${IP} | grep -o "ip http client source-interface")
  if [ "$SOURCEINTERFACE" = "ip http client source-interface" ]; then
    echo "${GREEN}We found an interface with http client${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: An entry on the switch with ip http client source-interface was not found${TEXTRESET}"
    echo "Per the Documentation, Please make sure the switch has this command on the internet facing vlan"
    echo ${YELLOW}"This can be corrected with Main Menu --> Utilities --> Global command for http client${TEXTRESET}"
    echo " "
    echo "1" >>/root/.meraki_mig/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue${TEXTRESET}"
    echo " "
    echo $IP >>/root/.meraki_mig/ip_list_single
    /root/.meraki_mig/update_httpclient_single.exp >/dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mig/ip_list_single
    sleep 2
  fi

  echo "Checking for DNS Entry if DHCP"
  NAMESERVER=$(grep . /var/lib/tftpboot/mig_switch/${IP}-shipnm)
  if [ "$NAMESERVER" != "" ]; then
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: A "name-server" entry  was not found on the switch please add one before continuing ${TEXTRESET}"
    echo ${YELLOW}"This can be corrected with Main Menu --> Utilities --> Global command for DNS${TEXTRESET}"
    echo " "
    echo "1" >>/root/.meraki_mig/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue"${TEXTRESET}
    echo " "
    sleep 1
    echo $IP >>/root/.meraki_mig/ip_list_single
    /root/.meraki_mig/update_ip_name-server_single.exp >/dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mig/ip_list_single
    sleep 2
  fi

  #Does the Switch report at least one DNS entry?
  echo "Checking for DNS Entry if statically assigned"
  STATICNAMESERVER=$(cat /var/lib/tftpboot/mig_switch/${IP}-shipnm | grep 255.255.255.255)
  if [ "$NAMESERVER" = "255.255.255.255" ]; then
    echo ${RED}"ERROR: A "name-server" entry  was not found on the switch please add one before continuing ${TEXTRESET}"
    echo ${YELLOW}"This can be corrected with Main Menu --> Utilities --> Global command for DNS${TEXTRESET}"
    echo " "
    echo "1" >>/root/.meraki_mig/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue"${TEXTRESET}
    echo " "
    sleep 1
    echo $IP >>/root/.meraki_mig/ip_list_single
    /root/.meraki_mig/update_ip_name-server_single.exp >/dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mig/ip_list_single
    sleep 2
  else
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  fi

  #Check if we have domain lookup configured
  echo "Checking for ip domain lookup Entry"
  LOOKUP=$(cat /var/lib/tftpboot/mig_switch/${IP}-lookup | head -6 | grep "Domain lookup" | cut -c20-)
  if [ "$LOOKUP" = "enabled" ]; then
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  else
    echo "${RED}ERROR: ip domain lookup was not found${TEXTRESET}"
    echo " "
    echo "1" >>/root/.meraki_mig/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue"${TEXTRESET}
    echo " "
    sleep 1
    echo $IP >>/root/.meraki_mig/ip_list_single
    /root/.meraki_mig/update_ip_domain_lookup_single.exp >/dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    sleep 2
  fi

  cat <<EOF

EOF

  #Can we ping outside the Network with name resolution?
  echo "Pinging google.com"
  echo $IP >>/root/.meraki_mig/ip_list_single
  /root/.meraki_mig/network_test.exp >/root/.meraki_mig/network_test.tmp
  sed -i '/^/d' /root/.meraki_mig/ip_list_single
  PING=$(cat /root/.meraki_mig/network_test.tmp | grep Success | grep 100 | sed 's/(...........................................//')
  if [ "$PING" = "Success rate is 100 percent " ]; then
    echo "${GREEN}Success rate is 100 percent${TEXTRESET}"
    rm -r -f /root/.meraki_mig/network_test.tmp
    sed -i '/^/d' /root/.meraki_mig/ip_list_single
    echo " "
  else
    echo "${YELLOW}WARNING: Expected 5 replies from google.com${TEXTRESET}"
    echo " "
    echo "1" >>/root/.meraki_mig/check.tmp
    echo "The response was:"
    cat /root/.meraki_mig/network_test.tmp | tail -4
    echo " "
    rm -r -f /root/.meraki_mig/network_test.tmp
    sed -i '/^/d' /root/.meraki_mig/ip_list_single
    echo " "
    sleep 2
  fi

done <"$INPUT"
#Committing Changes to Switches
cat <<EOF
Committing Switch Changes- This may take some time depending on the number of switches..
Please wait...

EOF
/root/.meraki_mig/clean.exp >/dev/null 2>&1

CHECK=$(cat /root/.meraki_mig/check.tmp | grep 1)
if grep -q '[^[:space:]]' "/root/.meraki_mig/check.tmp"; then
  echo "${RED}The Switches did not pass all checks. Please review the Pre-Check Log (If Needed)${TEXTRESET}"
  echo "${YELLOW}Main Menu --> Logs --> Deployment Log${TEXTRESET}"
  echo "CMDS has attempted to correct the issues, please re-run this script"
  echo "Main Menu--> Validate Switch/Deploy"
  rm -r -f /root/.meraki_mig/check.tmp
  rm -r -f /root/.meraki_mig/ip_list_single
  echo " "
else
  echo " "
  echo ${GREEN}"All requirements met for Meraki Onboarding ${TEXTRESET}"
  echo "Continuing deployment"
  sleep 2
  clear
  echo "Starting the Meraki Service on the Switches"
  echo "This may take a couple of minutes depending on the numbers of switches"
  echo "Please wait..."
  sleep 2
  clear &
  rm -r -f /root/.ssh/known_hosts &
  /root/.meraki_mig/meraki_register.exp
  clear
  echo "Choose the ORG/Network in which to place these switches"
  echo "The installer will continue shortly"
  sleep 2
  clear &
  /root/.meraki_mig/show_inv.sh
  clear &
  /root/.meraki_mig/hostname_collection.sh | tee -a /root/.meraki_mig/logs/hostname_deployment.log
fi

rm -r -f /root/.meraki_mig/check.tmp
rm -r -f /root/.meraki_mig/ip_list_single
echo "${GREEN}Script Complete${TEXTRESET}"
sleep 2
read -p "Press Enter"
