#!/bin/bash
#Determine WLC model
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

INPUT="/root/.meraki_mon_wlc/discovered_ip"

# Read file line-by-line to get an IP address
while read -r IP; do


#What model is the WLC?
LCK9=$(cat /var/lib/tftpboot/wlc/nwd-${IP}-shver | grep -Eo C9800-L-C-K9 | sed 's/-//g')
HOSTNAME=$(cat /var/lib/tftpboot/wlc/nwd-${IP}-hostname | grep hostname | cut -c10-)
MERAKI_USER=$(cat /var/lib/tftpboot/wlc/nwd-${IP}-shrunn | grep username | grep meraki)
LFK9=$(cat /var/lib/tftpboot/wlc/nwd-${IP}-shver | grep -Eo C9800-L-F-K9 | sed 's/-//g')
C980040K9=$(cat /var/lib/tftpboot/wlc/nwd-${IP}-shver | grep -Eo C9800-40-K9 | sed 's/-//g')
C980080K9=$(cat /var/lib/tftpboot/wlc/nwd-${IP}-shver | grep -Eo C9800-80-K9 | sed 's/-//g')

if [[ "$LCK9" == "C9800LCK9" ]] && [[ "$MERAKI_USER" = "" ]]; then
    echo " "
    echo "${GREEN}$IP is an eligible 9800-LC series WLC"${TEXTRESET}  >> /root/.meraki_mon_wlc/network_collection.tmp
    echo ${IP} >> /root/.meraki_mon_wlc/ip_list
    echo HOSTNAME:${HOSTNAME} >> /root/.meraki_mon_wlc/network_collection.tmp
    echo "MODEL:C9800-L-C-K9" >> /root/.meraki_mon_wlc/network_collection.tmp
    echo " " >> /root/.meraki_mon_wlc/network_collection.tmp
   else
    echo " "
fi

if [[ "$LFK9" == "C9800LFK9" ]] && [[ "$MERAKI_USER" = "" ]]; then
    echo "${GREEN}$IP is an eligible  9800-LF series WLC"${TEXTRESET}  >> /root/.meraki_mon_wlc/network_collection.tmp
    echo ${IP} >> /root/.meraki_mon_wlc/ip_list
    echo HOSTNAME:${HOSTNAME} >> /root/.meraki_mon_wlc/network_collection.tmp
    echo "MODEL:C9800-L-C-K9" >> /root/.meraki_mon_wlc/network_collection.tmp
    echo " " >> /root/.meraki_mon_wlc/network_collection.tmp
  else
    echo " "
  fi

if [ "$C980040K9" == "C980040K9" ] && [ "$MERAKI_USER" = "" ]; then
echo "${GREEN}$IP is a 9800-40 series WLC"${TEXTRESET}  >> /root/.meraki_mon_wlc/network_collection.tmp
    echo ${IP} >> /root/.meraki_mon_wlc/ip_list
    echo HOSTNAME:${HOSTNAME} >> /root/.meraki_mon_wlc/network_collection.tmp
    echo "MODEL:C9800-L-C-K9" >> /root/.meraki_mon_wlc/network_collection.tmp
    echo " " >> /root/.meraki_mon_wlc/network_collection.tmp
  else
    echo " "
fi

C980080K9=$(cat /var/lib/tftpboot/wlc/nwd-${IP}-shver | grep -Eo C9800-80-K9 | sed 's/-//g')
if [ "$C980080K9" == "C980080K9" ] && [ "$MERAKI_USER" = "" ]; then
   echo "${GREEN}$IP is a 9800-80 series WLC"${TEXTRESET}  >> /root/.meraki_mon_wlc/network_collection.tmp
    echo ${IP} >> /root/.meraki_mon_wlc/ip_list
    echo HOSTNAME:${HOSTNAME} >> /root/.meraki_mon_wlc/network_collection.tmp
    echo "MODEL:C9800-L-C-K9" >> /root/.meraki_mon_wlc/network_collection.tmp
    echo " " >> /root/.meraki_mon_wlc/network_collection.tmp
  else
    echo " "
  fi
done <"$INPUT"
