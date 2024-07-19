#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
IP=$(hostname -I)
clear
cat <<EOF
${GREEN}Download AP inventory${TEXTRESET}
This will allow you to download the Whole AP inventory to csv and update AP addresses per your liking

EOF

read -p "Press Any Key to Continue"
clear
echo "Creating the CSV File"
sleep 1

/root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.exp

cp -v /var/lib/tftpboot/wlc/ap_mon_summ /root/.meraki_mon_wlc/ap_mon_summ
#Remove spaces
tr -s ' ' </root/.meraki_mon_wlc/ap_mon_summ >/root/.meraki_mon_wlc/ap_mon_clean
#Insert commas
sed -e "s/ /,/g" </root/.meraki_mon_wlc/ap_mon_clean >>/root/.meraki_mon_wlc/ap_mon_final.csv
#Remove trash at the top
sed -i 1,6d /root/.meraki_mon_wlc/ap_mon_final.csv

mkdir /root/wlc_ap_inventory

mv -f /root/.meraki_mon_wlc/ap_mon_final.csv /root/wlc_ap_inventory/ap_inventory.csv

#Cleanup
rm -r -f /root/.meraki_mon_wlc/ap_mon_summ
rm -r -f /root/.meraki_mon_wlc/ap_mon_final.csv
rm -r -f /root/.meraki_mon_wlc/ap_mon_clean

clear
cat <<EOF
The Inventory File can be located in:

${YELLOW}/root/wlc_ap_inventory/ap_inventory.csv${TEXTRESET}

Please use the Navigator plugin or SCP to download the file for review

EOF

echo "https://$IP:9090/=$IP/navigator" | tr -d '[:blank:]'
echo " "

read -p "Press Any Key to Exit"
