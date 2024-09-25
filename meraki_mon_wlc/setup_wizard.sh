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

This Wizard will allow you to configure this server for IOS-XE deployment and Meraki Registration of your WLC
You must upload the IOS-XE image(s) that you need into the images directory of this tftp server.

As of now, the required IOS-XE image to use is:
${YELLOW}17.12.3${TEXTRESET}

And can be obtained at:
https://software.cisco.com/download/home/286322524

EOF

cat <<EOF
The file directory on this server is located at:

/var/lib/tftpboot/images

You should start uploading them now as you will specify the image in a couple of screens
${YELLOW}
When uploading the Catalyst image to the server, please do not rename the file.
Use the original file nomenclature from the Cisco Downloads site
${TEXTRESET}
You can accomplish this by uploading the files via SCP and copying them, or you can login to this server at

EOF

echo "https://$IP:9090/=$IP/navigator" | tr -d '[:blank:]'
echo " "
read -p "Press Enter When Ready"
clear
cat <<EOF

Once you have uploaded the IOS images, then you must specify the following (via this wizard):
        -The SSH User (to login to the WLC)
        -The SSH Password (to login to the WLC)
        -The Server IP of this machine (this is automatic, but you must allow it)
        -The Meraki API Key for Dashboard integration
        -The IOS image you would like to use (must be uploaded first)
        -The IP address of the WLC to Monitor (management IP via VLAN)
        -An NTP Server if needed for the WLC
        -An IP Address of a DNS Server for the WLC

Please keep in mind that it's required to have a privileged user (15) on the WLC
The server will want to be prompted in enable mode already (SSH should be enabled on the WLC)
This can be accomplished by providing the basic AAA information to the WLC:

For General AAA and SSH:

aaa new-model
aaa authentication login default local
aaa authentication enable default enable
aaa authorization exec default local if-authenticated
aaa authentication login CON0 local
aaa authorization exec CON0 if-authenticated
aaa authorization console
line con 0
login authentication CON0

You can implement these changes via the GUI on the WLC
 -Login to the WLC GUI
 -Select Administration --> Command Line Interface
 -Select the "Configure" Radio Button
 -Paste the above commands (aaa new-model to login Authentication CON0) in the "Enter the config command here"
 -Press the "Run Command" button

Please make sure you have minimally setup access for SSH first, before continuing
Scenarios may differ in setups. However, it is expected that when the server logs into the WLC, it be presented with already
being in enable mode.

Once you have met these requirements you may continue

EOF
read -p "Press Enter when ready"

clear

cat <<EOF
${GREEN}Change SSH User Credentials${TEXTRESET}
EOF

read -p "Please provide the user login for the WLC: " USER
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the user login for the WLC: " USER
done

cat <<EOF
${GREEN}Updating User Credentials${TEXTRESET}
EOF
sleep 1
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/clean.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/deploy.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/deploy_img.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_ip_name-server.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_config.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_aaa_config.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/register_wlc_2_cloud_check.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/register_wlc_2_cloud.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_avc_ta.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_ip_nbar.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_ntp_server.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_ntp_server_single.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_ip_name-server_single.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/network_test.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/get_ios_ver.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/network_test_wlan.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/update_config_single.exp
sed -i "/set switch_user/c\set switch_user ${USER}" /root/.meraki_mon_wlc/discovery.exp
clear

cat <<EOF
${GREEN}Update Password Credential${TEXTRESET}
EOF
sleep 1
read -p "Please provide the password for the WLC: " PASS
while [ -z "$PASS" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the password for the WLC: " PASS
done

cat <<EOF
${GREEN}Updating Password Credential${TEXTRESET}
EOF
sleep 1

sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/clean.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/deploy.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/deploy_img.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/update_ip_name-server.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/update_config.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/update_aaa_config.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/register_wlc_2_cloud_check.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/register_wlc_2_cloud.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/update_avc_ta.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/update_ip_nbar.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/update_ntp_server.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/update_ntp_server_single.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/update_ip_name-server_single.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/network_test.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/get_ios_ver.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/network_test_wlan.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/update_config_single.exp
sed -i "/set switch_pass/c\set switch_pass ${PASS}" /root/.meraki_mon_wlc/discovery.exp
clear

cat <<EOF
${GREEN}Update Server IP${TEXTRESET}
EOF

echo "The current IP Address of the server is: ${SERVER_IP}"
sleep 2
echo ${GREEN}"Updating Server IP for TFTP ${TEXTRESET}"
sleep 1
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/clean.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/deploy.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/deploy_img.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/update_ip_name-server.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/update_config.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/update_aaa_config.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/register_wlc_2_cloud_check.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/register_wlc_2_cloud.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/update_avc_ta.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/update_ip_nbar.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/update_ntp_server.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/update_ntp_server_single.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/update_ip_name-server_single.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/get_ios_ver.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/update_config_single.exp
sed -i "/set server_ip/c\set server_ip ${SERVER_IP}" /root/.meraki_mon_wlc/discovery.exp
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

sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mon_wlc/claim_devices.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mon_wlc/deploy_hostnames.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mon_wlc/update_physical_address_ap.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mon_wlc/update_physical_address_ap_selective.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mon_wlc/update_physical_address_wlc.py
sed -i '0,/API_KEY/{/API_KEY/d;}' /root/.meraki_mon_wlc/make_network_wlc.py

echo API_KEY = "\"${API_KEY}\"" >/root/.meraki_mon_wlc/api_key.key

sed -i '5 r /root/.meraki_mon_wlc/api_key.key' /root/.meraki_mon_wlc/claim_devices.py
sed -i '5 r /root/.meraki_mon_wlc/api_key.key' /root/.meraki_mon_wlc/deploy_hostnames.py
sed -i '5 r /root/.meraki_mon_wlc/api_key.key' /root/.meraki_mon_wlc/update_physical_address_ap.py
sed -i '5 r /root/.meraki_mon_wlc/api_key.key' /root/.meraki_mon_wlc/update_physical_address_ap_selective.py
sed -i '5 r /root/.meraki_mon_wlc/api_key.key' /root/.meraki_mon_wlc/update_physical_address_wlc.py
sed -i '5 r /root/.meraki_mon_wlc/api_key.key' /root/.meraki_mon_wlc/make_network_wlc.py

cat <<EOF
${GREEN}Update Complete${TEXTRESET}
EOF
sleep 1
clear

cat <<EOF
Before continuing, please make sure you have uploaded the (IOS-XE) images you want/need to use, in the directory:

/var/lib/tftpboot/images

You can either upload these via SCP, or you can use the navigator component, mentioned earlier:
${YELLOW}
When uploading the Catalyst image to the server, please do not rename the file.
Use the original file nomenclature from the Cisco Downloads site
${TEXTRESET}

EOF

echo "https://$IP:9090/=$IP/navigator" | tr -d '[:blank:]'
echo " "

read -p "Press Enter When Ready"
clear

cat <<EOF

${GREEN}Change Image to download to the WLC${TEXTRESET}

These are the current images on the Server

EOF

cd /var/lib/tftpboot/images
echo ${GREEN}"Current MD5 Checksums and Image Names"${TEXTRESET}
md5sum ./C9800* | sed -e 's/\.\///'
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

sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/clean.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/deploy.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/deploy_img.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_ip_name-server.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_config.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_aaa_config.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/sh_wlc_meraki_mon_summ.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/register_wlc_2_cloud_check.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/register_wlc_2_cloud.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_avc_ta.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_ip_nbar.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_ntp_server.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_ntp_server_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_ip_name-server_single.exp
sed -i "/set image/c\set image ${IMAGE}" /root/.meraki_mon_wlc/update_config_single.exp

${GREEN}Update Complete${TEXTRESET}
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

sed -i "/set ntpserver/c\set ntpserver ${NTP}" /root/.meraki_mon_wlc/update_ntp_server.exp
sed -i "/set ntpserver/c\set ntpserver ${NTP}" /root/.meraki_mon_wlc/update_ntp_server_single.exp

clear
echo "${GREEN}Provide a DNS Server IP address${TEXTRESET}"
read -p "Please provide the DNS IP address you would like to use for name resolution (If Needed): " NSIP
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the DNS IP address you would like to use for name resolution: " NSIP
done

read -p "Please provide the secondary DNS IP address you would like to use for name resolution (If Needed): " NSIP2
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the secondary DNS IP address you would like to use for name resolution: " NSIP2
done
clear
cat <<EOF
${GREEN}Updating ip name server with IP address ${NSIP} ${TEXTRESET}
${GREEN}Updating ip name server with IP address ${NSIP2} ${TEXTRESET}

EOF
sleep 1

sed -i "/set nameserver1/c\set nameserver1 ${NSIP}" /root/.meraki_mon_wlc/update_ip_name-server.exp
sed -i "/set nameserver1/c\set nameserver1 ${NSIP}" /root/.meraki_mon_wlc/update_ip_name-server_single.exp
sed -i "/set nameserver2/c\set nameserver2 ${NSIP2}" /root/.meraki_mon_wlc/update_ip_name-server.exp
sed -i "/set nameserver2/c\set nameserver2 ${NSIP2}" /root/.meraki_mon_wlc/update_ip_name-server_single.exp

clear
cat <<EOF
${GREEN}Adding Management IP Addresses to the Server for Collection${TEXTRESET}

There are two ways to collect the IP addresses of the Catalyst Switches that are eligible for onboarding. 

You can:

Manually enter the IP addresses one by one, or

You can use the Network Discovery component.

Network Discovery will login via the subnet you specify, find all devices,
Then whittle them down to qualified WLC Models.

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
       nano /root/.meraki_mon_wlc/ip_list
  else
    echo "${GREEN}Network Discovery${TEXTRESET}"
       clear
        /root/.meraki_mon_wlc/network_discovery.sh
  fi



clear
cat <<EOF
The Wizard is complete!

The following information has ben set:
Username to login to the switches: ${GREEN}${USER}${TEXTRESET}
Password to login to the switches: ${GREEN}${PASS}${TEXTRESET}
Active IOS-XE Images to Use: ${GREEN}${IMAGE}${TEXTRESET}
NTP Server: ${GREEN}${NTP}${TEXTRESET}
DNS IP Address: ${GREEN}${NSIP}${TEXTRESET}
DNS IP Address: ${GREEN}${NSIP2}${TEXTRESET}


Start your first collection by selecting
${GREEN}Data Collection and Clean File System Flash${TEXTRESET} from the Main Menu

EOF
read -p "Press Enter When Ready"
