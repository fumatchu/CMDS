#!/bin/bash
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
INPUT="/root/.meraki_mon_wlc/ip_list"
clear
cat <<EOF
${GREEN}Update Physical Address on AP${TEXTRESET}
This will allow you to update Physical Address of the AP and Move the Map Marker

Please make sure that the AP's you want to modify are actively registered to the WLC.
If you have any question, you can select the option:
${YELLOW}Main Menu --> Check AP Registration to Cloud ${TEXTRESET}
for the Current List of AP's
Check their status on the Merkai Dashboard for your newly onboarded 9800/APs

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
cat <<EOF
${GREEN}Updating the AP(s) Physical address with: ${ADDR} ${TEXTRESET}

EOF
sleep 1

sed -i '0,/new_address = /{/new_address = /d;}' /root/.meraki_mon_wlc/update_physical_address_ap.py
echo new_address = "\"${ADDR}\"" >/root/.meraki_mon_wlc/address.txt
sed -i '32 r /root/.meraki_mon_wlc/address.txt' /root/.meraki_mon_wlc/update_physical_address_ap.py

/root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.exp
# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo ${GREEN}"$IP"${TEXTRESET}
  echo " "

cat /var/lib/tftpboot/wlc/${IP}-ap_mon_summ | cut -c108- | cut -c-14 | grep -E -o "Q.{0,13}" >>/root/.meraki_mon_wlc/ap_serials.txt

done <"$INPUT"

clear
echo "${GREEN}Deploying Script${TEXTRESET}"
sleep 1

python3 /root/.meraki_mon_wlc/update_physical_address_ap.py

echo "${GREEN}Script Complete${TEXTRESET}"
rm -r /root/.meraki_mon_wlc/address.txt
rm -r /root/.meraki_mon_wlc/ap_serials.txt
sleep 1
