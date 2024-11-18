#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)


read -p "Please provide the IP address of the first switch: " IP1

CONFIGSTACK=$(cat /var/lib/tftpboot/port_switch/${IP1} | grep -m 1 -o '2/0/1')
MODEL=$(cat /var/lib/tftpboot/port_switch/${IP1}-shver | grep "Model Number" | tr -d ' ' | awk '{print NR " " $0}')
if [[ "$CONFIGSTACK" == "2/0/1" ]]; then
    echo "${GREEN}This looks to be a stack of switches${TEXTRESET}"
    #Produce the layout of the switches
    echo "${MODEL}"
    echo " "
  echo "Please select the switch in the stack to merge:"

# Read user input
  read -p "Enter your choice: " user_choice

  # Handle user input
  case $user_choice in
    1) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    2) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    3) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    4) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    5) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    6) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    7) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    8) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    9) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;



    *) echo "Invalid choice, Try again.";;
  esac
else
  echo "This is a Single Switch"
  sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=1/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh
fi


read -p "Please provide the IP address of the second switch: " IP2

CONFIGSTACK=$(cat /var/lib/tftpboot/port_switch/${IP2} | grep -m 1 -o '2/0/1')
MODEL=$(cat /var/lib/tftpboot/port_switch/${IP2}-shver | grep "Model Number" | tr -d ' ' | awk '{print NR " " $0}')
if [[ "$CONFIGSTACK" == "2/0/1" ]]; then
    echo "${GREEN}This looks to be a stack of switches${TEXTRESET}"
    #Produce the layout of the switches
    echo "${MODEL}"
    echo " "
 echo "Please select the switch in the stack to merge:"

# Read user input
  read -p "Enter your choice: " user_choice

  # Handle user input
  case $user_choice in
    1) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    2) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    3) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    4) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    5) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    6) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    7) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    8) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    9) sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;

    *) echo "Invalid choice, please Try again.";;
  esac
else
  echo "This is a Single Switch"
  sed -i '/^IP=/c\IP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP=/IP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=1/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh
fi