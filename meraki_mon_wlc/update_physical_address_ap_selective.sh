#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear

cat <<EOF
${GREEN}Update Physical Address on Selective AP${TEXTRESET}

This will allow you to update Physical Address of the AP(s) and Move the Map Marker  

Please make sure that the AP's you want to modify are actively registered to the WLC. 
If you have any question, you can select the option:
${YELLOW}Main Menu --> Check AP Registration to Cloud ${TEXTRESET}
for the Current List of AP's
Or, Check their status on the Merkai Dashboard for your newly onboarded 9800

Please provide the Physical address in the correct format:
(i.e. 123 AnyStreet St. City State ZIP)

EOF

read -p "Please provide the Address you would like to use: " ADDR
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the Address you would like to use: " ADDR
done
clear
sleep 1

sed -i '0,/new_address = /{/new_address = /d;}' /root/.meraki_mon_wlc/update_physical_address_ap_selective.py
echo new_address = "\"${ADDR}\"" >/root/.meraki_mon_wlc/address.txt
sed -i '32 r /root/.meraki_mon_wlc/address.txt' /root/.meraki_mon_wlc/update_physical_address_ap_selective.py

touch /root/.meraki_mon_wlc/phys_ap_serials.txt

clear

cat <<EOF
${GREEN}Enter your Serial Number List${TEXTRESET}
You will now be presented with a screen to enter your serials numbers you want to modify. 
It should be a list of Serials, with no carriage returns, or spaces.. 
i.e.

QQQQ-QQQQ-ZZZZ
QQQQ-QQQQ-ZZZZ
QQQQ-QQQQ-ZZZZ
QQQQ-QQQQ-ZZZZ_

EOF

read -p "Press Enter"

nano /root/.meraki_mon_wlc/phys_ap_serials.txt

clear
echo "${GREEN}Deploying Script${TEXTRESET}"
sleep 1

python3 /root/.meraki_mon_wlc/update_physical_address_ap_selective.py

echo "${GREEN}Script Complete${TEXTRESET}"
sleep 1
rm -r /root/.meraki_mon_wlc/address.txt
rm -r /root/.meraki_mon_wlc/phys_ap_serials.txt
sleep 1
