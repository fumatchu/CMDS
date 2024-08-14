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
This Wizard will allow you to configure this server for IOS-XE deployment and Meraki PreCheck for Catalyst Monitoring
You must upload the IOS-XE image(s) that you need into the images directory of this tftp server.
If you Need the IOS Images, please use the following link:

https://software.cisco.com/download/home/278875285

${YELLOW}*Please do not rename the file(s). Use the original file from the Cisco Downloads Site*${TEXTRESET}
A Valid CCO ID is required

The Current suggested version(s) are:
${YELLOW}
17.12.3 (ED)
17.9.5 (MD)
${TEXTRESET}

It is highly suggested to upgrade to 17.12.3
EOF

read -p "Press Enter When Ready"
clear
cat << EOF
The file directory is located at:

/var/lib/tftpboot/images

You can accomplish this by uploading the files via SCP and copying them, or you can login to this server at
EOF

echo "https://$IP:9090/=$IP/navigator" | tr -d '[:blank:]'

cat <<EOF


Once you have uploaded the IOS images, then you must specify the following (via this wizard):
        -The SSH User (to login to the switch)
        -The SSH Password (to login to the switch)
        -The Meraki API Key for Dashboard integration
        -The IOS image you would like to use (must be uploaded first)
        -The IP addresses of the switches to migrate (management IP via VLAN)
        -An NTP Server if needed for the Switches
        -An IP Address of a DNS Server for the switches 
        -A Gateway of last resort IP Address. This will be used to enable routing. 
         ${YELLOW}*Keep in mind this address will change with every subnet/batch you use$*${TEXTRESET}

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

sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/clean.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/deploy.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/deploy_img.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/deploy_single.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/deploy_img_single.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_ntp_server.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_ip_name-server.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_aaa_config.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_iprouting_config.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_config.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_defgw.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_switch/update_ip_domain_lookup.exp
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

sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_switch/clean.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_switch/deploy.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_switch/deploy_img.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_switch/deploy_single.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_switch/deploy_img_single.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_switch/update_ntp_server.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_switch/update_ip_name-server.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_switch/update_aaa_config.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_switch/update_iprouting_config.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_switch/update_config.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_switch/update_defgw.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_switch/update_ip_domain_lookup.exp
clear
cat <<EOF
${GREEN}Update Server IP${TEXTRESET}
EOF

echo "The current IP Address of the server is: ${SERVER_IP}"
sleep 2
echo ${GREEN}"Updating Server IP for TFTP ${TEXTRESET}"
sleep 1
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/clean.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/deploy.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/deploy_img.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/deploy_single.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/deploy_img_single.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/update_ntp_server.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/update_ip_name-server.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/update_aaa_config.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/update_iprouting_config.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/update_config.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/update_defgw.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_switch/update_ip_domain_lookup.exp
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

#sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mon_switch/update_physical_address_switch.py

echo API_KEY = "\"${API_KEY}\"" >/root/.meraki_mon_switch/api_key.key

#sed -i '5 r /root/.meraki_mon_switch/api_key.key' /root/.meraki_mon_switch/update_physical_address_switch.py

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

cat <<EOF

${GREEN}Change Image to download to the switch${TEXTRESET}
These are the current images on the Server

${GREEN}For your initial image selection, please use the "full" IOS version image file name.${TEXTRESET}
${YELLOW}*Please do not rename the file. Use the original file from the Cisco Downloads Site*${TEXTRESET}
An example: cat9k_iosxe.17.12.03.SPA.bin

${RED}Do Not use the Lite Image here.${TEXTRESET}
An example: cat9k_lite_iosxe.17.12.03.SPA.bin

If you have 9200's and 9300/9500's in your envrionment, the server must decipher between
the FULL IOS image that is used on 9300/9500 and the "Lite" image that is used for 9200's.

EOF

ls -al /var/lib/tftpboot/images

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

sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/clean.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/deploy_img.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/deploy.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/deploy_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/deploy_img_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_ntp_server.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_ip_name-server.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_aaa_config.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_iprouting_config.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_config.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_defgw.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_switch/update_ip_domain_lookup.exp
clear
cat <<EOF
${GREEN}Update Complete${TEXTRESET}


Please provde a list of IP addresses, one per line, in the following window.
The list must be dotted decimal notation, one per line, no spaces or carriage returns
Here is an example:

192.168.1.1
192.168.1.2
192.168.1.3
EOF
read -p "Press Enter When Ready"

nano /root/.meraki_mon_switch/ip_list
clear
echo "${GREEN}Provide an NTP Server IP address${TEXTRESET}"
read -p "Please provide the NTP IP address you would like to use for time syncronization (If Needed): " NTP
while [ -z "$NTP" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the NTP IP address you would like to use for time syncronization: " NTP
done
clear
cat <<EOF
${GREEN}Updating ntp name server with IP address ${NTP} ${TEXTRESET}

EOF
sleep 1

sed -i "/set ntpserver/c\set ntpserver ${NTP}" /root/.meraki_mon_switch/update_ntp_server.exp


clear
echo "${GREEN}Provide a DNS Server IP address${TEXTRESET}"
read -p "Please provide the DNS IP address you would like to use for name resolution (If Needed): " NSIP
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the DNS IP address you would like to use for name resolution: " NSIP
done
clear
cat <<EOF
${GREEN}Updating ip name server with IP address ${NSIP} ${TEXTRESET}

EOF
sleep 1

sed -i "/set nameserver/c\set nameserver ${NSIP}" /root/.meraki_mon_switch/update_ip_name-server.exp

clear
cat << EOF 
${GREEN}Provide Default Gateway IP address${TEXTRESET}
For each subnet of switches you modify, you must provide the corresponding Default-Gateway for the network segment
This must be changed per subnet and can be done so with the menu option 
Main Menu --> Utilities --> Deploy Default Route
One IP Routing is enabled, the switch must have a Gateway of last resort 
If IP routing is already enabled, the server will detect this, and bypass updating the Gateway of last resort

EOF
read -p "Please provide the IP address you would like to use for the Gateway of Last resort (routing Default Gateway): " GWLR
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p  "Please provide the IP address you would like to use for the Gateway of Last resort:" GWLR
done
clear
cat <<EOF
${GREEN}Updating gateway of last resort with IP address ${GWLR} ${TEXTRESET}

EOF
sleep 1

sed -i "/set def_gw/c\set def_gw ${GWLR}" /root/.meraki_mon_switch/update_defgw.exp

clear




cat <<EOF
The Wizard is complete!

The following information has ben set:
Username to login to the switches: ${GREEN}${USER}${TEXTRESET}
Password to login to the switches: ${GREEN}${PASS}${TEXTRESET}
Active IOS-XE Images to Use: ${GREEN}${IMAGE}${TEXTRESET}
NTP Server: ${GREEN}${NTP}${TEXTRESET}
DNS IP Address: ${GREEN}${NSIP}${TEXTRESET}
Routing Default Gateway: ${GREEN}${GWLR}${TEXTRESET}

Start your first collection by selecting
${GREEN}Data Collection and Clean File System Flash${TEXTRESET} from the Main Menu

EOF
read -p "Press Enter When Ready"
