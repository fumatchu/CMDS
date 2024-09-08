#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
IP=$(hostname -I)
INPUT="/root/.meraki_mon_wlc/ip_list"
clear
cat <<EOF
${GREEN}Download AP inventory${TEXTRESET}
This will allow you to download the Whole AP inventory to csv and update AP addresses per your liking

EOF

read -p "Press Enter to Continue"
clear
echo "Creating the CSV File"
echo "Please Wait"

/root/.meraki_mon_wlc/sh_ap_meraki_mon_summ.exp > /dev/null 2>&1

#cp -v /var/lib/tftpboot/wlc/ap_mon_summ /root/.meraki_mon_wlc/ap_mon_summ
#Remove the Trash at the TOP of Each file
sed -i 1,6d /var/lib/tftpboot/wlc/*-ap_mon_summ

Add a space
#sed -i '1s/.*/ &/' /var/lib/tftpboot/wlc/*-ap_mon_summ


while read -r IP; do
sed -i '1s/^/'"$IP"' \n/' /var/lib/tftpboot/wlc/${IP}-ap_mon_summ
done <"$INPUT"


# Read file line-by-line to get an IP address
while read -r IP; do
echo "$IP"


tr -s ' ' </var/lib/tftpboot/wlc/${IP}-ap_mon_summ >>/root/.meraki_mon_wlc/ap_mon_clean
done <"$INPUT"

#Insert commas
sed -e "s/ /,/g" </root/.meraki_mon_wlc/ap_mon_clean >>/root/.meraki_mon_wlc/ap_mon_final.csv

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

read -p "Press Enter to Exit"
