#!/bin/bash


#Create a layout of all the devices

TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVER_IP=$(hostname -I)

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
sed -i '3i If there were two switches in a stack specify line 1 as IP address then the Switch number' /root/.meraki_port_mig/tmp/layout
sed -i '4i mapping to that switch- In the example there are 4 switches in the stack all 24 port they are set to be merged' /root/.meraki_port_mig/tmp/layout
sed -i '5i DELETE THE DISCOVERED DEVICES COLUMN (COLUMN A) THIS VERBIAGE and ANY SPACES BEFORE UPLOADING' /root/.meraki_port_mig/tmp/layout
sed -i '6i DISCOVERED DEVICES,IP_ADDRESS,SWITCH_NUMBER,MERAKI_SERIAL' /root/.meraki_port_mig/tmp/layout
sed -i '7i EXAMPLE,192.168.1.1,1,Q111-1111-1111,' /root/.meraki_port_mig/tmp/layout
sed -i '8i ,192.168.1.1,2,Q111-1111-1111,' /root/.meraki_port_mig/tmp/layout
sed -i '9i ,192.168.1.1,3,Q222-2222-2222,' /root/.meraki_port_mig/tmp/layout
sed -i '10i ,192.168.1.1,4,Q222-2222-2222,' /root/.meraki_port_mig/tmp/layout


cp /root/.meraki_port_mig/tmp/layout /root/port_migration/port_merge.csv
rm -f /root/.meraki_port_mig/tmp/layout


cat << EOF

The Inventory csv file has been produced and is in the directory:

/root/port_migration

Which can be downloaded from this link:

EOF

echo "https://$SERVER_IP:9090/=$SERVER_IP/navigator" | tr -d '[:blank:]'

read -p "Press Enter"
