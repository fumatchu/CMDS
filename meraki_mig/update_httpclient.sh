#!/bin/bash
#Set the command "ip http client source-interface"
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Command Deploy${TEXTRESET}

This will allow you deploy the command ${YELLOW}"ip http client source-interface vlan (number)"${TEXTRESET}
to all the switches at once, in the IP list.
EOF

read -p "Please provide the Vlan Number in which you want to bind: " VLAN
while [ -z "$VLAN" ]; do
    echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
    read -p "Please provide the Vlan Number in which you want to bind: " VLAN
done

sed -i "/set vlan_num/c\set vlan_num ${VLAN}" /root/.meraki_mig/update_httpclient.exp
sed -i "/set vlan_num/c\set vlan_num ${VLAN}" /root/.meraki_mig/update_httpclient_single.exp

cat <<EOF
${GREEN}Updating VLAN ${TEXTRESET}

EOF
sleep 1

read -r -p "Would you Like to deploy this change now across the switches? [y/N]" -n 1
echo # (optional) move to a new line
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    echo "Deploying the command:"
    echo "ip http client source-interface vlan ${VLAN}"
    sleep 3
    /root/.meraki_mig/update_httpclient.exp
fi
cat <<EOF

The script will quit momentarily

EOF
sleep 5
