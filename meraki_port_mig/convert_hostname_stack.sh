#!/bin/bash
#Collect hostnames and match to Serial
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

IP=
#Get the Serials
cat /root/.meraki_port_mig/tmp/${IP} >> /root/.meraki_port_mig/serial.tmp

HOSTNAME=$(cat /var/lib/tftpboot/port_switch/${IP} | grep hostname | sed 's/hostname //g')
SWITCH1=$(sed -n '1p' /root/.meraki_port_mig/tmp/${IP})
SWITCH2=$(sed -n '2p' /root/.meraki_port_mig/tmp/${IP})
SWITCH3=$(sed -n '3p' /root/.meraki_port_mig/tmp/${IP})
SWITCH4=$(sed -n '4p' /root/.meraki_port_mig/tmp/${IP})
SWITCH5=$(sed -n '5p' /root/.meraki_port_mig/tmp/${IP})
SWITCH6=$(sed -n '6p' /root/.meraki_port_mig/tmp/${IP})
SWITCH7=$(sed -n '7p' /root/.meraki_port_mig/tmp/${IP})
SWITCH8=$(sed -n '8p' /root/.meraki_port_mig/tmp/${IP})
SWITCH9=$(sed -n '9p' /root/.meraki_port_mig/tmp/${IP})


if [ "$SWITCH1" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[1]" >> /root/.meraki_port_mig/hostnames.tmp
fi

if [ "$SWITCH2" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[2]" >> /root/.meraki_port_mig/hostnames.tmp
fi

if [ "$SWITCH3" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[3]" >> /root/.meraki_port_mig/hostnames.tmp
fi

if [ "$SWITCH4" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[4]" >> /root/.meraki_port_mig/hostnames.tmp
fi

if [ "$SWITCH5" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[5]" >> /root/.meraki_port_mig/hostnames.tmp
fi

if [ "$SWITCH6" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[6]" >> /root/.meraki_port_mig/hostnames.tmp
fi

if [ "$SWITCH7" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[7]" >> /root/.meraki_port_mig/hostnames.tmp
fi

if [ "$SWITCH8" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}[8]" >> /root/.meraki_port_mig/hostnames.tmp
fi

if [ "$SWITCH9" = "" ]; then
     echo " " > /dev/null
   else
   echo "${HOSTNAME}-[9]" >> /root/.meraki_port_mig/hostnames.tmp
fi

paste -d ',' "/root/.meraki_port_mig/serial.tmp" "/root/.meraki_port_mig/hostnames.tmp" > /root/.meraki_port_mig/hostnames.txt
echo ${GREEN}"Deploying Update"${TEXTRESET}
unbuffer python3.10 /root/.meraki_port_mig/deploy_hostnames.py
echo " "

rm -f /root/.meraki_port_mig/hostnames.tmp
rm -f /root/.meraki_port_mig/serial.tmp
rm -f /root/.meraki_port_mig/hostnames.txt