#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

sed -i '/^/d' /root/.meraki_mon_switch/ip_list

touch /root/.meraki_mon_switch/network_collection.tmp
cat << EOF
${GREEN}Network Discovery${TEXTRESET}

EOF
read -p "Please provide the subnet to scan in CIDR notation (i.e. 192.168.240.0/24): " SUBNET
while [ -z "$SUBNET" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the subnet to scan in CIDR notation (i.e. 192.168.240.0/24): " SUBNET
done

echo "Running Scan"
nmap -sn ${SUBNET} -oG nmap_output | grep "Nmap scan report for" |cut -c22- > /root/.meraki_mon_switch/discovered_ip

num_devices=$(< /root/.meraki_mon_switch/discovered_ip wc -l)
echo "Total IP Based Devices found: ${num_devices}"

cat << EOF
Logging into Switches and Collecting Eligibility
This may take several minutes based on the subnet size
Please Wait...
EOF

/root/.meraki_mon_switch/discovery.exp > /dev/null 2>&1

/root/.meraki_mon_switch/network_discovery_collection.sh > /dev/null 2>&1

more /root/.meraki_mon_switch/network_collection.tmp

cat_num_devices=$(< /root/.meraki_mon_switch/network_collection.tmp wc -l)

echo "Total Eligible Catalyst Devices (9K): ${cat_num_devices}"
echo "Adding Eligible Switches to IP Batch List"
echo "The total timtimated time  to upgrade and install/reboot IOS-XE is:"
/root/.meraki_mon_switch/time.sh

rm -r -f /root/.meraki_mon_switch/network_collection.tmp
read -p "Press Enter"
