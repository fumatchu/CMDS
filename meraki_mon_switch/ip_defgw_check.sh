#!/bin/bash
#Pre-Check Script
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
IPDEFGW=$(cat /var/lib/tftpboot/mon_switch/${IP} | grep "ip default-gateway" | grep "ip default-gateway" | cut -c 20-)

if [ "$IPDEFGW" = " " ]; then
    echo "${RED}Did not find an ip default-gateway statement"
    echo "Using user programmed gateway of last resort${TEXTRESET}"
    echo $IP >> /root/.meraki_mon_switch/ip_list_single
    /root/.meraki_mon_switch/update_defgw_single.exp > /dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    sleep 2
  else
    echo ${GREEN}"Found a pre-existing statement for ip default-gateway${TEXTRESET}"
    echo " "
    echo "1" >> /root/.meraki_mon_switch/check.tmp
    echo ${YELLOW}"Attemping to Correct Issue${TEXTRESET}"
    echo " "
    \cp /root/.meraki_mon_switch/update_defgw_single.exp /root/.meraki_mon_switch/update_defgw_single.tmp.exp
    sed -i "/set def_gw/c\set def_gw ${IPDEFGW}" /root/.meraki_mon_switch/update_defgw_single.tmp.exp
    echo $IP >> /root/.meraki_mon_switch/ip_list_single
    /root/.meraki_mon_switch/update_defgw_single.tmp.exp > /dev/null 2>&1
    sed -i '/^/d' /root/.meraki_mon_switch/ip_list_single
    rm -f /root/.meraki_mon_switch/update_defgw_single.tmp.exp
    sleep 2
  fi

