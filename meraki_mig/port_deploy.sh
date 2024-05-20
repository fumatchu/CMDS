#!/bin/bash
#shotgun port deployment access only 
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
DATE=$(date)
clear
SWITCH_TYPE=access
cat <<EOF

${GREEN}Create and Deploy Switch Template for ALL Imported switches${TEXTRESET}


This script will allow you to create an access template to speed up the default deployment of the switches.
The ports will be updated with the following settings:
        -Access Port
        -Access vlan (Number)
        -Voice VLAN Access (Number)
        -Spanning-tree "portfast" (RSTP Enabled)
        -Link Negotiation "Auto"
        -UDLD Alert Only
        -POE Enabled


EOF

read -p "Please provide the Access VLAN number for the ports: " ACCESS_VLAN
while [ -z "$ACCESS_VLAN" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide the Access VLAN number for the ports: " ACCESS_VLAN
done

read -p "Please provide the Voice VLAN number for the ports: " VOICE_VLAN
while [ -z "$VOICE_VLAN" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide the Voice VLAN number for the ports: " VOICE_VLAN
done

#Update the modify_port scripts for 24 and 48

sed -i "s/NEW_VLAN =/NEW_VLAN = ${ACCESS_VLAN}/" /root/.meraki_mig/modify_port_24.py
sed -i "s/NEW_VOICE_VLAN =/NEW_VOICE_VLAN = ${VOICE_VLAN}/" /root/.meraki_mig/modify_port_24.py

sed -i "s/NEW_VLAN =/NEW_VLAN = ${ACCESS_VLAN}/" /root/.meraki_mig/modify_port_48.py
sed -i "s/NEW_VOICE_VLAN =/NEW_VOICE_VLAN = ${VOICE_VLAN}/" /root/.meraki_mig/modify_port_48.py

echo "Gathering Data"

cat /var/lib/tftpboot/*-shmr >/root/.meraki_mig/build_port.tmp

echo "Splitting Port Densities"

rm -f /root/.meraki_mig/switch_serials_24.txt
rm -f /root/.meraki_mig/switch_serials_48.txt

cat /root/.meraki_mig/build_port.tmp | grep C9300-48 | grep -E -o "Q.{0,13}" >/root/.meraki_mig/switch_serials_48.txt
cat /root/.meraki_mig/build_port.tmp | grep C9300-24 | grep -E -o "Q.{0,13}" >/root/.meraki_mig/switch_serials_24.txt

cat <<EOF
Deploying changes

${YELLOW}Deploying 24 port Switch Template${TEXTRESET}
EOF
python3 /root/.meraki_mig/modify_port_24.py

cat <<EOF
${YELLOW}Deploying 48 port Switch Template${TEXTRESET}
EOF
python3 /root/.meraki_mig/modify_port_48.py

#cleanup
rm -f /root/.meraki_mig/build_port.tmp
rm -f /root/.meraki_mig/switch_serials_48.txt
rm -f /root/.meraki_mig/switch_serials_24.txt

sed -i "s/NEW_VLAN = ${ACCESS_VLAN}/NEW_VLAN =/" /root/.meraki_mig/modify_port_24.py
sed -i "s/NEW_VOICE_VLAN = ${VOICE_VLAN}/NEW_VOICE_VLAN =/" /root/.meraki_mig/modify_port_24.py

sed -i "s/NEW_VLAN = ${ACCESS_VLAN}/NEW_VLAN =/" /root/.meraki_mig/modify_port_48.py
sed -i "s/NEW_VOICE_VLAN = ${VOICE_VLAN}/NEW_VOICE_VLAN =/" /root/.meraki_mig/modify_port_48.py
sleep 4
