#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update Physical Address on AP${TEXTRESET}
This will allow you to update Physical Address of the AP and Move the Map Marker 

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

cat /var/lib/tftpboot/wlc/ap_mon_summ | cat /var/lib/tftpboot/wlc/ap_mon_summ | cut -c108- | cut -c-14 | grep -E -o "Q.{0,13}" >>/root/.meraki_mon_wlc/ap_serials.txt

clear
echo "${GREEN}Deploying Script${TEXTRESET}"
sleep 1

python3 /root/.meraki_mon_wlc/update_physical_address_ap.py

echo "${GREEN}Script Complete${TEXTRESET}"
rm -r /root/.meraki_mon_wlc/address.txt
rm -r /root/.meraki_mon_wlc/ap_serials.txt
sleep 1
