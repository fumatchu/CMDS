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
echo "############################Collection time ${DATE}######################################"
cat <<EOF
${YELLOW}Checking current Switch Config${TEXTRESET}

EOF
#!/bin/bash

# Set the input file name here
INPUT="/root/.meraki_mig/ip_list"

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
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
    sleep 3
  fi

  #Does the Switch have compatible Hardware?
  echo "Checking for Hardware compatability"
  HW=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmrcompat | grep Incompatible | cut -c94-)
  if [ "$HW" = "Incompatible" ]; then
    echo ${RED}"ERROR: The Switch HW is not compatible. Please correct this issue first${TEXTRESET}"
    echo ${YELLOW}"If this is a Network Module incompatibility, you can unscrew and remove it. They are hot insertion ready.${TEXTRESET}"
    more /var/lib/tftpboot/mig_switch/*shmrcompat | grep Incompatible -B9 -C1
  else
    echo "${GREEN}No Hardware Incompatabilities Found${TEXTRESET}"
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
    sleep 3
  fi

  echo "Checking for DNS Entry if DHCP"
  NAMESERVER=$(grep . /var/lib/tftpboot/mig_switch/${IP}-shipnm)
  if [ "$NAMESERVER" != "" ]; then
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  else
    echo ${RED}"ERROR: A "name-server" entry  was not found on the switch please add one before continuing ${TEXTRESET}"
    echo ${YELLOW}"This can be corrected with Main Menu --> Utilities --> Global command for DNS${TEXTRESET}"
    sleep 3
  fi

  #Does the Switch report at least one DNS entry?
  echo "Checking for DNS Entry if statically assigned"
  STATICNAMESERVER=$(cat /var/lib/tftpboot/mig_switch/${IP}-shipnm | grep 255.255.255.255)
  if [ "$NAMESERVER" = "255.255.255.255" ]; then
    echo ${RED}"ERROR: A "name-server" entry  was not found on the switch please add one before continuing ${TEXTRESET}"
    echo ${YELLOW}"This can be corrected with Main Menu --> Utilities --> Global command for DNS${TEXTRESET}"
    sleep 3
  else
    echo "${GREEN}No Errors${TEXTRESET}"
    echo " "
  fi
cat <<EOF

EOF
done <"$INPUT"
cat <<EOF
Please review the logs at MainMenu --> Logs --> Meraki Software/Hardware Log
${RED}If there are any errors, Please correct before proceeding${TEXTRESET}

${YELLOW}
###########################################################################################
After the Errors have been corrected (if any), Please Re-run the Meraki PreCheck Collection
###########################################################################################
${TEXTRESET}

The script will quit momentarily

EOF
sleep 10
