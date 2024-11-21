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
    1) sed -i '/^IP1=/c\IP1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP1=/IP1=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
   2) sed -i '/^IP1=/c\IP1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP1=/IP1=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
   3) sed -i '/^IP1=/c\IP1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP1=/IP1=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
   4) sed -i '/^IP1=/c\IP1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP1=/IP1=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;

   5) sed -i '/^IP1=/c\IP1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP1=/IP1=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
   6) sed -i '/^IP1=/c\IP1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP1=/IP1=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
   7) sed -i '/^IP1=/c\IP1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP1=/IP1=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;

   8) sed -i '/^IP1=/c\IP1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP1=/IP1=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;

   9) sed -i '/^IP1=/c\IP1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP1=/IP1=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION1=/c\USEROPTION1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION1=/USEROPTION1=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;



    *) echo "Invalid choice, Try again.";;
  esac
else
  echo "This is a Single Switch"
  sed -i '/^IP1=/c\IP1=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP1=/IP1=${IP1}/g" /root/.meraki_port_mig/parse_switch.sh\
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
    1) sed -i '/^IP2=/c\IP2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP2=/IP2=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    2) sed -i '/^IP2=/c\IP2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP2=/IP2=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;
    3) sed -i '/^IP2=/c\IP2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP2=/IP2=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;

    4) sed -i '/^IP2=/c\IP2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP2=/IP2=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;

    5) sed -i '/^IP2=/c\IP2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP2=/IP2=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;

    6) sed -i '/^IP2=/c\IP2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP2=/IP2=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;

    7) sed -i '/^IP2=/c\IP2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP2=/IP2=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;

    8) sed -i '/^IP2=/c\IP2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP2=/IP2=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^USEROPTION2=/c\USEROPTION2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/USEROPTION2=/USEROPTION2=${user_choice}/g" /root/.meraki_port_mig/parse_switch.sh\
       && sed -i '/^AIP=/c\AIP=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/AIP=/AIP=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
       && /root/.meraki_port_mig/parse_switch.sh;;


    9) sed -i '/^IP2=/c\IP2=' /root/.meraki_port_mig/parse_switch.sh\
       && sed -i "s/IP2=/IP2=${IP2}/g" /root/.meraki_port_mig/parse_switch.sh\
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



IP1=$(cat /root/.meraki_port_mig/parse_switch.sh | grep IP1= | cut -c5-)
IP2=$(cat /root/.meraki_port_mig/parse_switch.sh | grep IP2= | cut -c5-)
SWITCH1=$(cat /root/.meraki_port_mig/parse_switch.sh | grep USEROPTION1 | cut -c13-)
SWITCH2=$(cat /root/.meraki_port_mig/parse_switch.sh | grep USEROPTION2 | cut -c13-)
#We need to get the switches we selected

mkdir -p /root/.meraki_port_mig/staging/active
\cp /root/.meraki_port_mig/staging/${IP1}switch${SWITCH1}.txt /root/.meraki_port_mig/staging/active
\cp /root/.meraki_port_mig/staging/${IP2}switch${SWITCH2}.txt /root/.meraki_port_mig/staging/active
echo "Moved files to Active staging"
sleep 1
echo "Merging ${IP1}switch${SWITCH1}.txt and ${IP2}switch${SWITCH2}.txt"


#Modify the Secondary switch selection and change port to 25-48

sed -i -e 's/\bGigabitEthernet1\/0\/1\b/GigabitEthernet1\/0\/25/g' \
-e 's/\bGigabitEthernet1\/0\/2\b/GigabitEthernet1\/0\/26/g' \
-e 's/\bGigabitEthernet1\/0\/3\b/GigabitEthernet1\/0\/27/g' \
-e 's/\bGigabitEthernet1\/0\/4\b/GigabitEthernet1\/0\/28/g' \
-e 's/\bGigabitEthernet1\/0\/5\b/GigabitEthernet1\/0\/29/g' \
-e 's/\bGigabitEthernet1\/0\/6\b/GigabitEthernet1\/0\/30/g' \
-e 's/\bGigabitEthernet1\/0\/7\b/GigabitEthernet1\/0\/31/g' \
-e 's/\bGigabitEthernet1\/0\/8\b/GigabitEthernet1\/0\/32/g' \
-e 's/\bGigabitEthernet1\/0\/9\b/GigabitEthernet1\/0\/33/g' \
-e 's/\bGigabitEthernet1\/0\/10\b/GigabitEthernet1\/0\/34/g' \
-e 's/\bGigabitEthernet1\/0\/11\b/GigabitEthernet1\/0\/35/g' \
-e 's/\bGigabitEthernet1\/0\/12\b/GigabitEthernet1\/0\/36/g' \
-e 's/\bGigabitEthernet1\/0\/13\b/GigabitEthernet1\/0\/37/g' \
-e 's/\bGigabitEthernet1\/0\/14\b/GigabitEthernet1\/0\/38/g' \
-e 's/\bGigabitEthernet1\/0\/15\b/GigabitEthernet1\/0\/39/g' \
-e 's/\bGigabitEthernet1\/0\/16\b/GigabitEthernet1\/0\/40/g' \
-e 's/\bGigabitEthernet1\/0\/17\b/GigabitEthernet1\/0\/41/g' \
-e 's/\bGigabitEthernet1\/0\/18\b/GigabitEthernet1\/0\/42/g' \
-e 's/\bGigabitEthernet1\/0\/19\b/GigabitEthernet1\/0\/43/g' \
-e 's/\bGigabitEthernet1\/0\/20\b/GigabitEthernet1\/0\/44/g' \
-e 's/\bGigabitEthernet1\/0\/21\b/GigabitEthernet1\/0\/45/g' \
-e 's/\bGigabitEthernet1\/0\/22\b/GigabitEthernet1\/0\/46/g' \
-e 's/\bGigabitEthernet1\/0\/23\b/GigabitEthernet1\/0\/47/g' \
-e 's/\bGigabitEthernet1\/0\/24\b/GigabitEthernet1\/0\/48/g' /root/.meraki_port_mig/staging/active/${IP2}switch${SWITCH2}.txt


sed -i "/Ethernet${SWITCH2}\/1\/1/,\$d" /root/.meraki_port_mig/staging/active/${IP2}switch${SWITCH2}.txt
echo "Ports modified and uplink ports stripped"

#Merge switch 2 into switch 1
awk -v insert_file="/root/.meraki_port_mig/staging/active/${IP2}switch${SWITCH2}.txt" '
BEGIN {
  # Read the contents of file2 into an array
  while ((getline line < insert_file) > 0) {
    insert_lines[++i] = line
  }
  close(insert_file)
}
{
  if ($0 ~ /1\/1\/1/ && !inserted) {
    # Insert the contents of file2 before printing the first line with 1/1/1
    for (j = 1; j <= i; j++) {
      print insert_lines[j]
    }
    inserted = 1  # Ensure insertion happens only once
  }
  print $0
}' /root/.meraki_port_mig/staging/active/${IP1}switch${SWITCH1}.txt > /root/.meraki_port_mig/staging/active/${IP1}
