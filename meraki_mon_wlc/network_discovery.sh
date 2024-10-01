#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
clear
sed -i '/^/d' /root/.meraki_mon_wlc/ip_list

touch /root/.meraki_mon_wlc/network_collection.tmp
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

#nmap -sn ${SUBNET} -oG /root/.meraki_mon_wlc/nmap_output | grep "Nmap scan report for" |cut -c22- > /root/.meraki_mon_wlc/discovered_ip

nmap -p 22 ${SUBNET} -oG /root/.meraki_mon_wlc/nmap_output > /dev/null 2>&1
cat /root/.meraki_mon_wlc/nmap_output | grep "22/open" | cut -c7- | cut -d "(" -f1 | sed -e 's/[\t ]//g;/^$/d'  > /root/.meraki_mon_wlc/discovered_ip


num_devices=$(< /root/.meraki_mon_wlc/discovered_ip wc -l)
echo "Total IP Based Devices with SSH enabled: ${num_devices}"

cat << EOF
Logging into Devices and Collecting Eligibility
This may take several minutes based on the subnet size
Please Wait...

EOF

/root/.meraki_mon_wlc/discovery.exp > /dev/null 2>&1

/root/.meraki_mon_wlc/network_discovery_collection.sh > /dev/null 2>&1


more /root/.meraki_mon_wlc/network_collection.tmp | tee -a /root/.meraki_mon_wlc/logs/network_discovery
echo "Actual Provisioned WLC" | tee -a /root/.meraki_mig/logs/network_discovery > /dev/null 2>&1


cat /root/.meraki_mon_wlc/ip_list >> /root/.meraki_mon_wlc/logs/network_discovery
cat_num_devices=$(< /root/.meraki_mon_wlc/ip_list wc -l)
echo " "
echo "Total Eligible Catalkyst 9800 Devices (9K): ${cat_num_devices}"
echo "Adding Eligible WLC to IP Batch List"
echo "The total estimated time to upgrade and install/reboot IOS-XE is:"
/root/.meraki_mon_wlc/time.sh

rm -r -f /root/.meraki_mon_wlc/network_collection.tmp
rm -r -f /var/lib/tftpboot/wlc/nwd*
rm -r -f /root/.meraki_mon_wlc/discovered_ip
rm -r -f /root/.meraki_mon_wlc/nmap_output
read -p "Press Enter"
