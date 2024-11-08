#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

INPUT="/root/.meraki_mig/discovered_ip"

# Read file line-by-line to get an IP address
while read -r IP; do


#What model is the Switch?
#  MODEL9200=$(cat /var/lib/tftpboot/mig_switch/nwd-${IP}-shver | grep "Model Number" | grep C9200 | tr -cd 'C9200' | sed 's/.$//')
#  MODEL9200L=$(cat /var/lib/tftpboot/mig_switch/nwd-${IP}-shver | grep "Model Number" | grep C9200L | tr -cd 'C9200L' | sed 's/.$//')
#  MODELDESC9200=$(cat /var/lib/tftpboot/mig_switch/nwd-${IP}-shver | grep "Model Number" | tr -d "[:blank:]")
#if [ "$MODEL9200" == "C9200" ] || [ "$MODEL9200L" == "C9200L" ]; then
#    echo "${GREEN}$IP is a 9200 series switch"${TEXTRESET} >> /root/.meraki_mig/network_collection.tmp
#    echo ${IP} >> /root/.meraki_mig/ip_list
#    echo "${MODELDESC9200}" >> /root/.meraki_mig/network_collection.tmp
#    echo " "
#  else
#    echo " " >> /root/.meraki_mig/network_collection.tmp
#  fi

#What model is the Switch?
  MODEL9300=$(cat /var/lib/tftpboot/mig_switch/nwd-${IP}-shver | grep "Model Number" | grep C9300 -Eo | grep C9300 -m 1)
  MODEL9300L=$(cat /var/lib/tftpboot/mig_switch/nwd-${IP}-shver | grep "Model Number" | grep C9300L -Eo | grep C9300L -m 1)
  MODELDESC9300=$(cat /var/lib/tftpboot/mig_switch/nwd-${IP}-shver | grep "Model Number" | tr -d "[:blank:]")
if [ "$MODEL9300" == "C9300" ] || [ "$MODEL9300L" == "C9300L" ]; then
    echo "${GREEN}$IP is a 9300 series switch"${TEXTRESET}  >> /root/.meraki_mig/network_collection.tmp
    echo ${IP} >> /root/.meraki_mig/ip_list
    echo "${MODELDESC9300}" >> /root/.meraki_mig/network_collection.tmp
    echo " " >> /root/.meraki_mig/network_collection.tmp
  else
    echo " "
  fi

#What model is the Switch?
#  MODEL9500=$(cat /var/lib/tftpboot/mig_switch/nwd-${IP}-shver | grep "cisco C9500" | cut -c7- | sed 's/-.*//')
#  MODELDESC9500=$(cat /var/lib/tftpboot/mig_switch/nwd-${IP}-shver | grep "Model Number" | tr -d "[:blank:]")
#if [ "$MODEL9500" == "C9500" ]; then
#    echo "${GREEN}$IP is a 9500 series switch"${TEXTRESET}  >> /root/.meraki_mig/network_collection.tmp
#    echo ${IP} >> /root/.meraki_mig/ip_list
#    echo "${MODELDESC9500}" >> /root/.meraki_mig/network_collection.tmp
#    echo " " >> /root/.meraki_mig/network_collection.tmp
#  else
#    echo " "
#  fi

done <"$INPUT"
