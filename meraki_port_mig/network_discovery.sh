#!/bin/bash
#Get Network Devices
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
clear
sed -i '/^/d' /root/.meraki_port_mig/ip_list

touch /root/.meraki_port_mig/network_collection.tmp
cat << EOF
${GREEN}Network Discovery${TEXTRESET}

EOF
read -p "Please provide the subnet to scan in CIDR notation (i.e. 192.168.240.0/24): " SUBNET
while [ -z "$SUBNET" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the subnet to scan in CIDR notation (i.e. 192.168.240.0/24): " SUBNET
done

echo "Running Scan"
echo "This may take several minutes depending on the subnet size"
echo "Please Wait..."
echo " "

#nmap -sn ${SUBNET} -oG /root/.meraki_port_mig/nmap_output | grep "Nmap scan report for" |cut -c22- > /root/.meraki_port_mig/discovered_ip

nmap -p 22 ${SUBNET} -oG /root/.meraki_port_mig/nmap_output > /dev/null 2>&1
cat /root/.meraki_port_mig/nmap_output | grep "22/open" | cut -c7- | cut -d "(" -f1 | sed -e 's/[\t ]//g;/^$/d'  > /root/.meraki_port_mig/discovered_ip


num_devices=$(< /root/.meraki_port_mig/discovered_ip wc -l)
echo "Total IP Based Devices with SSH enabled: ${num_devices}"

cat << EOF
Logging into Switches and Collecting Eligibility
This may take several minutes based on the subnet size
Please Wait...
EOF

#/root/.meraki_port_mig/discovery.exp > /dev/null 2>&1
/root/.meraki_port_mig/discovery.exp
#/root/.meraki_port_mig/network_discovery_collection.sh > /dev/null 2>&1
#/root/.meraki_port_mig/network_discovery_collection.sh

more /root/.meraki_port_mig/network_collection.tmp | tee -a /root/.meraki_port_mig/logs/network_discovery
echo "Actual Provisioned Switches" | tee -a /root/.meraki_port_mig/logs/network_discovery > /dev/null 2>&1

cat /root/.meraki_port_mig/discovered_ip > /root/.meraki_port_mig/ip_list

#INPUT="/root/.meraki_port_mig/ip_list"

# Read file line-by-line to get an IP address

#while read -r IP; do

#Is the Switch already provisioned?
#    MUSER=$(cat /var/lib/tftpboot/port_switch/nwd-${IP}-shrunn | grep -Eo -m 1 "username meraki-user" | cut -c10-)
#if [ "$MUSER" = "meraki-user" ]; then
#    echo "${YELLOW}It looks like ${IP} is already provisioned for Catalyst Monitoring"${TEXTRESET}
#    echo "${RED}Skipping..."${TEXTRESET}
#    sed -i "0,/${IP}/d" /root/.meraki_port_mig/ip_list
#    else
#    echo " "

#fi

#done <"$INPUT"

cat /root/.meraki_port_mig/ip_list >> /root/.meraki_port_mig/logs/network_discovery
cat_num_devices=$(< /root/.meraki_port_mig/ip_list wc -l)
echo " "
echo "Total Devices Found: ${cat_num_devices}"

rm -f /root/.meraki_port_mig/network_collection.tmp
rm -f /var/lib/tftpboot/port_switch/nwd*
rm -f /root/.meraki_port_mig/discovered_ip
rm -f /root/.meraki_port_mig/nmap_output
read -p "Press Enter"
