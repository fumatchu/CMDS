#!/bin/bash
#Collect hostnames and match to Serial
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

IP=
#Get the Serials
cat /var/lib/tftpboot/mig_switch/${IP}-shmr | grep C9300 |grep -E -o "Q.{0,13}" >> /root/.meraki_mig/serial.tmp

HOSTNAME=$(cat /var/lib/tftpboot/mig_switch/${IP} | grep hostname | sed 's/hostname //g')
SWITCH1=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmr| sed -n '/^1/p'  2>/dev/null)
SWITCH2=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmr| sed -n '/^2/p'  2>/dev/null)
SWITCH3=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmr| sed -n '/^3/p'  2>/dev/null)
SWITCH4=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmr| sed -n '/^4/p'  2>/dev/null)
SWITCH5=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmr| sed -n '/^5/p'  2>/dev/null)
SWITCH6=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmr| sed -n '/^6/p'  2>/dev/null)
SWITCH7=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmr| sed -n '/^7/p'  2>/dev/null)
SWITCH8=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmr| sed -n '/^8/p'  2>/dev/null)
SWITCH9=$(cat /var/lib/tftpboot/mig_switch/${IP}-shmr| sed -n '/^9/p'  2>/dev/null)

if [ "$SWITCH1" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[1]" >> /root/.meraki_mig/hostnames.tmp
fi

if [ "$SWITCH2" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[2]" >> /root/.meraki_mig/hostnames.tmp
fi

if [ "$SWITCH3" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[3]" >> /root/.meraki_mig/hostnames.tmp
fi

if [ "$SWITCH4" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[4]" >> /root/.meraki_mig/hostnames.tmp
fi

if [ "$SWITCH5" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[5]" >> /root/.meraki_mig/hostnames.tmp
fi

if [ "$SWITCH6" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[6]" >> /root/.meraki_mig/hostnames.tmp
fi

if [ "$SWITCH7" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[7]" >> /root/.meraki_mig/hostnames.tmp
fi

if [ "$SWITCH8" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[8]" >> /root/.meraki_mig/hostnames.tmp
fi

if [ "$SWITCH9" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}-[9]" >> /root/.meraki_mig/hostnames.tmp
fi

paste -d ',' "/root/.meraki_mig/serial.tmp" "/root/.meraki_mig/hostnames.tmp" > /root/.meraki_mig/hostnames.txt
echo ${GREEN}"Deploying Update"${TEXTRESET}
unbuffer python3.10 /root/.meraki_mig/deploy_hostnames.py
clear

rm -f /root/.meraki_mig/hostnames.tmp
rm -f /root/.meraki_mig/serial.tmp
rm -f /root/.meraki_mig/hostnames.txt
