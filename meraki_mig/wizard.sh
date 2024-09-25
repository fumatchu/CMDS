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
This Wizard will allow you to configure this server for IOS-XE deployment and Meraki Registration
You must upload the IOS-XE image(s) that you need into the images directory of this tftp server.

The current, supported IOS-XE image for Meraki migration is:
${YELLOW}17.9.3m3${TEXTRESET}

And can be downloaded at:
https://software.cisco.com/download/specialrelease/b53558e8586d98df4e9e7860c7692e75

${YELLOW}*A Valid CCO ID is required to download this code*${TEXTRESET}

Once you have downloaded the image, you must place it into:

/var/lib/tftpboot/images

You can accomplish this by uploading the files via SCP and copying them, or you can login to this server at
EOF

echo "https://$IP:9090/=$IP/navigator" | tr -d '[:blank:]'

cat <<EOF

and use the Navigator component on the left hand side

Once you have uploaded the IOS images, then you must specify the following (via this wizard):
        -The SSH User (to login to the switch)
        -The SSH Password (to login to the switch)
        -The Meraki API Key for Dashboard integration
        -The IOS image you would like to use (must be uploaded first)
        -The IP addresses of the switches to migrate (management IP via VLAN)

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

sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/clean.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/deploy.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/deploy_img.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/meraki_register.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/meraki_compat_check.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/discovery.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/get_ios_ver.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/hardware_compat.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/network_test.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/update_httpclient_single.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/update_httpclient.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/update_ip_name-server_single.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/update_ip_name-server.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/update_ip_domain_lookup.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mig/update_ip_domain_lookup_single.exp
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

sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/clean.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/deploy.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/deploy_img.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/meraki_register.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/meraki_compat_check.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/discovery.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/get_ios_ver.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/hardware_compat.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/network_test.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/update_httpclient_single.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/update_httpclient.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/update_ip_name-server_single.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/update_ip_name-server.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/update_ip_domain_lookup.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mig/update_ip_domain_lookup_single.exp
clear
cat <<EOF
${GREEN}Update Server IP${TEXTRESET}
EOF

echo "The current IP Address of the server is: ${SERVER_IP}"
sleep 2
echo ${GREEN}"Updating Server IP for TFTP ${TEXTRESET}"
sleep 1
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/clean.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/deploy.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/deploy_img.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/meraki_register.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/meraki_compat_check.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/discovery.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/get_ios_ver.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/hardware_compat.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/network_test.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/update_httpclient_single.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/update_httpclient.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/update_ip_name-server_single.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/update_ip_name-server.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/update_ip_domain_lookup.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mig/update_ip_domain_lookup_single.exp
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

sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mig/claim_devices.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mig/modify_port_24.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mig/modify_port_48.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mig/deploy_hostnames.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mig/update_physical_address_switch.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mig/make_network_switch.py

echo API_KEY = "\"${API_KEY}\"" >/root/.meraki_mig/api_key.key

sed -i '5 r /root/.meraki_mig/api_key.key' /root/.meraki_mig/claim_devices.py
sed -i '5 r /root/.meraki_mig/api_key.key' /root/.meraki_mig/modify_port_24.py
sed -i '5 r /root/.meraki_mig/api_key.key' /root/.meraki_mig/modify_port_48.py
sed -i '5 r /root/.meraki_mig/api_key.key' /root/.meraki_mig/deploy_hostnames.py
sed -i '5 r /root/.meraki_mig/api_key.key' /root/.meraki_mig/update_physical_address_switch.py
sed -i '5 r /root/.meraki_mig/api_key.key' /root/.meraki_mig/make_network_switch.py

cat <<EOF
${GREEN}Update Complete${TEXTRESET}
EOF
sleep 1
clear

cat <<EOF
Before continuing, please make sure you have uploaded the (IOS-XE) images you want/need to use, in the directory:

/var/lib/tftpboot/images

You can either upload these via SCP, or you can use the navigator component, mentioned earlier:

EOF

echo "https://$IP:9090/=$IP/navigator" | tr -d '[:blank:]'

echo " "

read -p "Press Enter When Ready"
clear


cd /var/lib/tftpboot/images
echo ${GREEN}"Current MD5 Checksums and Image Names"${TEXTRESET}

#md5sum ./cat* | sed -e 's/\.\///'
md5sum cat9k_iosxe.17.09.03m3.SPA.bin
echo " "
read -p "Please specify the image you would like to use: " IMAGE
while [ -z "$IMAGE" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please specify the image you would like to use: " IMAGE
done

cat <<EOF
${GREEN}Updating Preference${TEXTRESET}
EOF
sleep 1

sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mig/clean.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mig/deploy_img.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mig/deploy.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mig/meraki_register.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mig/discovery.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mig/get_ios_ver.exp
clear
cat <<EOF
${GREEN}Update Complete${TEXTRESET}

EOF

clear
cat <<EOF
${GREEN}Provide VLAN for ip http client${TEXTRESET}

This will allow you deploy the command ${YELLOW}"ip http client source-interface vlan (number)"${TEXTRESET}
This should be applied to the Internet facing VLAN
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


clear

read -p "Please provide the DNS IP address you would like to use for name resolution: " NSIP
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the DNS IP address you would like to use for name resolution: " NSIP
done

sed -i "/set nameserver1/c\set nameserver1 ${NSIP}" /root/.meraki_mig/update_ip_name-server.exp
sed -i "/set nameserver1/c\set nameserver1 ${NSIP}" /root/.meraki_mig/update_ip_name-server_single.exp


read -p "Please provide the secondary DNS IP address you would like to use for name resolution: " NSIP2
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the secondary DNS IP address you would like to use for name resolution: " NSIP2
done

sed -i "/set nameserver2/c\set nameserver2 ${NSIP2}" /root/.meraki_mig/update_ip_name-server.exp
sed -i "/set nameserver2/c\set nameserver2 ${NSIP2}" /root/.meraki_mig/update_ip_name-server_single.exp
clear
cat <<EOF
${GREEN}Updating ip name server with IP address ${NSIP} ${TEXTRESET}
${GREEN}Updating ip name server with IP address ${NSIP2} ${TEXTRESET}
EOF
sleep 1
clear

clear
cat <<EOF
${GREEN}Adding Management IP Addresses to the Server for Collection${TEXTRESET}

There are two ways to collect the IP addresses of the Catalyst Switches that are eligible for onboarding. 

You can:

Manually enter the IP addresses one by one, or

You can use the Network Discovery component.

Network Discovery will login via the subnet you specify, find all devices,
Then whittle them down to qualified 9300 series switches.

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
       nano /root/.meraki_mig/ip_list
  else
    echo "${GREEN}Network Discovery${TEXTRESET}"
       clear
        /root/.meraki_mig/network_discovery.sh
  fi



clear

cat <<EOF
The Wizard is complete!

The following information has ben set:
Username to login to the switches: ${GREEN}${USER}${TEXTRESET}
Password to login to the switches: ${GREEN}${PASS}${TEXTRESET}
Active IOS-XE Images to Use: ${GREEN}${IMAGE}${TEXTRESET}
IP HTTP source interface VLAN number: ${GREEN}${VLAN}${TEXTRESET}
DNS IP Address: ${GREEN}${NSIP}${TEXTRESET}
DNS IP Address: ${GREEN}${NSIP2}${TEXTRESET}

Start your first collection by selecting
${GREEN}Data Collection and Clean File System Flash${TEXTRESET} from the Main Menu

EOF
read -p "Press Enter When Ready"
