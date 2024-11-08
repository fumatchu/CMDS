#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
IOS_IMAGE_FULL=$(more /root/.meraki_mon_switch/clean.exp | grep "set image" | cut -c11-)
IOS_IMAGE_LITE=$(more /root/.meraki_mon_switch/clean.exp | grep "set image" | cut -c11- | sed 's/cat9k_/cat9k_lite_/g')
INPUT="/root/.meraki_mon_switch/ip_list"
clear

cat <<EOF
${GREEN}Deploying IOS-XE Image${TEXTRESET}
EOF

echo "Checking the Model of the Switch"

rm -r -f /root/.meraki_mon_switch/ip_list_single
sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
touch /root/.meraki_mon_switch/ip_list_single

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
#  echo "$IP"

  #What model is the Switch?
  MODEL9200=$(cat /var/lib/tftpboot/mon_switch/${IP}-shver | grep "Model Number" | grep C9200 -Eo | grep C9200 -m1)
 
if [ "$MODEL9200" == "C9200" ]; then
    clear
    echo "${GREEN}This switch with IP address $IP is a 9200 series switch, installing the IOS-XE Lite Image"${TEXTRESET}
    sed -i "/set image/c\set image ${IOS_IMAGE_LITE}" /root/.meraki_mon_switch/deploy_img_single.exp
    sed -i "/set image/c\set image ${IOS_IMAGE_LITE}" /root/.meraki_mon_switch/deploy_img.exp
    sed -i "/set image/c\set image ${IOS_IMAGE_LITE}" /root/.meraki_mon_switch/deploy.exp
    sed -i "/set image/c\set image ${IOS_IMAGE_LITE}" /root/.meraki_mon_switch/deploy_single.exp
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    echo $IP >> /root/.meraki_mon_switch/ip_list_single
    /root/.meraki_mon_switch/deploy_single.exp
    
    sleep 1
  else
    clear
    echo "${GREEN}This switch with IP address $IP is a 9300/9500 series switch, installing the Full IOS-XE image "${TEXTRESET}
    sed -i "/set image/c\set image ${IOS_IMAGE_FULL}" /root/.meraki_mon_switch/deploy_img_single.exp
    sed -i "/set image/c\set image ${IOS_IMAGE_FULL}" /root/.meraki_mon_switch/deploy_img.exp
    sed -i "/set image/c\set image ${IOS_IMAGE_FULL}" /root/.meraki_mon_switch/deploy.exp
    sed -i "/set image/c\set image ${IOS_IMAGE_FULL}" /root/.meraki_mon_switch/deploy_single.exp
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    echo $IP >> /root/.meraki_mon_switch/ip_list_single
    /root/.meraki_mon_switch/deploy_single.exp
    sleep 1
  fi

done <"$INPUT"
sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
