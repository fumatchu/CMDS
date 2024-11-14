#!/bin/bash
#Setup Wizard
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
SERVER_IP=$(hostname -I)
IP=$(hostname -I)
clear
cat <<EOF
${GREEN}Setup Wizard${TEXTRESET}
This Wizard will allow you to configure this server for IOS-XE config harvesting, config manipulation and Meraki Registration


You must specify the following (via this wizard):
        -The SSH User (to login to the switch)
        -The SSH Password (to login to the switch)
        -The Meraki API Key for Dashboard integration
        -The IP addresses of the switches to migrate (management IP via VLAN), or use network discovery

Please keep in mind that it's required to have a privileged user (15) on the switch(es)
The server will want to be prompted in enable mode already (SSH should be enabled on the switch)
An Example configuration on the switch:

i.e. username ssh_user priv 15 password 0 password
     ip ssh ver 2
     line vty 0 4
     login local

Scenarios may differ in setups. However, it is expected that when the server logs into the switch, it be presented with already
being in enable mode (i.e. the prompt will look like this: ${GREEN}switch#${TEXTRESET}, not this ${RED}switch>${TEXTRESET}

Once you have met these requirements you may continue

EOF
read -p "Press Enter when ready"

clear

cat <<EOF
${GREEN}Change SSH User Credentials${TEXTRESET}
EOF

read -p "Please provide the user login for the Switch: " USER
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the user login for the Switch: " USER
done

cat <<EOF
${GREEN}Updating User Credentials${TEXTRESET}
EOF
sleep 1

sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/clean.exp
#sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/deploy.exp
#sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/deploy_img.exp
#sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/meraki_register.exp
#sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/meraki_compat_check.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/discovery.exp
#sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/get_ios_ver.exp
#sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/hardware_compat.exp
#sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/network_test.exp
#sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/update_httpclient_single.exp
#sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/update_httpclient.exp
#sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/update_ip_name-server_single.exp
#sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/update_ip_name-server.exp
#sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/update_ip_domain_lookup.exp
#sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_port_mig/update_ip_domain_lookup_single.exp
clear

cat <<EOF
${GREEN}Update Password Credential${TEXTRESET}
EOF
sleep 1
read -p "Please provide the password for the Switch: " PASS
while [ -z "$PASS" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the password for the Switch: " PASS
done

cat <<EOF
${GREEN}Updating Password Credential${TEXTRESET}
EOF
sleep 1

sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/clean.exp
#sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/deploy.exp
#sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/deploy_img.exp
#sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/meraki_register.exp
#sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/meraki_compat_check.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/discovery.exp
#sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/get_ios_ver.exp
#sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/hardware_compat.exp
#sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/network_test.exp
#sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/update_httpclient_single.exp
#sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/update_httpclient.exp
#sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/update_ip_name-server_single.exp
#sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/update_ip_name-server.exp
#sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/update_ip_domain_lookup.exp
#sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_port_mig/update_ip_domain_lookup_single.exp
clear
cat <<EOF
${GREEN}Update Server IP${TEXTRESET}
EOF

echo "The current IP Address of the server is: ${SERVER_IP}"
sleep 2
echo ${GREEN}"Updating Server IP for TFTP ${TEXTRESET}"
sleep 1
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/clean.exp
#sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/deploy.exp
#sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/deploy_img.exp
#sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/meraki_register.exp
#sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/meraki_compat_check.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/discovery.exp
#sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/get_ios_ver.exp
#sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/hardware_compat.exp
#sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/network_test.exp
#sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/update_httpclient_single.exp
#sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/update_httpclient.exp
#sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/update_ip_name-server_single.exp
#sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/update_ip_name-server.exp
#sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/update_ip_domain_lookup.exp
#sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_port_mig/update_ip_domain_lookup_single.exp
clear

cat <<EOF
${GREEN}Provide your Meraki API Key${TEXTRESET}

EOF
read -p "Please provide your Meraki API Key: " API_KEY

while [ -z "$API_KEY" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide your Meraki API Key: " API_KEY
done

#remove the instance of API Key first

sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_port_mig/claim_devices.py
#sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_port_mig/modify_port_24.py
#sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_port_mig/modify_port_48.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_port_mig/deploy_hostnames.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_port_mig/update_physical_address_switch.py
#sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_port_mig/make_network_switch.py
#sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_port_mig/port_migration.py


echo API_KEY = "\"${API_KEY}\"" >/root/.meraki_port_mig/api_key.key

sed -i '5 r /root/.meraki_port_mig/api_key.key' /root/.meraki_port_mig/claim_devices.py
#sed -i '5 r /root/.meraki_port_mig/api_key.key' /root/.meraki_port_mig/modify_port_24.py
#sed -i '5 r /root/.meraki_port_mig/api_key.key' /root/.meraki_port_mig/modify_port_48.py
sed -i '5 r /root/.meraki_port_mig/api_key.key' /root/.meraki_port_mig/deploy_hostnames.py
sed -i '5 r /root/.meraki_port_mig/api_key.key' /root/.meraki_port_mig/update_physical_address_switch.py
#sed -i '5 r /root/.meraki_port_mig/api_key.key' /root/.meraki_port_mig/make_network_switch.py
#sed -i '5 r /root/.meraki_port_mig/api_key.key' /root/.meraki_port_mig/port_migration.py

cat <<EOF
${GREEN}Update Complete${TEXTRESET}
EOF
sleep 1
clear

cat <<EOF
${GREEN}Adding Management IP Addresses to the Server for Collection${TEXTRESET}

There are two ways to collect the IP addresses of the Catalyst Switches that are eligible for onboarding.

You can:

Manually enter the IP addresses one by one, or

You can use the Network Discovery component.

Network Discovery will login via the subnet you specify, find all devices,
Then produce an invetory sheet for you of collected devices

EOF

echo "1. Enter the IP addresses Manually (I already have a list of IP Addresses with qualified devices)"
echo "2. Network Discovery"

read -p "Select option 1 or 2 " OPTION

while :
do
while [ -z "$OPTION" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Select option 1 or 2 " OPTION
done
# Check for the presence of numbers
  if ! [[ "$OPTION" =~ [1-2] ]]; then
    echo "${RED}Please select option 1 or 2 on your keyboard${TEXTRESET} "
   read -p "Select option 1 or 2: " OPTION
  fi
break;
done


if [ "$OPTION" = "1" ]; then
    clear
    echo "${GREEN}Manually Adding IP addresses${TEXTRESET}"
    echo ""
           echo "Please provde a list of IP addresses, one per line, in the following window."
       echo "The list must be dotted decimal notation, one per line, no spaces or carriage returns"
       echo "Here is an example:"
       echo " "
       echo "192.168.1.1"
       echo "192.168.1.2"
       echo "192.168.1.3"
       echo " "
       echo "The Wizard will continue shortly"
       sleep 10
       nano /root/.meraki_port_mig/ip_list
  else
    echo "${GREEN}Network Discovery${TEXTRESET}"
       clear
        /root/.meraki_port_mig/network_discovery.sh
  fi



clear

cat <<EOF
The Wizard is complete!

The following information has ben set:
Username to login to the switches: ${GREEN}${USER}${TEXTRESET}
Password to login to the switches: ${GREEN}${PASS}${TEXTRESET}


Start your first collection by selecting
${GREEN}Data Collection${TEXTRESET} from the Main Menu

EOF
read -p "Press Enter When Ready"