#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

clear
cat <<EOF
${GREEN}Update Physical Address on WLC${TEXTRESET}
This will allow you to update Physical Address of the WLC and Move the Map Marker 

Please provide the Physical address in the correct format:
(i.e. 123 AnyStreet St. City State ZIP)

EOF

read -p "Please provide the Address you would like to use: " ADDR
while [ -z "$USER" ]; do
  echo ${RED}"The response cannot be blank. Please Try again${TEXTRESET}"
  read -p "Please provide the Address you would like to use: " ADDR
done
clear
cat <<EOF
${GREEN}Updating the WLC Physical address with: ${ADDR} ${TEXTRESET}

EOF
sleep 1

sed -i '0,/new_address = /{/new_address = /d;}' /root/.meraki_mon_wlc/update_physical_address_wlc.py
echo new_address = "\"${ADDR}\"" >/root/.meraki_mon_wlc/address.txt
sed -i '32 r /root/.meraki_mon_wlc/address.txt' /root/.meraki_mon_wlc/update_physical_address_wlc.py

INPUT="/root/.meraki_mon_wlc/ip_list"

# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo "$IP"
  cat /var/lib/tftpboot/wlc/$IP-wlc_mon_summ | grep -E -o "Q.{0,13}" >>/root/.meraki_mon_wlc/wlc_serials.txt

done <"$INPUT"

python3 /root/.meraki_mon_wlc/update_physical_address_wlc.py

rm -r /root/.meraki_mon_wlc/address.txt
rm -r /root/.meraki_mon_wlc/wlc_serials.txt
