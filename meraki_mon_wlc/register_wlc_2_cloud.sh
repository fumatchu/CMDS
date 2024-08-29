#!/bin/bash
#Set the command ip name-server
TEXTRESET=$(tput sgr0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
INPUT="/root/.meraki_mon_wlc/ip_list"
clear
cat <<EOF
${GREEN}Register WLC to Cloud${TEXTRESET}
This will register the WLC to the Cloud

EOF

read -p "Press Enter"

/root/.meraki_mon_wlc/register_wlc_2_cloud.exp

clear

cat <<EOF
${YELLOW}Waiting for WLC Registration${TEXTRESET}
EOF

echo "Please Wait..."
i=45;while [ $i -gt 0 ];do if [ $i -gt 9 ];then printf "\b\b$i";else  printf "\b\b $i";fi;sleep 1;i=`expr $i - 1`;done
clear
/root/.meraki_mon_wlc/register_wlc_2_cloud_check.exp

clear

cat <<EOF
${GREEN}Current status of WLC Registration${TEXTRESET}
EOF
# Read file line-by-line to get an IP address
while read -r IP; do
  # Print the IP address to the console
  echo ${GREEN}"$IP"${TEXTRESET}
  echo " "
cat /var/lib/tftpboot/wlc/${IP}-sh-meraki-connect | grep "Fetch State"
echo " "
sleep 2
cat /var/lib/tftpboot/wlc/${IP}-sh-meraki-connect | grep "Meraki Tunnel State" -A 3
echo " "
sleep 2
cat /var/lib/tftpboot/wlc/${IP}-sh-meraki-connect | grep "Meraki Tunnel Config" -A 8
echo " "
sleep 2
cat /var/lib/tftpboot/wlc/${IP}-sh-meraki-connect | grep "Meraki Device Registration" -A 9
echo " "
sleep 2
clear
done <"$INPUT"
