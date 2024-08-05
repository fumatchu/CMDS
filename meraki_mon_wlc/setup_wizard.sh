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

The file directory on this server is located at:

/var/lib/tftpboot/images

You can accomplish this by uploading the files via SCP and copying them, or you can login to this server at

EOF

echo "https://$IP:9090/=$IP/navigator" | tr -d '[:blank:]'

cat <<EOF

and use the Navigator component on the left hand side

Once you have uploaded the IOS images, then you must specify the following (via this wizard):
        -The SSH User (to login to the WLC)
        -The SSH Password (to login to the WLC)
        -The Server IP of this machine (this is automatic, but you must allow it)
        -The Meraki API Key for Dashboard integration
        -The IOS image you would like to use (must be uploaded first)
        -The IP address of the WLC to Monitor (management IP via VLAN)

Please keep in mind that it's required to have a privileged user (15) on the WLC
The server will want to be prompted in enable mode already (SSH should be enabled on the WLC)
An Example configuration on the WLC:

i.e. 
aaa new-model
aaa authentication login default local
aaa authentication enable default enable
aaa authorization exec default local if-authenticated

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

echo API_KEY = "\"${API_KEY}\"" >/root/.meraki_mon_wlc/api_key.key

sed -i '5 r /root/.meraki_mon_wlc/api_key.key' /root/.meraki_mon_wlc/claim_devices.py
sed -i '5 r /root/.meraki_mon_wlc/api_key.key' /root/.meraki_mon_wlc/deploy_hostnames.py
sed -i '5 r /root/.meraki_mon_wlc/api_key.key' /root/.meraki_mon_wlc/update_physical_address_ap.py
sed -i '5 r /root/.meraki_mon_wlc/api_key.key' /root/.meraki_mon_wlc/update_physical_address_ap_selective.py
sed -i '5 r /root/.meraki_mon_wlc/api_key.key' /root/.meraki_mon_wlc/update_physical_address_wlc.py

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

${GREEN}Change Image to download to the WLC${TEXTRESET}

These are the current images on the Server

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


clear
cat <<EOF
${GREEN}Update Complete${TEXTRESET}


Please provde the IP address of your WLC in the following window.
The list must be dotted decimal notation, no spaces or carriage returns
Example:
192.168.210.10

EOF
read -p "Press Enter When Ready"

nano /root/.meraki_mon_wlc/ip_list
clear
cat <<EOF
The Wizard is complete!

Start your first collection by selecting
${GREEN}Data Collection and Clean File System Flash${TEXTRESET} from the Main Menu


This will return to the Main Menu shortly
EOF
sleep 5
