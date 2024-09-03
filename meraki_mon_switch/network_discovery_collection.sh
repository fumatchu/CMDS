#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

INPUT="/root/.meraki_mon_switch/discovered_ip"

# Read file line-by-line to get an IP address
while read -r IP; do


#What model is the Switch?
  MODEL9200=$(cat /var/lib/tftpboot/mon_switch/nwd-${IP}-shver | grep "Model Number" | grep C9200 | tr -cd 'C9200' | sed 's/.$//')

if [ "$MODEL9200" == "C9200" ]; then
    echo "${GREEN}$IP is a 9200 series switch"${TEXTRESET} >> /root/.meraki_mon_switch/network_collection.tmp
    echo ${IP} >> /root/.meraki_mon_switch/ip_list
    sleep 1
  else
    echo " "
    sleep 1
  fi

#What model is the Switch?
  MODEL9300=$(cat /var/lib/tftpboot/mon_switch/nwd-${IP}-shver | grep "Model Number" | grep C9300 | tr -cd 'C9300')

if [ "$MODEL9300" == "C9300" ]; then
    echo "${GREEN}$IP is a 9300 series switch"${TEXTRESET}  >> /root/.meraki_mon_switch/network_collection.tmp
    echo ${IP} >> /root/.meraki_mon_switch/ip_list
    sleep 1
  else
    echo " "
    sleep 1
  fi

done <"$INPUT"
