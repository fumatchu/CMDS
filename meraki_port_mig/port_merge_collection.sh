=#!/bin/bash
#Create a layout of all the devices

rm -f /root/.meraki_port_mig/tmp/layout

mkdir -p /root/.meraki_port_mig/tmp
mkdir -p /root/port_migration
mkdir -p /root/port_migration/staging

INPUT="/root/.meraki_port_mig/ip_list"
# Read file line-by-line to get an IP address
while read -r IP; do

echo ${IP} >> /root/.meraki_port_mig/tmp/layout
MODEL=$(cat /var/lib/tftpboot/port_switch/${IP}-shver | grep "Model Number" | tr -d ' ' | awk '{print NR " " $0}')
echo "${MODEL}" >> /root/.meraki_port_mig/tmp/layout
echo " " >> /root/.meraki_port_mig/tmp/layout

done <"$INPUT"
sed -i '1i This is the mapping of all discovered devices' /root/.meraki_port_mig/tmp/layout
sed -i '2i for each switch merge in a stack you must specify a separate line to merge' /root/.meraki_port_mig/tmp/layout
sed -i '3i If there were two switches in a stack specify line 1 as IP address then the Switch number in the stack' /root/.meraki_port_mig/tmp/layou
t
sed -i '4i and the corresponding Meraki serial number mapping to that switch' /root/.meraki_port_mig/tmp/layout
sed -i '5i DELETE THE DISCOVERED DEVICES COLUMN (COLUMN A) AND THIS VERBIAGE BEFORE UPLOADING' /root/.meraki_port_mig/tmp/layout
sed -i '6i DISCOVERED DEVICES,IP_ADDRESS,SWITCH_NUMBER,MERAKI_SERIAL' /root/.meraki_port_mig/tmp/layout
sed -i '7i EXAMPLE,192.168.1.1,1,QXXX-XXXX-XXXX' /root/.meraki_port_mig/tmp/layout
sed -i '8i ,192.168.1.1,2,QXXX-XXXX-XXXX' /root/.meraki_port_mig/tmp/layout
cp /root/.meraki_port_mig/tmp/layout /root/port_migration/port_merge.csv
