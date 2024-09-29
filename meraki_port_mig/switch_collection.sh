#!/bin/bash
#Create csv of collected switches
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)



INPUT="/root/.meraki_port_mig/ip_list"

# Read file line-by-line to get an IP address
while read -r IP; do

#Get IP Address
echo ${IP} >> /root/.meraki_port_mig/switch_collection.tmp


#Get hostname
    HOSTNAME=$(cat /var/lib/tftpboot/port_mig/${IP} | grep hostname | cut -c10-)
    echo "$HOSTNAME" >> /root/.meraki_port_mig/switch_collection.tmp

awk '{if(NR%2==0) {print var,$0} else {var=$0}}' /root/.meraki_port_mig/switch_collection.tmp >>/root/.meraki_port_mig/switch_collection.tmp1

#Get Switch Model
    SWITCHMODEL=$(cat /var/lib/tftpboot/port_mig/${IP}-shver | grep "Model Number" | tr -d "[:blank:]" | cut -c13-)
    echo "$SWITCHMODEL" >>/root/.meraki_port_mig/switch_collection.tmp1

awk '{if(NR%2==0) {print var,$0} else {var=$0}}' /root/.meraki_port_mig/switch_collection.tmp1 >>/root/.meraki_port_mig/switch_collection.tmp2

#Get Serial Number
    SWITCHSERIAL=$(cat /var/lib/tftpboot/port_mig/${IP}-shver | grep "Motherboard Serial Number" | tr -d "[:blank:]" | cut -c25-)
    echo "$SWITCHSERIAL" >>/root/.meraki_port_mig/switch_collection.tmp2

awk '{if(NR%2==0) {print var,$0} else {var=$0}}' /root/.meraki_port_mig/switch_collection.tmp2 >>/root/.meraki_port_mig/switch_collection.tmp3

sed -e "s/ /,/g" </root/.meraki_port_mig/switch_collection.tmp3 >>/root/.meraki_port_mig/switch_collection.csv

sed -i '1i IP_ADDRESS,HOSTNAME,MODEL,SERIAL' /root/switch_collection.csv

rm -f /root/switch_collection.tmp
rm -r /root/switch_collection.tmp1
rm -r /root/switch_collection.tmp2
rm -r /root/switch_collection.tmp3
